using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using JobFinder;

namespace JobFinder.Admin
{
    public partial class AddNews : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        string str = System.Configuration.ConfigurationManager.ConnectionStrings["JobFinderDB"].ConnectionString;
        string query;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] == null)
            {
                Response.Redirect("../User/Login.aspx");
            }
            Session["title"] = "Add News";
            if (!IsPostBack)
            {
                fillData();
            }
        }
        private void fillData()
        {
            if (Request.QueryString["id"] != null)
            {
                con = new SqlConnection(str);
                query = "Select * from News where NewsId = '" + Request.QueryString["id"] + "' ";
                cmd = new SqlCommand(query, con);
                con.Open();
                SqlDataReader sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        txtNewsTitle.Text = sdr["NewsTitle"].ToString();
                        txtNewsText.Text = sdr["NewsText"].ToString();

                        btnAdd.Text = "Update";
                        linkBack.Visible = true;
                        Session["title"] = "Edit News";
                    }
                }
                else
                {
                    lblMsg.Text = "News not found!";
                    lblMsg.CssClass = "alert alert-danger";
                }
                sdr.Close();
                con.Close();
            }
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                string type, contactQuery, imagePath = string.Empty;
                bool isValidToExecute = false;
                con = new SqlConnection(str);
                if (Request.QueryString["id"] != null)
                {
                    if (fuNewsImg.HasFile)
                    {
                        if (Utils.IsValidExtension(fuNewsImg.FileName))
                        {
                            contactQuery = "NewsImg = @NewsImg,";
                        }
                        else
                        {
                            contactQuery = string.Empty;
                        }
                    }
                    else
                    {
                        contactQuery = string.Empty;
                    }
                    query = @"Update News set NewsTitle=@NewsTitle, NewsText=@NewsText " + contactQuery + @"where NewsId=@id";
                    type = "updated";

                    cmd = new SqlCommand(query, con);

                    cmd.Parameters.AddWithValue("@NewsTitle", txtNewsTitle.Text.Trim());
                    cmd.Parameters.AddWithValue("@NewsText", txtNewsText.Text.Trim());


                    cmd.Parameters.AddWithValue("@id", Request.QueryString["id"].ToString());
                    if (fuNewsImg.HasFile)
                    {
                        if (Utils.IsValidExtension(fuNewsImg.FileName))
                        {
                            Guid obj = Guid.NewGuid();
                            imagePath = "Images/" + obj.ToString() + fuNewsImg.FileName;
                            fuNewsImg.PostedFile.SaveAs(Server.MapPath("~/Images/") + obj.ToString() + fuNewsImg.FileName);

                            cmd.Parameters.AddWithValue("@NewsImg", imagePath);
                            isValidToExecute = true;
                        }
                        else
                        {
                            lblMsg.Text = "Please select .jpg, .jpeg, .png file for NewsImg";
                            lblMsg.CssClass = "alert alert-danger";
                        }
                    }
                    else
                    {
                        isValidToExecute = true;
                    }
                }
                else
                {
                    query = @"Insert into News values(@NewsTitle, @NewsText, @NewsImg, @CreateDate)";
                    type = "saved";
                    DateTime time = DateTime.Now;
                    cmd = new SqlCommand(query, con);

                    cmd.Parameters.AddWithValue("@NewsTitle", txtNewsTitle.Text.Trim());
                    cmd.Parameters.AddWithValue("@NewsText", txtNewsText.Text.Trim());


                    cmd.Parameters.AddWithValue("@CreateDate", time.ToString("yyyy-MM-dd HH:mm:ss"));
                    if (fuNewsImg.HasFile)
                    {
                        if (Utils.IsValidExtension(fuNewsImg.FileName))
                        {
                            Guid obj = Guid.NewGuid();
                            imagePath = "Images/" + obj.ToString() + fuNewsImg.FileName;
                            fuNewsImg.PostedFile.SaveAs(Server.MapPath("~/Images/") + obj.ToString() + fuNewsImg.FileName);

                            cmd.Parameters.AddWithValue("@NewsImg", imagePath);
                            isValidToExecute = true;
                        }
                        else
                        {
                            lblMsg.Text = "Please select .jpg, .jpeg, .png file for NewsImg";
                            lblMsg.CssClass = "alert alert-danger";
                        }
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("NewsImg", imagePath);
                        isValidToExecute = true;
                    }
                }
                if (isValidToExecute)
                {
                    con.Open();
                    int res = cmd.ExecuteNonQuery();
                    if (res > 0)
                    {
                        lblMsg.Text = "News " + type + " successful!";
                        lblMsg.CssClass = "alert alert-success";
                        clear();
                    }
                    else
                    {
                        lblMsg.Text = "Cannot " + type + " the records, please try again!";
                        lblMsg.CssClass = "alert alert-danger";
                    }
                }

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
            finally
            {
                con.Close();
            }
        }
        private void clear()
        {
            txtNewsTitle.Text = string.Empty;
            txtNewsText.Text = string.Empty;

        }
    }
}