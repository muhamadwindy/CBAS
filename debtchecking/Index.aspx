<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="DebtChecking.Index" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>EDIS</title>
    <Template:Admin runat="server" ID="Template" />
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
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

    <script>
        $(window).ready(function () {
            $('#mainframex').attr('src', $('#firstLink').val() == "" ? "Index.aspx" : $('#firstLink').val());
            $('#mntitle').text(getParameterByName('mntitle', $('#firstLink').val()))
        });

        function changeUrl(_url) {
            $('#mainframex').attr('src', 'about:blank');
            $('#mainframex').attr('src', _url);
            $('#mntitle').text(getParameterByName('mntitle', _url))
        }

        /**
         * Called to resize a given iframe.
         *
         * @param frame The iframe to resize.
         */
        function resize(frame) {
            var b = frame.contentWindow.document.body || frame.contentDocument.body,
                cHeight = $(b).height() + 50;

            cHeight = cHeight < 450 ? 450 : cHeight;
            if (frame.oHeight !== cHeight) {
                $(frame).height(0);
                frame.style.height = 0;

                $(frame).height(cHeight);
                frame.style.height = cHeight + "px";

                frame.oHeight = cHeight;
            }

            // Call again to check whether the content height has changed.
            setTimeout(function () { resize(frame); }, 100);
        }

        /**
         * Resizes all the iframe objects on the current page. This is called when
         * the page is loaded. For some reason using jQuery to trigger on loading
         * the iframe does not work in Firefox 26.
         */
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
    <form id="form2" runat="server" enctype="multipart/form-data">
        <div class="wrapper">

            <!-- Navbar -->
            <nav class="main-header navbar navbar-expand navbar-white navbar-light">
                <!-- Left navbar links -->
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
                            <span class="label">
                                <asp:Label ID="Fullname" runat="server"></asp:Label>
                                -
                                <asp:Label ID="BranchName" runat="server"></asp:Label>
                                -
                                <asp:Label ID="GroupName" runat="server"></asp:Label>
                            </span>
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
                    <img src='<%= ResolveUrl("~/image/skbf_login_logo.png")%>' alt="SKBF Logo" class="brand-image"
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
                        <div class="row">
                            <div class="col-sm-12">
                                <h1 class="m-0 text-dark" id="mntitle"></h1>
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
                            <div class="card-body p-1 pt-3">
                                <asp:Label ID="AppModule" runat="server" Visible="False"></asp:Label>
                                <asp:HiddenField ID="firstLink" runat="server"></asp:HiddenField>
                                <div class="holds-the-iframe">
                                    <iframe id="mainframex" name="mainframex" framespacing="0" frameborder="0" border="0" width="100%"></iframe>
                                </div>
                            </div>
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

