using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace JobFinder.Employer
{
    public partial class ApplicantProfile : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        string str = ConfigurationManager.ConnectionStrings["JobFinderDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Employer auth (aligned with your other Employer pages)
            if (Session["employer"] == null)
            {
                Response.Redirect("~/User/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                // Back link preserves jobId if provided
                string jobId = Request.QueryString["jobId"];
                linkBack.NavigateUrl = string.IsNullOrEmpty(jobId)
                    ? "~/Employer/Applicants.aspx"
                    : ("~/Employer/Applicants.aspx?jobId=" + jobId);

                // Load target applicant by userId from query
                int userId;
                if (!int.TryParse(Request.QueryString["userId"], out userId))
                {
                    lblMsg.Text = "Invalid or missing userId.";
                    lblMsg.CssClass = "alert alert-danger";
                    BindEmpty();
                    return;
                }

                ShowApplicantProfile(userId);
                BindReviews();
            }
        }

        private void ShowApplicantProfile(int userId)
        {
            using (con = new SqlConnection(str))
            using (cmd = new SqlCommand(@"
                SELECT UserId, Username, Name, Address, Mobile, Email, School, Department, Title, Country, Resume
                FROM [User]
                WHERE UserId = @userId;", con))
            {
                cmd.Parameters.AddWithValue("@userId", userId);
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    dlProfile.DataSource = dt;
                    dlProfile.DataBind();
                    lblMsg.Text = string.Empty;
                    lblMsg.CssClass = string.Empty;
                }
                else
                {
                    lblMsg.Text = "Applicant not found.";
                    lblMsg.CssClass = "alert alert-info";
                    BindEmpty();
                }
            }
        }
        private void BindReviews()
        {
            string str = ConfigurationManager.ConnectionStrings["JobFinderDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(str))
            {
                string query = "SELECT  U.Username AS GiverUsername,R.Review, R.Rating FROM Review R JOIN [User] U   ON R.GiverUserId = U.UserId WHERE R.ReceiverUserId = @UserId;";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    int userId;
                    if (!int.TryParse(Request.QueryString["userId"], out userId))
                    {
                        lblMsg.Text = "Invalid or missing userId.";
                        lblMsg.CssClass = "alert alert-danger";
                        BindEmpty();
                        return;
                    }
                    cmd.Parameters.AddWithValue("@UserId", userId);

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        gvReviews.DataSource = dt;
                        gvReviews.DataBind();
                    }
                }
            }
        }

        protected void gvReviews_PageIndexChanging(object sender, System.Web.UI.WebControls.GridViewPageEventArgs e)
        {
            gvReviews.PageIndex = e.NewPageIndex;
            BindReviews(); // Rebind data
        }

        private void BindEmpty()
        {
            dlProfile.DataSource = new DataTable();
            dlProfile.DataBind();
        }
    }
}
