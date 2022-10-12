<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="MikroMnt.Index" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>EDIS Maintenance</title>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="App_Themes/mwstyle/plugins/fontawesome-free/css/all.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <!-- Tempusdominus Bbootstrap 4 -->
    <link rel="stylesheet" href="App_Themes/mwstyle/plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
    <!-- iCheck -->
    <link rel="stylesheet" href="App_Themes/mwstyle/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
    <!-- JQVMap -->
    <link rel="stylesheet" href="App_Themes/mwstyle/plugins/jqvmap/jqvmap.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="App_Themes/mwstyle/dist/css/adminlte.min.css">

    <link rel="stylesheet" href="App_Themes/mwstyle/bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">
    <!-- overlayScrollbars -->
    <link rel="stylesheet" href="App_Themes/mwstyle/plugins/overlayScrollbars/css/OverlayScrollbars.min.css">

    <link href="App_Themes/mwstyle/dataTables/datatables.css" rel="stylesheet" />

    <link href="App_Themes/mwstyle/dataTables/Buttons-1.6.1/css/buttons.dataTables.css" rel="stylesheet" />

    <link href="App_Themes/mwstyle/dataTables/datatables.min.css" rel="stylesheet" />

    <!-- Daterange picker -->
    <link rel="stylesheet" href="App_Themes/mwstyle/plugins/daterangepicker/daterangepicker.css">
    <!-- summernote -->
    <link rel="stylesheet" href="App_Themes/mwstyle/plugins/summernote/summernote-bs4.css">
    <!-- Google Font: Source Sans Pro -->
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">

    <link rel="stylesheet" href="include/bootstrap-combobox.css">

    <style>
        hr {
            margin-top: 5px !important;
            margin-bottom: 5px !important;
            border: 1px solid #bfbdbd;
        }

        th {
            border-top: 1px solid #dddddd !important;
            border-bottom: 1px solid #dddddd !important;
            border-right: 1px solid #dddddd !important;
        }

            th:first-child {
                border-left: 1px solid #dddddd !important;
            }



        .holds-the-iframe {
            background: url('image/windy_loading_blue_sky.gif') center center no-repeat;
            background-size: 5%;
            min-height: 200px;
        }
    </style>

    <!-- jQuery -->
    <script src="App_Themes/mwstyle/plugins/jquery/jquery.min.js"></script>
    <!-- jQuery UI 1.11.4 -->
    <script src="App_Themes/mwstyle/plugins/jquery-ui/jquery-ui.min.js"></script>
    <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
    <script>
        $.widget.bridge('uibutton', $.ui.button)

        function goto_page(page) {
            $('#konten').attr('src', page);
        }

        $(document).ready(function () {

            $(".nav a").on("click", function () {
                $(".nav").find(".active").removeClass("active");
                $(this).parent().addClass("active");
            });

            goto_page('Main.aspx');
        });

    </script>
            <script language="JavaScript" type="text/javascript"> 

                if (top != self) { top.location = self.location; }

                var warn_window = null;
                var can_close = true;
                var appurl = '';
                function warn_close(nochk) {
                    if (!nochk && !can_close) return;
                    if (warn_window != null)
                        try {
                            warn_window.opener = null;
                            warn_window.close();
                            warn_window = null;
                        } catch (e) { }
                }
                function warn_timeout() {
                    if (warn_window != null) return;
                    var X = (screen.availWidth - 380) / 2;
                    var Y = (screen.availHeight - 350) / 2;

                    try { app_url = document.frames(1).document.location.href; }
                    catch (e) { }
                    can_close = false;
                    window.focus();
                    warn_window = window.open("warning.html", "losmnt",
                        "height=350px,width=380px,left=" + X + ",top=" + Y +
                        ",status=no,toolbar=no,scrollbars=no,titlebar=no,menubar=no,location=no,dependent=yes");
                }
                function warn_closed() {
                    warn_window = null;
                    try {
                        if (document.frames(2).document.readyState == 'interactive' || document.frames(2).document.readyState == 'complete')
                            document.frames(2).document.parentWindow.execScript('reset_post()');
                    } catch (e) { }
                }
                function logout_now() {
                    warn_close(true);
                    top.location.href = '<%=ResolveUrl("~/Logout.aspx") %>';
                }
        </script>

    <!-- Bootstrap 4 -->
    <script src="App_Themes/mwstyle/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- daterangepicker -->
    <script src="App_Themes/mwstyle/plugins/moment/moment.min.js"></script>

    <script src="App_Themes/mwstyle/bower_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
    <!-- Tempusdominus Bootstrap 4 -->
    <script src="App_Themes/mwstyle/plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
    <!-- Summernote -->
    <script src="App_Themes/mwstyle/plugins/summernote/summernote-bs4.min.js"></script>
    <!-- overlayScrollbars -->
    <script src="App_Themes/mwstyle/plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>

    <script src="App_Themes/mwstyle/plugins/jquery-validation/jquery.validate.min.js"></script>

    <script src="App_Themes/mwstyle/dataTables/datatables.js"></script>
    <script src="App_Themes/mwstyle/dataTables/datatables.min.js"></script>

    <script src="App_Themes/mwstyle/dist/js/adminlte.js"></script>
    <!-- AdminLTE for demo purposes -->
    <script src="App_Themes/mwstyle/dist/js/demo.js"></script>

    <script src="include/bootstrap-combobox.js"></script>

    <script src="include/onepost.js"></script>

    <script src="include/cek_entries.js"></script>
    <script>

        $('.combobox').combobox();

        //Date picker
        $('.date').datepicker({
            autoclose: true,
            defaultDate: new Date()
        })

        $('.dateField').datepicker({
            onClose: function () {
                $(this).valid();
            }
        });

        /**
         * Called to resize a given iframe.
         *
         * @param frame The iframe to resize.
         * nggowo screenmenu
         * muhamad windy sulistiyo
         */
        function resize(frame) {
            $(frame.contentWindow.document.body).attr('style', 'min-height: 450px; background: white !important;');
            var b = frame.contentWindow.document.body || frame.contentDocument.body,
                cHeight = $(b).height() + 25;

            if ($(frame).attr("src") === undefined) {

            } else {
                if (frame.oHeight !== cHeight) {
                    $(frame).height(0);
                    frame.style.height = 0;

                    $(frame).height(cHeight);
                    frame.style.height = cHeight + "px";

                    frame.oHeight = cHeight;
                }
            }

            // Call again to check whether the content height has changed.
            setTimeout(function () { resize(frame); }, 100);
        }

        window.onload = function () {

            var frame,
                frames = document.getElementsByTagName('iframe'),
                i = frames.length - 1;

            while (i >= 0) {
                frame = frames[i];
                frame.onload = resize(frame);

                i -= 1;
            }

        };
    </script>
