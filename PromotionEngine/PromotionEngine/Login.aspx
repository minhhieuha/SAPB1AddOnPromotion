<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="PromotionEngine.Login" %>

<!DOCTYPE html>
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">--%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login - Promotion Engine</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Le styles -->
    <link href="Styles/Login/bootstrap.min.css" rel="stylesheet">
    <link href="Styles/Login/bootstrap-responsive.min.css" rel="stylesheet">
    <link rel="stylesheet" href="Styles/Login/typica-login.css">
    <link rel="stylesheet" href="Styles/Login/ValidationEngine.css">
    <script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <!-- Le favicon -->
    <%--  <link rel="shortcut icon" href="favicon.ico">--%>
    <%--    <style>
        form.form login-form{ 
    margin:10px 0px 0px 10px;
    background:#EEEEEE;
    padding:20px;
    max-width: 400px !important;
    min-width: 400px !important;
    width: 400px !important;
    border: 1px solid #CCCCCC;
    float:left;
}
input.error{border:1px solid #FF0000 !important; }
label.error,div.error{
    font-size:5pt;
    color:#FF0000 !important;
}
.text-normal{
    font-size:5pt; !important;
}
    </style>--%>
    <script src="Scripts/Login/jquery.js"></script>
    <script src="Scripts/Login/bootstrap.js"></script>
    <script src="Scripts/Login/backstretch.min.js"></script>
    <script src="Scripts/Login/typica-login.js"></script>
    <script src="Scripts/jquery.validate.js"></script>
    <script src="Scripts/jquery.validationEngine-en.js"></script>
    <script src="Scripts/jquery.validationEngine.js"></script>
    <script>
        $(document).ready(function () {
            $("#txtUserName").keyup(function (event) {
                if (event.keyCode == 13) {
                    $("#btnLogin").click();
                }
            });
            $("#txtPassword").keyup(function (event) {
                if (event.keyCode == 13) {
                    $("#btnLogin").click();
                }
            });
            $("#ajax_loader").ajaxStop(function () {
                $(this).hide();
            });
            $("#ajax_loader").ajaxStart(function () {
                $(this).show();
            });
            $("#form1").validationEngine('attach', { promptPosition: "topRight" });
            $("#btnLogin").click(function () {
                $('#ajax_loader').show();
                var valid = $("#form1").validationEngine('validate');
                if (valid == true) {
                    var usr = $("#txtUserName").val();
                    var pass = $("#txtPassword").val();
                    $.ajax({
                        type: "POST",
                        url: "Login.aspx/GetLogin",
                        data: '{"userName":"' + usr + '","passWord":"' + pass + '"}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            if (data.d == "SUCCESS") {
                                window.location.href = "Default.aspx"
                            }
                            else {
                                $("#lblErrorMsg").html("UserName or Password is incorrect.");
                            }
                        },
                        error: function (xhr, status, err) {
                            var err = eval("(" + xhr.responseText + ")");
                            alert(err.Message);

                        }
                    });
                }
            });
        });
    </script>
</head>
<body>
    <div id='ajax_loader' style="position: fixed; left: 50%; top: 50%; display: none;">
        <img src="Images/loading.gif"></img>
    </div>
    <form id="form1" runat="server" class="form login-form">
    <div>
        <div class="navbar navbar-fixed-top">
            <div class="navbar-inner">
                <div class="container">
                    <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"><span
                        class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
                    </a><a class="brand" href="Login.aspx">SAP Business One - SAP Add-ons</a>
                    <%-- <a class="brand" href="index.html"><img src="logo.png" alt=""></a>--%>
                </div>
            </div>
        </div>
        <div class="container">
            <div id="login-wraper">
                <legend>Sign in to <span class="blue" style="font-size: 20pt;">Promotion Engine</span></legend>
                <div class="body">
                    <label>
                        Username</label>
                    <input type="text" id="txtUserName" name="userName" class="validate[required]">
                    <label>
                        Password</label>
                    <input type="password" id="txtPassword" name="passWord" class="validate[required]">
                    <label>
                        <span id="lblErrorMsg" style="color: Red; font-size: 10pt;"></span>
                    </label>
                </div>
                <div class="footer">
                    <label class="checkbox inline">
                        <a href="#">Need Help?</a>
                        <%-- <input type="checkbox" id="inlineCheckbox1" value="option1">
                        Remember me--%>
                    </label>
                    <button type="button" id="btnLogin" class="btn btn-primary">
                        Login</button>
                </div>
            </div>
        </div>
        <footer class="white navbar-fixed-bottom">
      Don't have an account yet? <a href="#" class="btn btn-black">Contact Us</a>
    </footer>
    </div>
    </form>
</body>
</html>
