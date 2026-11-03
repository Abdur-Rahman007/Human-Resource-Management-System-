<%@ Page Title="" Language="C#" MasterPageFile="~/Employer/EmployerMaster.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="JobFinder.Employer.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <main>
        <!-- slider Area Start-->
        <div class="slider-area ">
            <!-- Mobile Menu -->
            <div class="slider-active">
                <div class="single-slider slider-height d-flex align-items-center" data-background="../assets/img/icon/jobfinder_index.png">
                    <div class="container">
                        <div class="row">
                            <div class="col-xl-6 col-lg-9 col-md-10">
                                <div class="hero__caption">
                                </div>
                            </div>
                        </div>                       
                    </div>
                </div>
            </div>
        </div>
        <!-- slider Area End-->
        <!-- Our Services Start -->
       
        <!-- Our Services End -->
        <!-- How  Apply Process Start-->
       <div style="background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.7)), url('../Images/HRMS_LOGO2.png') center/cover no-repeat; padding:100px 20px; color:white; font-family:Arial, sans-serif;">
  <div style="max-width:1200px; margin:auto; text-align:center;">
      
      <!-- Section Title -->
      <h2 style="font-size:40px; font-weight:bold; margin-bottom:50px; letter-spacing:2px; border-bottom:3px solid #f8f8f8; display:inline-block; padding-bottom:10px;">
          ✨ FEATURES
      </h2>

      <!-- Features Section -->
      <div style="display:flex; flex-wrap:wrap; justify-content:center; gap:30px; margin-top:40px;">
          
          <!-- Feature 1 -->
          <div style="flex:1 1 300px; background:white; color:#333; border-radius:15px; padding:30px; box-shadow:0 6px 15px rgba(0,0,0,0.2); transition:0.3s;">
              <div style="font-size:50px; margin-bottom:15px;">🔎</div>
              <h3 style="margin-bottom:15px; color:#0d6efd;">Search a Job</h3>
              <p style="line-height:1.6;">Explore thousands of job opportunities across industries and locations. Use advanced filters to find the role that matches your skills, experience, and career goals.</p>
          </div>

          <!-- Feature 2 -->
          <div style="flex:1 1 300px; background:white; color:#333; border-radius:15px; padding:30px; box-shadow:0 6px 15px rgba(0,0,0,0.2); transition:0.3s;">
              <div style="font-size:50px; margin-bottom:15px;">👤</div>
              <h3 style="margin-bottom:15px; color:#0d6efd;">Create your Profile</h3>
              <p style="line-height:1.6;">Build a professional profile that highlights your strengths and achievements. Upload your resume, showcase your skills, and let employers discover you.</p>
          </div>

          <!-- Feature 3 -->
          <div style="flex:1 1 300px; background:white; color:#333; border-radius:15px; padding:30px; box-shadow:0 6px 15px rgba(0,0,0,0.2); transition:0.3s;">
              <div style="font-size:50px; margin-bottom:15px;">📩</div>
              <h3 style="margin-bottom:15px; color:#0d6efd;">Apply for Job</h3>
              <p style="line-height:1.6;">Easily apply for jobs with one click. Track applications, stay updated with responses, and take the next step toward your dream career.</p>
          </div>

      </div>
  </div>
</div>

<!-- Testimonials -->
<div style="padding:100px 20px; background:#f9f9f9; font-family:Arial, sans-serif;">
  <div style="max-width:1000px; margin:auto; text-align:center;">

      <h2 style="font-size:35px; font-weight:bold; margin-bottom:60px; color:#222; letter-spacing:1px;">🌟 What People Say</h2>

      <!-- Testimonial Container -->
      <div style="display:flex; flex-wrap:wrap; justify-content:center; gap:40px;">
          
          <!-- Testimonial 1 -->
          <div style="flex:1 1 400px; background:white; border-radius:15px; padding:30px; box-shadow:0 5px 15px rgba(0,0,0,0.15); text-align:center;">
              <img src="../Images/farnaz.jpeg" alt="" style="width:80px; height:80px; border-radius:50%; margin-bottom:15px; border:3px solid #0d6efd;">
              <h4 style="margin:10px 0 5px; color:#0d6efd;">Farnaz Faria</h4>
              <p style="margin:0; font-size:14px; color:#666;">Creative Director</p>
              <p style="margin-top:15px; font-style:italic; line-height:1.6; color:#444;">"This platform made my job search simple and effective. Within weeks, I connected with top companies and secured interviews."</p>
          </div>

          <!-- Testimonial 2 -->
          <div style="flex:1 1 400px; background:white; border-radius:15px; padding:30px; box-shadow:0 5px 15px rgba(0,0,0,0.15); text-align:center;">
              <img src="../Images/khairulSir.jpeg" alt="" style="width:80px; height:80px; border-radius:50%; margin-bottom:15px; border:3px solid #0d6efd;">
              <h4 style="margin:10px 0 5px; color:#0d6efd;">Khairul Mozumdar</h4>
              <p style="margin:0; font-size:14px; color:#666;">Backend Developer</p>
              <p style="margin-top:15px; font-style:italic; line-height:1.6; color:#444;">"Creating a profile was quick and easy. I started receiving relevant job offers almost immediately."</p>
          </div>

      </div>
  </div>
</div>

        <!-- Testimonial End -->
    </main>

</asp:Content>
