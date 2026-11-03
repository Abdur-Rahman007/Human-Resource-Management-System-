<%@ Page Title="" Language="C#" MasterPageFile="~/Employer/EmployerMaster.Master" AutoEventWireup="true" CodeBehind="News.aspx.cs" Inherits="JobFinder.Employer.News" %>
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
        }
        .news-section {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            padding: 20px;
        }
        .news-header {
            text-align: center;
            font-size: 2em;
            color: #000000;
            font-weight: bold;
            margin-bottom: 30px;
        }
        .news-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            margin: 15px;
            width: 400px;
            transition: transform 0.2s;
        }
        .news-card:hover {
            transform: scale(1.05);
        }
        .news-card img {
            width: 100%;
            height: 400px;
            object-fit: cover;
        }
        .news-content {
            padding: 15px;
        }
        .news-content .date {
            color: #000000;
            font-size: 0.9em;
        }
        .news-content h2 {
            font-size: 1.2em;
            margin: 10px 0;
            color: #000000;
        }
        .news-content p {
            font-size: 0.95em;
            color: #000000;
        }
        .read-more {
            display: inline-block;
            margin-top: 10px;
            padding: 10px 15px; 
            background-color: #000000;

            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.2s;
        }
        .read-more:hover {
            background-color: #555;
        }

        /* Media Queries */
        /* Responsive Styles */

        @media (max-width: 1200px) {
            .news-card {
                width: 45%; 
            }
        }

        @media (max-width: 1024px) {
            .news-card {
                width: 45%; 
            }
        }

        @media (max-width: 992px) {
            .news-card {
                width: 45%; 
            }
        }

        @media (max-width: 768px) {
            .news-card {
                width: 90%; 
            }
        }

        @media (max-width: 576px) {
            .news-card {
                width: 100%; 
                margin: 10px 0; 
            }

            .news-content h2 {
                font-size: 1em; 
            }

            .news-content p {
                font-size: 0.85em; 
            }

            .read-more {
                padding: 8px 12px; 
            }
        }

        @media (max-width: 480px) {
            .news-card {
                width: 100%; 
            }

            .news-content h2 {
                font-size: 0.9em; 
            }

            .news-content p {
                font-size: 0.8em; 
            }

            .read-more {
                padding: 6px 10px; 
            }
        }       
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      
    <h1 class="news-header">NEWS</h1>

    <section class="news-section">
        <asp:Repeater ID="NewsRepeater" runat="server">
            <ItemTemplate>
                <div class="news-card">
                    <img width="80" src='<%# GetImageUrl(Eval("NewsImg")) %>' alt="">
                    <div class="news-content">
                        <span class="text-secondary">
                            <i class="fas fa-clock pr-1"></i>
                            <%# RelativeDate(Convert.ToDateTime(Eval("CreateDate"))) %>
                        </span>
                        <h2><%# Eval("NewsTitle") %></h2>
                        <p><%# ShortenNewsText(Eval("NewsText").ToString(), 100) %></p>
                        <a href='<%# "NewsDetails.aspx?id=" + Eval("NewsId") %>' class="read-more">Read More</a>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </section>

</asp:Content>