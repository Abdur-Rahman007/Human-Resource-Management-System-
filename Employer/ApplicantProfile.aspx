<%@ Page Title="" Language="C#" MasterPageFile="~/Employer/EmployerMaster.Master" AutoEventWireup="true" CodeBehind="ApplicantProfile.aspx.cs" Inherits="JobFinder.Employer.ApplicantProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container pt-5 pb-5">
        <div class="main-body">

            <div class="btn-toolbar justify-content-between mb-3">
                <div class="btn-group">
                    <asp:Label ID="lblMsg" runat="server"></asp:Label>
                </div>
                <div class="input-group h-25">
                    <asp:HyperLink ID="linkBack" runat="server" CssClass="btn btn-secondary">&lt; Back</asp:HyperLink>
                </div>
            </div>

            <!-- NOTE: Removed OnItemCommand and the entire left "Profile" (h5) card and the Edit button -->
            <asp:DataList ID="dlProfile" runat="server" Width="100%">
                <ItemTemplate>
                    <div class="row gutters-sm">
                        <!-- LEFT: avatar & basics (kept) -->
                        <div class="col-md-4 mb-3">
                            <div class="card">
                                <div class="card-body">
                                    <div class="d-flex flex-column align-items-center text-center">
                                        <img src="../Images/profile-icon.jpg" alt="UserPic" class="rounded-circle" width="150" />
                                        <div class="mt-3">
                                            <h4 class="text-capitalize"><%# Eval("Name") %></h4>
                                            <p class="text-secondary mb-1"><%# Eval("Username") %></p>
                                            <p class="text-muted font-size-sm text-capitalize">
                                                <i class="fas fa-map-marker-alt"></i> <%# Eval("Country") %>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- REMOVED: the second card with <h5>Profile</h5> and its buttons -->
                        </div>

                        <!-- RIGHT: detail fields (kept) -->
                        <div class="col-md-8">
                            <div class="card mb-3">
                                <div class="card-body">

                                    <div class="row">
                                        <div class="col-sm-3">
                                            <h6 class="mb-0">Full Name</h6>
                                        </div>
                                        <div class="col-sm-9 text-secondary text-capitalize">
                                            <%# Eval("Name") %>
                                        </div>
                                    </div>
                                    <hr />

                                    <div class="row">
                                        <div class="col-sm-3">
                                            <h6 class="mb-0">Email</h6>
                                        </div>
                                        <div class="col-sm-9 text-secondary">
                                            <%# Eval("Email") %>
                                        </div>
                                    </div>
                                    <hr />

                                    <div class="row">
                                        <div class="col-sm-3">
                                            <h6 class="mb-0">Mobile</h6>
                                        </div>
                                        <div class="col-sm-9 text-secondary text-capitalize">
                                            <%# Eval("Mobile") %>
                                        </div>
                                    </div>
                                    <hr />

                                    <div class="row">
                                        <div class="col-sm-3">
                                            <h6 class="mb-0">Address</h6>
                                        </div>
                                        <div class="col-sm-9 text-secondary text-capitalize">
                                            <%# Eval("Address") %>
                                        </div>
                                    </div>
                                    <hr />

                                    <div class="row">
                                        <div class="col-sm-3">
                                            <h6 class="mb-0">School</h6>
                                        </div>
                                        <div class="col-sm-9 text-secondary text-capitalize">
                                            <%# Eval("School") %>
                                        </div>
                                    </div>
                                    <hr />

                                    <div class="row">
                                        <div class="col-sm-3">
                                            <h6 class="mb-0">Department</h6>
                                        </div>
                                        <div class="col-sm-9 text-secondary text-capitalize">
                                            <%# Eval("Department") %>
                                        </div>
                                    </div>
                                    <hr />

                                    <div class="row">
                                        <div class="col-sm-3">
                                            <h6 class="mb-0">Title</h6>
                                        </div>
                                        <div class="col-sm-9 text-secondary text-capitalize">
                                            <%# Eval("Title") %>
                                        </div>
                                    </div>

                                    <!-- REMOVED: Edit button row -->
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:DataList>
            
 <div class="card mb-3">
    <div class="card-body">
        <h5 class="text-center">User Reviews</h5>
        <asp:GridView ID="gvReviews" runat="server" CssClass="table table-hover table-bordered"
    HeaderStyle-HorizontalAlign="Center"
    EmptyDataText="No reviews yet" AutoGenerateColumns="False" AllowPaging="True" PageSize="5">
    <Columns>
        <asp:BoundField DataField="GiverUsername" HeaderText="Review From" />
        <asp:BoundField DataField="Review" HeaderText="Review" />
        <asp:BoundField DataField="Rating" HeaderText="Rating" />
    </Columns>
            </asp:GridView>

        </div>
    </div>

</asp:Content>
