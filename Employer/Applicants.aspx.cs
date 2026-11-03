using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JobFinder.Employer
{
    public partial class Applicants : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        string str = ConfigurationManager.ConnectionStrings["JobFinderDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Ensure employer is logged in (consistent with your other pages)
            if (Session["employer"] == null)
            {
                Response.Redirect("~/User/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                // Back link keeps jobId context
                string jobIdQS = Request.QueryString["jobId"];
                linkBack.NavigateUrl = string.IsNullOrEmpty(jobIdQS)
                    ? "~/Employer/PostedJobs.aspx"
                    : ("~/Employer/PostedJobs.aspx?id=" + jobIdQS);

                int jobId;
                if (!int.TryParse(Request.QueryString["jobId"], out jobId))
                {
                    lblMsg.Text = "Invalid or missing JobId.";
                    lblMsg.CssClass = "alert alert-danger";
                    BindEmpty();
                    return;
                }

                PopulateMinRating();
                PopulateCountries();         // <-- now loads from [Country]
                ShowApplicants(jobId);       // uses selected filters
            }
        }

        // ========== Filters ==========
        private void PopulateMinRating()
        {
            ddlMinRating.Items.Clear();
            ddlMinRating.Items.Add(new ListItem("All", "")); // no filter
            for (int i = 0; i <= 10; i++)
                ddlMinRating.Items.Add(new ListItem(i + "+", i.ToString()));
            ddlMinRating.SelectedIndex = 0;
        }

        private void PopulateCountries()
        {
            // Assumes [Country] has a column named CountryName. If it's [Name], change the SELECT and rdr["CountryName"] accordingly.
            const string sql = @"SELECT CountryName FROM [Country] ORDER BY CountryName;";

            ddlCountry.Items.Clear();
            ddlCountry.Items.Add(new ListItem("All", "")); // no filter

            using (var con = new SqlConnection(str))
            using (var cmd = new SqlCommand(sql, con))
            {
                con.Open();
                using (var rdr = cmd.ExecuteReader())
                {
                    while (rdr.Read())
                    {
                        string country = Convert.ToString(rdr["CountryName"]);
                        if (!string.IsNullOrWhiteSpace(country))
                            ddlCountry.Items.Add(new ListItem(country, country));
                    }
                }
            }
            ddlCountry.SelectedIndex = 0;
        }

        private int GetJobIdFromQS()
        {
            int jobId;
            return int.TryParse(Request.QueryString["jobId"], out jobId) ? jobId : -1;
        }

        private int? GetMinRatingFilter()
        {
            if (string.IsNullOrWhiteSpace(ddlMinRating.SelectedValue)) return null;
            int v;
            return int.TryParse(ddlMinRating.SelectedValue, out v) ? v : (int?)null;
        }

        private string GetCountryFilter()
        {
            return ddlCountry.SelectedValue ?? "";
        }

        // ========== Data Bind ==========
        private void ShowApplicants(int jobId)
        {
            int? minRating = GetMinRatingFilter();   // null = no rating filter
            string country = GetCountryFilter();     // ""  = no country filter

            // AND logic: both filters apply together when set.
            const string sql = @"
                SELECT 
                    aj.JobId,
                    aj.UserId,
                    u.Name AS ApplicantName,
                    ISNULL(r.Rating, 0) AS Rating,
                    u.Country
                FROM AppliedJobs aj
                INNER JOIN [User] u 
                    ON aj.UserId = u.UserId
                LEFT JOIN (
                    SELECT ReceiverUserId, AVG(CAST(Rating AS DECIMAL(4,2))) AS Rating
                    FROM Review
                    GROUP BY ReceiverUserId
                ) r ON r.ReceiverUserId = aj.UserId
                WHERE aj.JobId = @JobId
                  AND (@Country = '' OR u.Country = @Country)                -- Country filter (AND)
                  AND (@MinRating IS NULL OR ISNULL(r.Rating, 0) >= @MinRating) -- Min rating filter (AND)
                ORDER BY u.Name;";

            using (con = new SqlConnection(str))
            using (cmd = new SqlCommand(sql, con))
            using (var sda = new SqlDataAdapter(cmd))
            {
                cmd.Parameters.AddWithValue("@JobId", jobId);
                cmd.Parameters.AddWithValue("@Country", country);

                var p = cmd.Parameters.Add("@MinRating", SqlDbType.Decimal);
                if (minRating.HasValue)
                {
                    p.Value = minRating.Value;
                    p.Precision = 4; // 00.00
                    p.Scale = 2;
                }
                else
                {
                    p.Value = DBNull.Value;
                }

                var dt = new DataTable();
                sda.Fill(dt);

                GridViewApplicants.DataSource = dt;
                GridViewApplicants.DataBind();

                if (dt.Rows.Count == 0)
                {
                    lblMsg.Text = "No applicants found for the selected filters.";
                    lblMsg.CssClass = "alert alert-info";
                }
                else
                {
                    lblMsg.Text = string.Empty;
                    lblMsg.CssClass = string.Empty;
                }
            }
        }

        private void BindEmpty()
        {
            GridViewApplicants.DataSource = new DataTable();
            GridViewApplicants.DataBind();
        }

        // ========== Events ==========
        protected void btnApplyFilter_Click(object sender, EventArgs e)
        {
            int jobId = GetJobIdFromQS();
            if (jobId > 0) ShowApplicants(jobId);
        }

        protected void btnClearFilter_Click(object sender, EventArgs e)
        {
            ddlCountry.SelectedIndex = 0;
            ddlMinRating.SelectedIndex = 0;
            int jobId = GetJobIdFromQS();
            if (jobId > 0) ShowApplicants(jobId);
        }

        protected void GridViewApplicants_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridViewApplicants.PageIndex = e.NewPageIndex;
            int jobId = GetJobIdFromQS();
            if (jobId > 0) ShowApplicants(jobId);
            else BindEmpty();
        }

        // Handle Accept/Reject (unchanged)
        protected void GridViewApplicants_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "Accept" && e.CommandName != "Reject") return;

            int rowIndex = Convert.ToInt32(e.CommandArgument);
            var keys = GridViewApplicants.DataKeys[rowIndex];

            int userId = Convert.ToInt32(keys.Values["UserId"]);
            int jobId = Convert.ToInt32(keys.Values["JobId"]);

            // Need EmployerId to write Employees record
            int employerId;
            if (!int.TryParse(Convert.ToString(Session["employerId"]), out employerId))
            {
                lblMsg.Text = "Employer ID not found in session. Ensure Session[\"employerId\"] is set at login.";
                lblMsg.CssClass = "alert alert-warning";
                return;
            }

            try
            {
                using (var con = new SqlConnection(str))
                {
                    con.Open();
                    using (var tx = con.BeginTransaction())
                    {
                        if (e.CommandName == "Accept")
                        {
                            // Insert into Employees and remove from AppliedJobs
                            using (var insert = new SqlCommand(@"
                                IF NOT EXISTS (SELECT 1 FROM Employees WHERE EmployerId = @EmployerId AND EmployeesId = @EmployeeId)
                                BEGIN
                                    INSERT INTO Employees (EmployerId, EmployeesId)
                                    VALUES (@EmployerId, @EmployeeId);
                                END
                            ", con, tx))
                            {
                                insert.Parameters.AddWithValue("@EmployerId", employerId);
                                insert.Parameters.AddWithValue("@EmployeeId", userId); // EmployeesId column
                                insert.ExecuteNonQuery();
                            }
                        }

                        // For both Accept and Reject: remove from Applicants list
                        using (var del = new SqlCommand(@"
                            DELETE FROM AppliedJobs
                            WHERE JobId = @JobId AND UserId = @UserId;
                        ", con, tx))
                        {
                            del.Parameters.AddWithValue("@JobId", jobId);
                            del.Parameters.AddWithValue("@UserId", userId);
                            del.ExecuteNonQuery();
                        }

                        tx.Commit();
                    }
                }

                // Refresh grid (row disappears) with current filters still applied
                ShowApplicants(jobId);

                if (e.CommandName == "Accept")
                {
                    lblMsg.Text = "Applicant accepted and moved to Employees.";
                    lblMsg.CssClass = "alert alert-success";
                }
                else
                {
                    lblMsg.Text = "Applicant rejected.";
                    lblMsg.CssClass = "alert alert-info";
                }
            }
            catch (Exception ex)
            {
                lblMsg.Text = "Operation failed: " + ex.Message;
                lblMsg.CssClass = "alert alert-danger";
            }
        }
    }
}