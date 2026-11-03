<%@ Page Title="" Language="C#" MasterPageFile="~/Employer/EmployerMaster.Master" AutoEventWireup="true" CodeBehind="Applicants.aspx.cs" Inherits="JobFinder.Employer.Applicants" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div style="background-image: url('../Images/bg.jpg'); width: 100%; min-height: 720px; background-repeat: no-repeat;
        background-size: cover; background-attachment: fixed;">
        <div class="container-fluid pt-4 pb-4">

            <div class="btn-toolbar justify-content-between mb-3">
                <div class="btn-group">
                    <asp:Label ID="lblMsg" runat="server"></asp:Label>
                </div>
                <div class="input-group h-25">
                    <asp:HyperLink ID="linkBack" runat="server" NavigateUrl="~/Employer/PostedJobs.aspx" CssClass="btn btn-secondary">
                        &lt; Back
                    </asp:HyperLink>
                </div>
            </div>

            <h3 class="text-center">Applicants</h3>

            <!-- Filters -->
            <div class="card mb-3">
                <div class="card-body">
                    <div class="row g-2 align-items-end">
                        <div class="col-sm-4">
                            <label for="ddlCountry" class="form-label">Country</label>
                            <asp:DropDownList ID="ddlCountry" runat="server" CssClass="form-select"></asp:DropDownList>
                        </div>
                        <div class="col-sm-4">
                            <label for="ddlMinRating" class="form-label">Minimum Rating</label>
                            <asp:DropDownList ID="ddlMinRating" runat="server" CssClass="form-select"></asp:DropDownList>
                        </div>
                        <div class="col-sm-4">
                            <asp:Button ID="btnApplyFilter" runat="server" CssClass="btn btn-primary me-2" Text="Apply Filter" OnClick="btnApplyFilter_Click" />
                            <asp:Button ID="btnClearFilter" runat="server" CssClass="btn btn-outline-secondary" Text="Clear" OnClick="btnClearFilter_Click" />
                        </div>
                    </div>
                </div>
            </div>

            <div class="row mb-3 pt-sm-3">
                <div class="col-md-12">
                    <asp:GridView ID="GridViewApplicants" runat="server" CssClass="table table-hover table-bordered"
                        EmptyDataText="No applicants to display" AutoGenerateColumns="False" AllowPaging="True" PageSize="5"
                        DataKeyNames="UserId,JobId"
                        OnPageIndexChanging="GridViewApplicants_PageIndexChanging"
                        OnRowCommand="GridViewApplicants_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="ApplicantName" HeaderText="Applicant Name">
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:BoundField>

                            <asp:BoundField DataField="Rating" HeaderText="Rating" DataFormatString="{0:0.0}" HtmlEncode="false">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>

                            <asp:TemplateField HeaderText="View Profile">
                                <ItemTemplate>
                                    <a href='<%# ResolveUrl("~/Employer/ApplicantProfile.aspx") + "?userId=" + Eval("UserId") + "&jobId=" + Eval("JobId") %>'
                                       title="Click to View Applicants">
                                    <img src='<%# ResolveUrl("~/Images/user.png") %>' alt="Applicants" style="width:20px; height:20px;" />
                                    </a>
                                </ItemTemplate>

                                
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <%-- Actions column: Accept / Reject --%>
                            <asp:TemplateField HeaderText="Actions">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnAccept" runat="server" CausesValidation="false"
                                            
                                            CommandName="Accept"
                                            CommandArgument='<%# ((GridViewRow)Container).RowIndex %>'
                                            ToolTip="Accept">
                                            <img src='<%# ResolveUrl("~/Images/accept.png") %>' alt="Accept" style="width:20px; height:20px;" />
                                        </asp:LinkButton>

                                        <asp:LinkButton ID="btnReject" runat="server" CausesValidation="false"
                                           
                                            CommandName="Reject"
                                            CommandArgument='<%# ((GridViewRow)Container).RowIndex %>'
                                            ToolTip="Reject">
                                            <img src='<%# ResolveUrl("~/Images/cross.png") %>' alt="Reject" style="width:20px; height:20px;" />
                                        </asp:LinkButton>
                                    </ItemTemplate>

                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>

                        </Columns>
                        <HeaderStyle BackColor="#000000" ForeColor="white" />
                    </asp:GridView>
                </div>
            </div>

        </div>
    </div>

</asp:Content>