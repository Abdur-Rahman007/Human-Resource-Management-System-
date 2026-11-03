using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JobFinder.Employer
{
    public partial class EmployeeList : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        DataTable dt;
        string str = ConfigurationManager.ConnectionStrings["JobFinderDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Auth check
            if (Session["employer"] == null)
            {
                Response.Redirect("~/User/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                ShowEmployees();
            }
        }

        private int? GetEmployerId()
        {
            object val = Session["employerId"];
            if (val == null) return null;
            if (int.TryParse(val.ToString(), out int id)) return id;
            return null;
        }

        private void ShowEmployees()
        {
            int? employerId = GetEmployerId();
            if (employerId == null)
            {
                lblMsg.Text = "Employer ID not found. Please ensure Session[\"employerId\"] is set at login.";
                lblMsg.CssClass = "alert alert-warning";
                GridView1.DataSource = new DataTable();
                GridView1.DataBind();
                return;
            }

            string query = @"
                SELECT 
                    ROW_NUMBER() OVER (ORDER BY (SELECT 1)) AS [Sr.No],
                    e.EmployerId,
                    e.EmployeesId,
                    u.Name,
                    u.Email,
                    u.Mobile,
                    u.Country
                FROM Employees e
                INNER JOIN [User] u ON u.UserId = e.EmployeesId
                WHERE e.EmployerId = @EmployerId";

            using (con = new SqlConnection(str))
            using (cmd = new SqlCommand(query, con))
            using (var sda = new SqlDataAdapter(cmd))
            {
                cmd.Parameters.AddWithValue("@EmployerId", employerId.Value);
                dt = new DataTable();
                sda.Fill(dt);
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            ShowEmployees();
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                // Get keys (we stored both EmployerId and EmployeesId in DataKeyNames)
                int employerId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values["EmployerId"]);
                int employeesId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values["EmployeesId"]);

                using (con = new SqlConnection(str))
                using (cmd = new SqlCommand(@"DELETE FROM Employees WHERE EmployerId = @EmployerId AND EmployeesId = @EmployeesId;", con))
                {
                    cmd.Parameters.AddWithValue("@EmployerId", employerId);
                    cmd.Parameters.AddWithValue("@EmployeesId", employeesId);

                    con.Open();
                    int r = cmd.ExecuteNonQuery();

                    if (r > 0)
                    {
                        lblMsg.Text = "Employee removed successfully!";
                        lblMsg.CssClass = "alert alert-success";
                    }
                    else
                    {
                        lblMsg.Text = "Cannot delete this record!";
                        lblMsg.CssClass = "alert alert-danger";
                    }
                }

                GridView1.EditIndex = -1;
                ShowEmployees();
            }
            catch (Exception ex)
            {
                // Keep consistent with your style
                Response.Write("<script>alert('" + ex.Message.Replace("'", "\\'") + "');</script>");
            }
        }
    }
}

