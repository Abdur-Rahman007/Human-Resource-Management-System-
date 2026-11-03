<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="JobFinder.Admin.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css" />
     
    <style>
        .card {
            background-color: #fff;
            border-radius: 10px;
            border: none;
            position: relative;
            margin-bottom: 30px;
            box-shadow: 0 0.46875rem 2.1875rem rgba(90,97,105,0.1), 
                        0 0.9375rem 1.40625rem rgba(90,97,105,0.1), 
                        0 0.25rem 0.53125rem rgba(90,97,105,0.12), 
                        0 0.125rem 0.1875rem rgba(90,97,105,0.1);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 1rem 2.5rem rgba(0,0,0,0.15);
        }

        /* Professional gradients */
        .l-bg-users {
            background: linear-gradient(135deg, #4e54c8, #8f94fb); /* Indigo → Soft Purple */
            color: #fff;
        }

        .l-bg-jobs {
            background: linear-gradient(135deg, #11998e, #38ef7d); /* Teal → Green */
            color: #fff;
        }

        .l-bg-applied {
            background: linear-gradient(135deg, #f7971e, #ffd200); /* Orange → Yellow */
            color: #fff;
        }

        .l-bg-contact {
            background: linear-gradient(135deg, #ff512f, #dd2476); /* Red → Pink */
            color: #fff;
        }

        .card .card-statistic-3 .card-icon-large .fas,
        .card .card-statistic-3 .card-icon-large .far,
        .card .card-statistic-3 .card-icon-large .fab,
        .card .card-statistic-3 .card-icon-large .fal {
            font-size: 110px;
        }

        .card .card-statistic-3 .card-icon {
            text-align: center;
            line-height: 50px;
            margin-left: 15px;
            color: #000;
            position: absolute;
            right: -5px;
            top: 20px;
            opacity: 0.1;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container pt-4">
        <div class="row">
            <div class="col-12 pb-3">
                <h2 class="text-center">Dashboard</h2>
            </div>
            <div class="col-md-10 mx-auto">
                <div class="row">
                    
                    <!-- Total Users -->
                    <div class="col-xl-3 col-lg-6">
                        <div class="card l-bg-users">
                            <div class="card-statistic-3 p-4">
                                <div class="card-icon card-icon-large">
                                    <i class="fas fa-users pr-2"></i>
                                </div>
                                <div class="mb-4">
                                    <h5 class="card-title mb-0">Total Users</h5>
                                </div>
                                <div class="row-align-items-center mb-2 d-flex">
                                    <div class="col-8">
                                        <h2 class="d-flex align-items-center mb-0">
                                            <% Response.Write(Session["Users"]); %>
                                        </h2>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>            

                    <!-- Total Jobs -->
                    <div class="col-xl-3 col-lg-6">
                        <div class="card l-bg-jobs">
                            <div class="card-statistic-3 p-4">
                                <div class="card-icon card-icon-large">
                                    <i class="fas fa-briefcase pr-2"></i>
                                </div>
                                <div class="mb-4">
                                    <h5 class="card-title mb-0">Total Jobs</h5>
                                </div>
                                <div class="row-align-items-center mb-2 d-flex">
                                    <div class="col-8">
                                        <h2 class="d-flex align-items-center mb-0">
                                            <% Response.Write(Session["Jobs"]); %>
                                        </h2>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Applied Jobs -->
                    <div class="col-xl-3 col-lg-6">
                        <div class="card l-bg-applied">
                            <div class="card-statistic-3 p-4">
                                <div class="card-icon card-icon-large">
                                    <i class="fas fa-check-square pr-2"></i>
                                </div>
                                <div class="mb-4">
                                    <h5 class="card-title mb-0">Applied Jobs</h5>
                                </div>
                                <div class="row-align-items-center mb-2 d-flex">
                                    <div class="col-8">
                                        <h2 class="d-flex align-items-center mb-0">
                                            <% Response.Write(Session["AppliedJobs"]); %>
                                        </h2>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Contacted Users -->
                    <div class="col-xl-3 col-lg-6">
                        <div class="card l-bg-contact">
                            <div class="card-statistic-3 p-4">
                                <div class="card-icon card-icon-large">
                                    <i class="fas fa-comments pr-2"></i>
                                </div>
                                <div class="mb-4">
                                    <h5 class="card-title mb-0">Contacted Users</h5>
                                </div>
                                <div class="row-align-items-center mb-2 d-flex">
                                    <div class="col-8">
                                        <h2 class="d-flex align-items-center mb-0">
                                            <% Response.Write(Session["Contact"]); %>
                                        </h2>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>                   
                </div>                
            </div>
        </div>
    </div>

</asp:Content>
