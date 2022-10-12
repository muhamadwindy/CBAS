<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="MikroLogin.Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head runat="server">
    <title>BTPNS CBAS</title>
    <link rel="shortcut icon" href="logo.ico" type="image/x-icon" />
    <script type="text/javascript" src="App_Themes/customs/js/login.js"></script>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Font Awesome -->
    <link href="App_Themes/mwstyle/plugins/fontawesome-free/css/all.min.css" rel="stylesheet" />
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" />
    <!-- icheck bootstrap -->
    <link href="App_Themes/mwstyle/plugins/icheck-bootstrap/icheck-bootstrap.min.css" rel="stylesheet" />
    <!-- Theme style -->
    <link href="App_Themes/mwstyle/dist/css/adminlte.min.css" rel="stylesheet" />
    <!-- Google Font: Source Sans Pro -->
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet" />
</head>
<body class="hold-transition login-page" style="background-image: url('image/menarabtpn2.jpg') !important; background-size: cover; /* <------ */
    background-repeat: no-repeat; background-position: center center;">
    <form id="form1" runat="server">
        <div class="login-box">

            <!-- /.login-logo -->
            <div class="card">

                <div class="card-header">
                    <div class="text-center">
                        <img src="image/logo_btpns.png" />
                    </div>
                </div>
                <div class="card-body login-card-body">
                    <p class="login-box-msg font-weight-bold">Credit Bureau Automation System</p>
                    <div class="input-group mb-3">
                        <asp:TextBox ID="TXT_USERNAME" CssClass="form-control" placeholder="Username" onkeypress="return kutip_satu()" runat="server"></asp:TextBox>
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-user"></span>
                            </div>
                        </div>
                    </div>
                    <div class="input-group mb-3">
                        <asp:TextBox ID="TXT_PASSWORD" CssClass="form-control" placeholder="Password" runat="server" TextMode="Password"></asp:TextBox>
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-lock"></span>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-8">
                        </div>
                        <!-- /.col -->
                        <div class="col-4">
                            <asp:Button ID="BTN_SUBMIT" runat="server" Text="Login" CssClass="btn btn-primary btn-block" OnClick="BTN_SUBMIT_Click"></asp:Button><br />
                        </div>
                        <!-- /.col -->
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <asp:Label ID="Label1" runat="server" CssClass="text-danger"></asp:Label>
                        </div>
                        <!-- /.col -->
                    </div>
                </div>

                <div class="card-footer">

                    <p class="text-center">Copyright © 2020 PT. BTPN Syariah<br />
                        All Right Reserved</p>

                </div>
                <!-- /.login-card-body -->
            </div>
            <!-- <br />
		<div align="center" style="font-size:small;font-family:Arial;color:red">
		<b>WARNING</b> - This is a UAT Environment<br />
		<small>only used for testing purposes</small>
		</div> -->

        </div>

    </form>
    <script type="text/javascript" src="App_Themes/mwstyle/plugins/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="App_Themes/mwstyle/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="App_Themes/mwstyle/dist/js/adminlte.js"></script>
</body>
</html>
