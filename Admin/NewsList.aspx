<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.Master" AutoEventWireup="true" CodeBehind="NewsList.aspx.cs" Inherits="JobFinder.Admin.NewsList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <div style="background-image: url('../Images/bg.jpg'); width: 100%; height: 720px; background-repeat: no-repeat;
        background-size: cover; background-attachment: fixed;">
        <div class="container-fluid pt-4 pb-4">
         
            <div class="btn-toolbar justify-content-between mb-3">
                <div class="btn-group">
                    <asp:Label ID="lblMsg" runat="server"></asp:Label>
                </div>
                <div class="input-group h-25">
                <asp:HyperLink ID="linkBack" runat="server" NavigateUrl="~/Admin/AddNews.aspx" CssClass="btn btn-secondary"
                    Visible="false"> < Back </asp:HyperLink>
                </div>
            </div>           

            <h3 class="text-center">News List</h3>

            <div class="row mb-3 pt-sm-3">
                <div class="col-md-12">
                    <asp:GridView ID="GridView1" runat="server" CssClass="table table-hover table-bordered"
                        EmptyDataText="No record to display" AutoGenerateColumns="False" AllowPaging="True" PageSize="5"
                        OnPageIndexChanging="GridView1_PageIndexChanging" DataKeyNames="NewsId" OnRowDeleting="GridView1_RowDeleting"
                        OnRowCommand="GridView1_RowCommand" OnRowDataBound="GridView1_RowDataBound">
                       
                        <Columns>
                               
                            <asp:BoundField DataField="Sr.No" HeaderText="Sr.No">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                               
                            <asp:BoundField DataField="NewsTitle" HeaderText="NewsTitle">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>

                            <asp:BoundField DataField="NewsText" HeaderText="NewsText">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>

                            
                            <asp:BoundField DataField="NewsImg" HeaderText="NewsImg"  >
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>  

                            <asp:BoundField DataField="CreateDate" HeaderText="News Posted Date" DataFormatString="{0:dd MMMM yyyy}" >
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField> 
                            
                            <asp:TemplateField HeaderText="Edit">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnEditNews" runat="server" CommandName="EditNews" CommandArgument='<%# Eval("NewsId") %>'>
                                        <asp:Image ID="Img" runat="server" ImageUrl="../Images/pen.png" Height="25px" />
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                         
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