</head>
<body class="hold-transition sidebar-mini layout-fixed text-sm">
    <form id="form1" runat="server" enctype="multipart/form-data">
        <div class="wrapper">

            <!-- Navbar -->
            <nav class="main-header navbar navbar-expand navbar-white navbar-light">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" data-widget="pushmenu" href="#"><i class="fas fa-bars"></i></a>
                    </li>
                    <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
                </ul>
                <ul class="navbar-nav ml-auto">
                    <!-- Messages Dropdown Menu -->
                    <li class="nav-item dropdown">
                        <a class="nav-link" data-toggle="dropdown" href="#">
                            <i class="fa fa-user"></i>
                            <span class="label"><%=Session["FullName"] !=null ? Session["FullName"].ToString():"..." %> - <%=Session["BranchName"]!=null ?Session["BranchName"].ToString():"..." %>  - <%=Session["GroupName"]!=null ? Session["GroupName"].ToString() : "..." %>  </span>
                        </a>
                        <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
                            <a href="#" class="dropdown-item" onclick="logout_now();">
                                <i class="fas fa-off"></i>Logout
                                <span class="float-right text-muted text-sm"></span>
                            </a>
                        </div>
                    </li>
                </ul>
            </nav>
            <!-- /.navbar -->
            <!-- Main Sidebar Container -->
            <aside class="main-sidebar sidebar-light-primary elevation-4">
                <!-- Brand Logo -->
                <a href='<%= ResolveUrl("~/index.aspx")%>' class="brand-link">
                    <img src="image/skbf_login_logo.png" alt="Kreditplus Logo" class="brand-image"
                        style="opacity: .8">
                    <span class="brand-text font-weight-light">
                        <br />
                    </span>
                </a>

                <!-- Sidebar -->
                <div class="sidebar">
                    <!-- Sidebar Menu -->
                    <nav class="mt-2">
                        <asp:Literal ID="smoothmenu" runat="server"></asp:Literal>
                    </nav>
                    <!-- /.sidebar-menu -->
                </div>
                <!-- /.sidebar -->
            </aside>

            <!-- Content Wrapper. Contains page content -->
            <div class="content-wrapper">
                <!-- Content Header (Page header) -->
                <div class="content-header">
                    <div class="container-fluid">
                        <div class="row mb-2">
                            <div class="col-sm-12">
                                <!--       <h1 class="m-0 text-dark"><%=Request.QueryString["mntitle"] %></h1>-->
                            </div>
                        </div>
                        <!-- /.row -->
                    </div>
                    <!-- /.container-fluid -->
                </div>
                <!-- /.content-header -->
                <!-- Main content -->
                <section class="content">
                    <div class="container-fluid">
                        <div class="card">
                            <section class="pt-2 connectedSortable">
                                <asp:Label ID="Label1" runat="server" Visible="False"></asp:Label>
                                <div class="holds-the-iframe">
                                    <iframe id="konten" framespacing="0" frameborder="0" border="0" width="100%"></iframe>
                                </div>
                            </section>
                        </div>
                        <!-- /.row (main row) -->
                    </div>
                    <!-- /.container-fluid -->
                </section>
                <!-- /.content -->
            </div>
            <!-- /.content-wrapper -->
            <footer class="main-footer">
                <strong>&copy; 2022 PT. Sunindo Kookmin Best Finance. </strong>
                All rights reserved.
            </footer>
            <!-- ./wrapper -->
        </div>
    </form>
</body>
</html>
