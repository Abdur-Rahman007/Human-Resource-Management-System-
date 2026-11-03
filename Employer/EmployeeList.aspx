<%@ Page Title="" Language="C#" MasterPageFile="~/Employer/EmployerMaster.Master" AutoEventWireup="true" CodeBehind="EmployeeList.aspx.cs" Inherits="JobFinder.Employer.EmployeeList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="background-image: url('../Images/bg.jpg'); width: 100%; height: 720px; background-repeat: no-repeat;
        background-size: cover; background-attachment: fixed;">
        <div class="container-fluid pt-4 pb-4">
            <div>
                <asp:Label ID="lblMsg" runat="server"></asp:Label>
            </div>

            <h3 class="text-center">Employee List</h3>

            <div class="row mb-3 pt-sm-3">
                <div class="col-md-12">
                    <asp:GridView ID="GridView1" runat="server" CssClass="table table-hover table-bordered" HeaderStyle-HorizontalAlign="Center"
                        EmptyDataText="No record to display" AutoGenerateColumns="False" AllowPaging="True" PageSize="5"
                        OnPageIndexChanging="GridView1_PageIndexChanging"
                        DataKeyNames="EmployerId,EmployeesId"
                        OnRowDeleting="GridView1_RowDeleting">
                        <Columns>
                            <asp:BoundField DataField="Sr.No" HeaderText="Sr.No">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>

                            <asp:BoundField DataField="Name" HeaderText="User Name">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>

                            <asp:BoundField DataField="Email" HeaderText="Email">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>

                            <asp:BoundField DataField="Mobile" HeaderText="Mobile Number">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>

                            <asp:BoundField DataField="Country" HeaderText="Country">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>

                            <%-- NEW: Add Review column --%>
                            <asp:TemplateField HeaderText="Add Review">
                                <ItemTemplate>
                                    <a href='<%# ResolveUrl("~/Employer/AddReview.aspx") + "?receiverId=" + Eval("EmployeesId") %>'
                                       class="btn btn-sm btn-outline-primary" title="Add Review">
                                         <img src='<%# ResolveUrl("~/Images/review.png") %>' alt="Applicants" style="width:20px; height:20px;" />
                                    </a>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:CommandField CausesValidation="false" HeaderText="Delete" ShowDeleteButton="true"
                                DeleteImageUrl="../Images/bin.png" ButtonType="Image">
                                <ControlStyle Height="25px" Width="25px" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:CommandField>
                        </Columns>
                        <HeaderStyle BackColor="#000000" ForeColor="white" />
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
