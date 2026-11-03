<%@ Page Title="" Language="C#" MasterPageFile="~/Employer/EmployerMaster.Master" AutoEventWireup="true" CodeBehind="AddReview.aspx.cs" Inherits="JobFinder.Employer.AddReview" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container pt-4 pb-5">
        <div class="btn-toolbar justify-content-between mb-3">
            <div class="btn-group">
                <asp:Label ID="lblMsg" runat="server"></asp:Label>
            </div>
            <div class="input-group h-25">
                <asp:HyperLink ID="linkBack" runat="server" NavigateUrl="~/Employer/EmployeeList.aspx" CssClass="btn btn-secondary">
                    &lt; Back
                </asp:HyperLink>
            </div>
        </div>

        <h3 class="mb-3">Add Review</h3>

        <div class="card">
            <div class="card-body">
                <div class="mb-3">
                    <strong>Employee:</strong>
                    <asp:Label ID="lblEmployeeName" runat="server" CssClass="ms-2"></asp:Label>
                    <asp:HiddenField ID="hfReceiverId" runat="server" />
                </div>

                <div class="row g-3">
                    <div class="col-md-3">
                        <label for="ddlRating" class="form-label">Rating (0–10)</label>
                        <asp:DropDownList ID="ddlRating" runat="server" CssClass="form-select"></asp:DropDownList>
                    </div>
                    <div class="col-md-9">
                        <label for="txtReview" class="form-label">Review</label>
                        <asp:TextBox ID="txtReview" runat="server" TextMode="MultiLine" Rows="5" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>

                <div class="mt-4">
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit Review" CssClass="btn btn-primary me-2" OnClick="btnSubmit_Click" />
                    <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-outline-secondary" OnClick="btnClear_Click" CausesValidation="false" />
                </div>
            </div>
        </div>
    </div>

</asp:Content>
