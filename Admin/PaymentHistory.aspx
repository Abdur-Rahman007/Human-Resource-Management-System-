<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.Master" AutoEventWireup="true" CodeBehind="PaymentHistory.aspx.cs" Inherits="JobFinder.Admin.PaymentHistory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div style="background-image: url('../Images/bg.jpg'); width: 100%; height: 720px; background-repeat: no-repeat;
        background-size: cover; background-attachment: fixed;">
        <div class="container-fluid pt-4 pb-4">
            <div>
                <asp:Label ID="lblMsg" runat="server"></asp:Label>
            </div>

            <h3 class="text-center">Payment History</h3>

            <div class="row mb-3 pt-sm-3">
                <div class="col-md-12">
                    <asp:GridView ID="GridView1" runat="server" CssClass="table table-hover table-bordered" HeaderStyle-HorizontalAlign="Center"
                        EmptyDataText="No record to display" AutoGenerateColumns="False" AllowPaging="True" PageSize="5"
                        OnPageIndexChanging="GridView1_PageIndexChanging"
                        DataKeyNames="PaymentId"
                        OnRowDeleting="GridView1_RowDeleting">
                        <Columns>

                            <asp:BoundField DataField="Sr.No" HeaderText="Sr.No">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>

                            <%-- Name comes from [User].Username --%>
                            <asp:BoundField DataField="Name" HeaderText="Name">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>

                            <asp:BoundField DataField="JobId" HeaderText="JobId">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>

                            <asp:BoundField DataField="PaymentAmount" HeaderText="Payment Amount" DataFormatString="{0:N2}">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>

                            <asp:BoundField DataField="PaidDate" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>

                            <asp:BoundField DataField="PaidTime" HeaderText="Time">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>

                            <asp:CommandField CausesValidation="false" HeaderText="Delete" ShowDeleteButton="true"
                                DeleteImageUrl="../Images/bin.png" ButtonType="Image">
                                <ControlStyle Height="25px" Width="25px"/>
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
