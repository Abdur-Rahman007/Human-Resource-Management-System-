using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JobFinder.Admin
{
    public partial class PaymentHistory : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        DataTable dt;
        string str = ConfigurationManager.ConnectionStrings["JobFinderDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] == null)
            {
                Response.Redirect("../User/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                ShowPayments();
            }
        }

        private void ShowPayments()
        {
            const string query = @"
                SELECT 
                    P.PaymentId,
                    ROW_NUMBER() OVER (ORDER BY (SELECT 1)) AS [Sr.No],
                    U.Username AS [Name],
                    P.JobId,
                    P.PaymentAmount,
                    CONVERT(date, P.PaidAt) AS PaidDate,
                    CONVERT(varchar(8), CAST(P.PaidAt AS time(0))) AS PaidTime
                FROM dbo.Payment P
                INNER JOIN dbo.[User] U ON U.UserId = P.UserId;
            ";

            using (con = new SqlConnection(str))
            using (cmd = new SqlCommand(query, con))
            using (var sda = new SqlDataAdapter(cmd))
            {
                dt = new DataTable();
                sda.Fill(dt);
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            ShowPayments();
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int paymentId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);

                using (con = new SqlConnection(str))
                using (cmd = new SqlCommand("DELETE FROM dbo.Payment WHERE PaymentId = @id;", con))
                {
                    cmd.Parameters.AddWithValue("@id", paymentId);
                    con.Open();
                    int r = cmd.ExecuteNonQuery();

                    if (r > 0)
                    {
                        lblMsg.Text = "Payment record deleted successfully!";
                        lblMsg.CssClass = "alert alert-success";
                    }
                    else
                    {
                        lblMsg.Text = "Cannot delete this record!";
                        lblMsg.CssClass = "alert alert-danger";
                    }
                }

                GridView1.EditIndex = -1;
                ShowPayments();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message.Replace("'", "\\'") + "');</script>");
            }
        }
    }
}
