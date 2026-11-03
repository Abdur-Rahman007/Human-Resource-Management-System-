using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace JobFinder.Employer
{
    public partial class AddReview : System.Web.UI.Page
    {
        string str = ConfigurationManager.ConnectionStrings["JobFinderDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Auth
            if (Session["employer"] == null)
            {
                Response.Redirect("~/User/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                // Back to list
                linkBack.NavigateUrl = "~/Employer/EmployeeList.aspx";

                // Get receiverId from QS and load user info
                int receiverId;
                if (!int.TryParse(Request.QueryString["receiverId"], out receiverId))
                {
                    lblMsg.Text = "Missing or invalid employee id.";
                    lblMsg.CssClass = "alert alert-danger";
                    btnSubmit.Enabled = false;
                    return;
                }
                hfReceiverId.Value = receiverId.ToString();

                PopulateRating();
                LoadEmployee(receiverId);
            }
        }

        private void PopulateRating()
        {
            ddlRating.Items.Clear();
            for (int i = 0; i <= 10; i++)
            {
                ddlRating.Items.Add(i.ToString());
            }
            ddlRating.SelectedValue = "10"; // default
        }

        private void LoadEmployee(int userId)
        {
            const string sql = @"SELECT Name, Email FROM [User] WHERE UserId = @id;";

            using (var con = new SqlConnection(str))
            using (var cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@id", userId);
                con.Open();
                using (var rdr = cmd.ExecuteReader())
                {
                    if (rdr.Read())
                    {
                        string name = Convert.ToString(rdr["Name"]);
                        string email = Convert.ToString(rdr["Email"]);
                        lblEmployeeName.Text = string.IsNullOrEmpty(email) ? name : $"{name} ({email})";
                        lblMsg.Text = string.Empty;
                        lblMsg.CssClass = string.Empty;
                    }
                    else
                    {
                        lblEmployeeName.Text = "(not found)";
                        lblMsg.Text = "Employee not found.";
                        lblMsg.CssClass = "alert alert-warning";
                        btnSubmit.Enabled = false;
                    }
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // Giver = current employer user id
            int giverUserId;
            if (!int.TryParse(Convert.ToString(Session["employer"]), out giverUserId))
            {
                // fallback if your app stored numeric id in employerId
                int.TryParse(Convert.ToString(Session["employerId"]), out giverUserId);
            }

            int receiverUserId;
            int rating;
            if (!int.TryParse(hfReceiverId.Value, out receiverUserId))
            {
                lblMsg.Text = "Invalid employee id.";
                lblMsg.CssClass = "alert alert-danger";
                return;
            }
            if (!int.TryParse(ddlRating.SelectedValue, out rating) || rating < 0 || rating > 10)
            {
                lblMsg.Text = "Rating must be between 0 and 10.";
                lblMsg.CssClass = "alert alert-danger";
                return;
            }

            string reviewText = (txtReview.Text ?? "").Trim();
            if (string.IsNullOrEmpty(reviewText))
            {
                lblMsg.Text = "Please enter a review.";
                lblMsg.CssClass = "alert alert-danger";
                return;
            }

            try
            {
                using (var con = new SqlConnection(str))
                using (var cmd = new SqlCommand(@"
                    INSERT INTO Review (GiverUserId, ReceiverUserId, Review, Rating)
                    VALUES (@GiverUserId, @ReceiverUserId, @Review, @Rating);
                ", con))
                {
                    cmd.Parameters.AddWithValue("@GiverUserId", giverUserId);
                    cmd.Parameters.AddWithValue("@ReceiverUserId", receiverUserId);
                    cmd.Parameters.AddWithValue("@Review", reviewText);
                    cmd.Parameters.AddWithValue("@Rating", rating);

                    con.Open();
                    cmd.ExecuteNonQuery();

                    lblMsg.Text = "Review submitted successfully.";
                    lblMsg.CssClass = "alert alert-success";

                    // optional: clear form
                    ddlRating.SelectedValue = "10";
                    txtReview.Text = string.Empty;
                }
            }
            catch (Exception ex)
            {
                lblMsg.Text = "Failed to submit review: " + ex.Message;
                lblMsg.CssClass = "alert alert-danger";
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ddlRating.SelectedValue = "10";
            txtReview.Text = string.Empty;
            lblMsg.Text = string.Empty;
            lblMsg.CssClass = string.Empty;
        }
    }
}
