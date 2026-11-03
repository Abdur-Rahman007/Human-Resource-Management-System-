<%@ Page Title="" Language="C#" MasterPageFile="~/Employer/EmployerMaster.Master" AutoEventWireup="true" CodeBehind="NewsDetails.aspx.cs" Inherits="JobFinder.Employer.NewsDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #ffffff;
            padding: 20px;
        }

        .news-detail-container {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            max-width: 1200px;
            margin: 0 auto;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .news-detail-title {
            font-size: 2em;
            color: #000000;
            margin-bottom: 10px;
            text-align: center;
        }

        .news-detail-date {
            font-size: 1.1em;
            color: #000000;
            text-align: center;
            margin-bottom: 20px;
        }

        .news-detail-content {
            font-size: 1.2em;
            line-height: 1.6;
            color: #000000;
            text-align: justify;
        }

        .news-detail-img {
            margin-top: 20px;
            text-align: center;

        }

        .news-detail-img img {
            width: 100%;                       
            height: auto;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        
        /* @media queries for different screen sizes */

        @media (max-width: 1200px) {
            .news-detail-container {
                padding: 20px;
            }

            .news-detail-title {
                font-size: 1.9em;
            }

            .news-detail-date {
                font-size: 1.05em;
            }

            .news-detail-content {
                font-size: 1.15em;
            }
        }

        @media (max-width: 1024px) {
            .news-detail-container {
                padding: 18px;
            }

            .news-detail-title {
                font-size: 1.8em;
            }

            .news-detail-date {
                font-size: 1em;
            }

            .news-detail-content {
                font-size: 1.1em;
            }
        }

        @media (max-width: 992px) {
            .news-detail-container {
                padding: 18px;
            }

            .news-detail-title {
                font-size: 1.75em;
            }

            .news-detail-content {
                font-size: 1.1em;
            }

            .news-detail-date {
                font-size: 0.95em;
            }
        }

        @media (max-width: 768px) {
            .news-detail-container {
                padding: 15px;
            }

            .news-detail-title {
                font-size: 1.7em;
            }

            .news-detail-date {
                font-size: 0.9em;
            }

            .news-detail-content {
                font-size: 1em;
            }

            .news-detail-img {
                grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            }
        }

        @media (max-width: 576px) {
            body {
                padding: 10px;
            }

            .news-detail-container {
                padding: 12px;
            }

            .news-detail-title {
                font-size: 1.6em;
            }

            .news-detail-date {
                font-size: 0.85em;
            }

            .news-detail-content {
                font-size: 0.95em;
            }

            .news-detail-img {
                gap: 10px;
            }
        }

        @media (max-width: 480px) {
            .news-detail-container {
                padding: 10px;
            }

            .news-detail-title {
                font-size: 1.5em;
            }

            .news-detail-date {
                font-size: 0.8em;
            }

            .news-detail-content {
                font-size: 0.9em;
            }

            .news-detail-img {
                grid-template-columns: 1fr;
            }
        } 
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 
    <section class="news-detail-container">
        <asp:Repeater ID="NewsDetailsRepeater" runat="server">
            <ItemTemplate>
                <h1 class="news-detail-title"><%# Eval("NewsTitle") %></h1>
                <p class="news-detail-date">
                    <i class="fas fa-clock pr-1"></i>
                    <%# RelativeDate(Convert.ToDateTime(Eval("CreateDate"))) %>
                </p>
                <div class="news-detail-content">
                    <p><%# Eval("NewsText") %></p>
                </div>
                <img src='<%# GetImageUrl(Eval("NewsImg")) %>' alt="" class="news-detail-img"  />
            </ItemTemplate>
        </asp:Repeater>
    </section>

</asp:Content>