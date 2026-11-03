using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using JobFinder;

namespace JobFinder.Employer
{
    public partial class NewJob : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        string str = ConfigurationManager.ConnectionStrings["JobFinderDB"].ConnectionString;
        string query;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["employer"] == null)
            {
                Response.Redirect("../User/Login.aspx");
                return;
            }

            Session["title"] = "Add Job";

            if (!IsPostBack)
            {
                fillData();
                ddlCountry.DataBind();

                // If editing, change button text
                if (Request.QueryString["id"] != null)
                {
                    btnProceed.Text = "Update";
                    linkBack.Visible = true;
                    Session["title"] = "Edit Job";
                }
            }
        }

        private void fillData()
        {
            if (Request.QueryString["id"] != null)
            {
                using (con = new SqlConnection(str))
                using (cmd = new SqlCommand("SELECT * FROM Jobs WHERE JobId = @id", con))
                {
                    cmd.Parameters.AddWithValue("@id", Request.QueryString["id"]);
                    con.Open();
                    var sdr = cmd.ExecuteReader();
                    if (sdr.Read())
                    {
                        txtJobTitle.Text = Convert.ToString(sdr["Title"]);
                        txtNoOfPost.Text = Convert.ToString(sdr["NoOfPost"]);
                        txtDescription.Text = Convert.ToString(sdr["Description"]);
                        txtQualification.Text = Convert.ToString(sdr["Qualification"]);
                        txtExperience.Text = Convert.ToString(sdr["Experience"]);
                        txtSpecialization.Text = Convert.ToString(sdr["Specialization"]);
                        txtLastDate.Text = Convert.ToDateTime(sdr["LastDateToApply"]).ToString("yyyy-MM-dd");
                        txtSalary.Text = Convert.ToString(sdr["Salary"]);
                        ddlJobType.SelectedValue = Convert.ToString(sdr["JobType"]);
                        txtCompany.Text = Convert.ToString(sdr["CompanyName"]);
                        txtWebsite.Text = Convert.ToString(sdr["Website"]);
                        txtEmail.Text = Convert.ToString(sdr["Email"]);
                        txtAddress.Text = Convert.ToString(sdr["Address"]);
                        ddlCountry.SelectedValue = Convert.ToString(sdr["Country"]);
                        txtState.Text = Convert.ToString(sdr["State"]);
                    }
                    else
                    {
                        lblMsg.Text = "Job not found!";
                        lblMsg.CssClass = "alert alert-danger";
                    }
                }
            }
        }

        protected void btnProceed_Click(object sender, EventArgs e)
        {
            // If editing: do the old Update in-place (no payment)
            if (Request.QueryString["id"] != null)
            {
                UpdateExistingJob();
                return;
            }

            // New job flow: validate, stash fields in Session, save logo (if any), go to Payment page
            if (!ValidateInputs())
                return;

            string imagePath = SaveLogoOrGetExistingPath();
            if (imagePath == null)
                return; // invalid file selected; error shown already

            // Stash all fields in Session (draft)
            Session["JobDraft_Title"] = txtJobTitle.Text.Trim();
            Session["JobDraft_NoOfPost"] = txtNoOfPost.Text.Trim();
            Session["JobDraft_Description"] = txtDescription.Text.Trim();
            Session["JobDraft_Qualification"] = txtQualification.Text.Trim();
            Session["JobDraft_Experience"] = txtExperience.Text.Trim();
            Session["JobDraft_Specialization"] = txtSpecialization.Text.Trim();
            Session["JobDraft_LastDateToApply"] = txtLastDate.Text.Trim(); // yyyy-MM-dd
            Session["JobDraft_Salary"] = txtSalary.Text.Trim();
            Session["JobDraft_JobType"] = ddlJobType.SelectedValue;
            Session["JobDraft_CompanyName"] = txtCompany.Text.Trim();
            Session["JobDraft_CompanyImage"] = imagePath ?? string.Empty;
            Session["JobDraft_Website"] = txtWebsite.Text.Trim();
            Session["JobDraft_Email"] = txtEmail.Text.Trim();
            Session["JobDraft_Address"] = txtAddress.Text.Trim();
            Session["JobDraft_Country"] = ddlCountry.SelectedValue;
            Session["JobDraft_State"] = txtState.Text.Trim();

            Response.Redirect("~/Employer/Payment.aspx");
        }

        private bool ValidateInputs()
        {
            if (ddlJobType.SelectedValue == "0")
            {
                lblMsg.Text = "Job Type is required.";
                lblMsg.CssClass = "alert alert-danger";
                return false;
            }
            if (ddlCountry.SelectedValue == "0")
            {
                lblMsg.Text = "Country is required.";
                lblMsg.CssClass = "alert alert-danger";
                return false;
            }
            return true;
        }

        private string SaveLogoOrGetExistingPath()
        {
            string imagePath = string.Empty;

            if (fuCompanyLogo.HasFile)
            {
                if (!Utils.IsValidExtension(fuCompanyLogo.FileName))
                {
                    lblMsg.Text = "Please select .jpg, .jpeg, .png file for logo";
                    lblMsg.CssClass = "alert alert-danger";
                    return null;
                }

                Guid obj = Guid.NewGuid();
                imagePath = "Images/" + obj + fuCompanyLogo.FileName;
                fuCompanyLogo.PostedFile.SaveAs(Server.MapPath("~/Images/") + obj + fuCompanyLogo.FileName);
            }

            return imagePath;
        }

        private void UpdateExistingJob()
        {
            string imagePath = null;
            string contactQuery = string.Empty;

            if (fuCompanyLogo.HasFile)
            {
                if (!Utils.IsValidExtension(fuCompanyLogo.FileName))
                {
                    lblMsg.Text = "Please select .jpg, .jpeg, .png file for logo";
                    lblMsg.CssClass = "alert alert-danger";
                    return;
                }
                Guid obj = Guid.NewGuid();
                imagePath = "Images/" + obj + fuCompanyLogo.FileName;
                fuCompanyLogo.PostedFile.SaveAs(Server.MapPath("~/Images/") + obj + fuCompanyLogo.FileName);
                contactQuery = "CompanyImage = @CompanyImage,";
            }

            query = @"
                UPDATE Jobs SET
                    Title=@Title, NoOfPost=@NoOfPost, Description=@Description, Qualification=@Qualification,
                    Experience=@Experience, Specialization=@Specialization, LastDateToApply=@LastDateToApply,
                    Salary=@Salary, JobType=@JobType, CompanyName=@CompanyName, " + contactQuery + @"
                    Website=@Website, Email=@Email, Address=@Address, Country=@Country, State=@State
                WHERE JobId=@id;";

            using (con = new SqlConnection(str))
            using (cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@Title", txtJobTitle.Text.Trim());
                cmd.Parameters.AddWithValue("@NoOfPost", (object)txtNoOfPost.Text.Trim());
                cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());
                cmd.Parameters.AddWithValue("@Qualification", txtQualification.Text.Trim());
                cmd.Parameters.AddWithValue("@Experience", txtExperience.Text.Trim());
                cmd.Parameters.AddWithValue("@Specialization", txtSpecialization.Text.Trim());
                cmd.Parameters.AddWithValue("@LastDateToApply", txtLastDate.Text.Trim());
                cmd.Parameters.AddWithValue("@Salary", txtSalary.Text.Trim());
                cmd.Parameters.AddWithValue("@JobType", ddlJobType.SelectedValue);
                cmd.Parameters.AddWithValue("@CompanyName", txtCompany.Text.Trim());
                cmd.Parameters.AddWithValue("@Website", txtWebsite.Text.Trim());
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());
                cmd.Parameters.AddWithValue("@Country", ddlCountry.SelectedValue);
                cmd.Parameters.AddWithValue("@State", txtState.Text.Trim());
                cmd.Parameters.AddWithValue("@id", Request.QueryString["id"]);

                if (!string.IsNullOrEmpty(contactQuery))
                {
                    cmd.Parameters.AddWithValue("@CompanyImage", imagePath);
                }

                con.Open();
                int r = cmd.ExecuteNonQuery();
                if (r > 0)
                {
                    lblMsg.Text = "Job updated successfully!";
                    lblMsg.CssClass = "alert alert-success";
                }
                else
                {
                    lblMsg.Text = "Cannot update the record!";
                    lblMsg.CssClass = "alert alert-danger";
                }
            }
        }
    }
}
