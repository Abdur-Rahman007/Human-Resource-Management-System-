<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AddNews.aspx.cs" Inherits="JobFinder.Admin.AddNews" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div style="background-image: url('../Images/bg.jpg'); width: 100%; height: 720px; background-repeat: no-repeat;
        background-size: cover; background-attachment: fixed;">
        <div class="container pt-4 pb-4">           
            <div class="btn-toolbar justify-content-between mb-3">
                <div class="btn-group">
                    <asp:Label ID="lblMsg" runat="server"></asp:Label>
                </div>
                <div class="input-group h-25">
                    <asp:HyperLink ID="linkBack" runat="server" NavigateUrl="~/Admin/NewsList.aspx" CssClass="btn btn-secondary"
                        Visible="false">Back</asp:HyperLink>
                </div>
            </div>
            <h3 class="text-center"><%Response.Write(Session["title"]); %></h3>           
            <div class="row mr-lg-5 ml-lg-5 mb-3"> 
                <label for="txtNewsTitle" style="font-weight:600">News Title</label>
                <asp:TextBox ID="txtNewsTitle" runat="server" CssClass="form-control" placeholder="Enter News Title" required>
                </asp:TextBox>            
            </div>
            <div class="row mr-lg-5 ml-lg-5 mb-3">
                <label for="txtNewsText" style="font-weight:600">News Text</label>
                <asp:TextBox ID="txtNewsText" runat="server" CssClass="form-control" placeholder="Enter News Text" 
                    TextMode="MultiLine" required>
                </asp:TextBox>
            </div>             
            <div class="row mr-lg-5 ml-lg-5 mb-3"> 
                <div class="col-md-6 pt-3">
                    <label for="txtNewsTitle" style="font-weight:600">News Image</label>
                    <asp:FileUpload ID="fuNewsImg" runat="server" CssClass="form-control" ToolTip=".jpg, .jpeg, .png extension only" />
                </div>
            </div>                         
            <div class="row mr-lg-5 ml-lg-5 mb-3 pt-4">
                <div class="col-md-3 col-md-offset-2 mb-3">
                    <asp:Button ID="btnAdd" runat="server" CssClass="btn btn-primary btn-block" BackColor="#000000" Text="Add News"
                        OnClick="btnAdd_Click"/>
                </div>
            </div>
        </div>
    </div>
        
</asp:Content>