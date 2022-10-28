<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Update_Password.aspx.cs" Inherits="DebtChecking.SLIK.Update_Password" %>

<%@ Register TagPrefix="dx" Namespace="DevExpress.Web" Assembly="DevExpress.Web.v20.2, Version=20.2, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>User Slik Management</title>

    <Template:Admin runat="server" ID="Template" />
    <script language="javascript" type="text/javascript">
        $(document).on("click", ".open-myModal-LoginViewer", function (event) {
            event.preventDefault();
            var cl_id = $(this).data('aid');//userid
            var cl_seq = $(this).data('aseq');//uid_slik
            //var cl_regno = $('#AP_REGNO').val();
            //var FULLURL = "Modal_Content_SlikLogin_Viewer.aspx" + "?userid=" + cl_id + "&uid_slik=" + cl_seq + "&bypasssession=1";//nanti ini bypass harus mati di prod
            var FULLURL = "Modal_Content_SlikLogin_Viewer.aspx" + "?userid=" + cl_id + "&uid_slik=" + cl_seq;
            $('#ModalSlikLoginViewer').attr('src', FULLURL);
            $('#myModaloginViewer').modal('show');
            $('.modal-dialog').css("margin-top", "100px");
            //$("#btn_retrieve").click();
            //gridPanel.PerformCallback('r:' + cl_seq);
        });
        $(document).on("click", ".open-myModal-Login", function (event) {
            event.preventDefault();
            var cl_id = $(this).data('aid');
            var cl_seq = $(this).data('aseq');
            //var cl_regno = $('#AP_REGNO').val();
            //var FULLURL = "Modal_Content_SlikLogin.aspx" + "?userid=" + cl_id + "&uid_slik=" + cl_seq + "&bypasssession=1";//nanti ini bypass harus mati di prod
            var FULLURL = "Modal_Content_SlikLogin.aspx" + "?userid=" + cl_id + "&uid_slik=" + cl_seq;//nanti ini bypass harus mati di prod
            $('#ModalSlikLogin').attr('src', FULLURL);
            $('#myModalogin').modal('show');
            $('.modal-dialog').css("margin-top", "100px");
            //$("#btn_retrieve").click();
            //gridPanel.PerformCallback('r:' + cl_seq);
        });

        $(document).on("click", ".open-myModal-tasklistextract", function (event) {
            event.preventDefault();
            var cl_id = $(this).data('aid');//extractid
            var cl_seq = $(this).data('aseq');//serviceid
            var cl_userid = $(this).data('aregno');//userid
            //var cl_regno = $('#AP_REGNO').val();
            //var FULLURL = "Modal_Content_SlikLogin_Viewer.aspx" + "?userid=" + cl_id + "&uid_slik=" + cl_seq + "&bypasssession=1";//nanti ini bypass harus mati di prod
            var FULLURL = "Modal_Content_SlikTasklist_Extract.aspx" + "?extractid=" + cl_id + "&serviceid=" + cl_seq + "&userid=" + cl_userid;
            $('#ModalSliktasklistextract').attr('src', FULLURL);
            $('#myModaltasklistextract').modal('show');
            $('.modal-dialog').css("margin-top", "100px");
            //$("#btn_retrieve").click();
            //gridPanel.PerformCallback('r:' + cl_seq);
        });
        $(document).on("click", ".actdelete", function () {
            var cl_id = $(this).data('aid');//userid
            var cl_seq = $(this).data('aseq');//uid_slik
            var r = confirm("Apakah Anda Yakin?");
            if (r == true) {
                gridPanel.PerformCallback('d:' + cl_id + ":" + cl_seq);
                alert("User Berhasil Dihapus");
            }
        });
        $(document).on("click", ".actdelete2", function () {
            var cl_id = $(this).data('aid');//userid
            var cl_seq = $(this).data('aseq');//uid_slik
            var cl_flagspv = $(this).data('aflagspv');//flagspv
            var r = confirm("Apakah Anda Yakin?");
            if (r == true) {
                gridPanel2.PerformCallback('d:' + cl_id + ":" + cl_seq + ":" + cl_flagspv);
                alert("User Berhasil Dihapus");
            }
        });
        $(document).on("click", ".actdelete3", function () {
            var cl_id = $(this).data('aid');//extractid
            var cl_seq = $(this).data('aseq');//serviceid
            var cl_userid = $(this).data('aregno');//userid

            var r = confirm("Apakah Anda Yakin?");
            if (r == true) {
                gridPanel3.PerformCallback('d:' + cl_id + ":" + cl_seq + ":" + cl_userid);
                alert("User Tasklist Extract Berhasil Dihapus");
            }
        });

    </script>

</head>
<body>
    <div class="container-fluid">
        <form id="form1" runat="server" autocomplete="off">
            <dx:ASPxCallbackPanel runat="server" ID="gridPanel2" ClientInstanceName="gridPanel2" OnCallback="gridPanel_Callback_sliklogin">
                <ClientSideEvents EndCallback="function(s, e) {
                        if (s.cp_new != '' && s.cp_new != undefined) {
                            window.open(s.cp_new,'_parent');
                            s.cp_new = '';
                        }
                        if (s.cp_url != '' && s.cp_url != undefined) {
                            window.open(s.cp_url,'_blank,toolbar=no, location=yes,status=no,menubar=no,scrollbars=yes,resizable=no');
                            s.cp_url = '';
                        }
                        if (s.cp_alert != '' && s.cp_alert != undefined) {
                            alert(s.cp_alert);
                            s.cp_alert = '';
                        }
                    }" />
                <PanelCollection>
                    <dx:PanelContent ID="PanelContent1" runat="server">
                        <!-- Row start -->
                        <div class="row modalpos">
                            <div class="col-md-12 col-sm-12 col-xs-12">
                                <div class="card card-primary card-outline">
                                    <div class="card-header">
                                        <div class="row">
                                            <div class="col col-xs-6">
                                                <h6 class="card-title">Update Password User ID SLIK</h6>
                                            </div>
                                            <div class="col col-xs-6 text-right">
                                                <button id="Button1" runat="server" type="button" class="open-myModal-Login btn btn-xs btn-success" data-toggle="modal" data-collateralid="" data-collateralseq="" data-target="#myModalogin">
                                                    <i class="fa fa-plus" aria-hidden="true"></i>
                                                    &nbsp Tambah
                                                   
                                                </button>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="card-body">
                                        <div class="container-fluid">
                                            <div class="table-responsive">

                                                <asp:GridView ID="GridUpdate_Password_sliklogin" runat="server" Width="100%"
                                                    CssClass="table table-sm table-striped table-bordered table-hover"
                                                    AutoGenerateColumns="False"
                                                    AllowPaging="True"
                                                    OnPageIndexChanged="GridUpdate_Password_sliklogin_PageIndexChanged"
                                                    OnPageIndexChanging="GridUpdate_Password_sliklogin_PageIndexChanging"
                                                    OnRowDataBound="GridUpdate_Password_sliklogin_RowDataBound">
                                                    <PagerStyle HorizontalAlign="Right" />
                                                    <Columns>
                                                        <asp:BoundField DataField="userid" HeaderText="ID" />
                                                        <asp:BoundField DataField="uid_slik" HeaderText="User Name" />
                                                        <asp:BoundField DataField="username" HeaderText="Full Name" />
                                                        <asp:BoundField DataField="flag_spv" HeaderText="Role" />
                                                        <asp:BoundField DataField="active" HeaderText="Active" />
                                                        <%--<asp:BoundField DataField="pwd_viewer" HeaderText="Nama Kerabat" />--%>

                                                        <asp:TemplateField HeaderText="Function">
                                                            <ItemStyle Width="15%"></ItemStyle>
                                                            <ItemTemplate>
                                                                <a id="lnkEdit" runat="server"
                                                                    data-toggle="modal"
                                                                    data-target="#myModalogin" title="Edit Contact"
                                                                    data-aid='<%# Eval("userid") %>'
                                                                    data-aseq='<%# Eval("uid_slik") %>'
                                                                    data-aregno='<%# Eval("userid") %>'
                                                                    class="open-myModal-Login btn btn-xs btn-primary">
                                                                    <i class="fa fa-adjust" aria-hidden="true" title="Edit Contact"></i>
                                                                </a>
                                                                <a id="lnkDelete" runat="server"
                                                                    data-toggle="tooltip" title="Delete Contact"
                                                                    data-aid='<%# Eval("userid") %>'
                                                                    data-aseq='<%# Eval("uid_slik") %>'
                                                                    data-aregno='<%# Eval("userid") %>'
                                                                    data-aflagspv='<%# Eval("flag_spv") %>'
                                                                    class="actdelete2 btn btn-xs btn-danger">
                                                                    <i class="fa fa-times" aria-hidden="true" title="Delete Contact"></i>
                                                                </a>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>

                                                <%--</dx:PanelContent>
                                                    </PanelCollection>
                                                </dx:ASPxCallbackPanel>--%>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <!-- Row end -->
                    </dx:PanelContent>
                </PanelCollection>

            </dx:ASPxCallbackPanel>


            <dx:ASPxCallbackPanel runat="server" ID="gridPanel" ClientInstanceName="gridPanel" OnCallback="gridPanel_Callback_slikloginviewer">
                <ClientSideEvents EndCallback="function(s, e) {
                        if (s.cp_new != '' && s.cp_new != undefined) {
                            window.open(s.cp_new,'_parent');
                            s.cp_new = '';
                        }
                        if (s.cp_url != '' && s.cp_url != undefined) {
                            window.open(s.cp_url,'_blank,toolbar=no, location=yes,status=no,menubar=no,scrollbars=yes,resizable=no');
                            s.cp_url = '';
                        }
                        if (s.cp_alert != '' && s.cp_alert != undefined) {
                            alert(s.cp_alert);
                            s.cp_alert = '';
                        }
                    }" />
                <PanelCollection>
                    <dx:PanelContent ID="PanelContent13" runat="server">
                        <!-- Row start -->
                        <div class="row modalpos">
                            <div class="col-md-12 col-sm-12 col-xs-12">
                                <div class="card card-primary card-outline">
                                    <div class="card-header">
                                        <div class="row">
                                            <div class="col col-xs-6">
                                                <h6 class="card-title">Update Password IDEB Viewer
                                                </h6>
                                            </div>
                                            <div class="col col-xs-6 text-right">
                                                <button id="btn_upload" runat="server" type="button" class="open-myModal-LoginViewer btn btn-xs btn-success" data-toggle="modal" data-collateralid="" data-collateralseq="" data-target="#myModaloginViewer">
                                                    <i class="fa fa-plus" aria-hidden="true"></i>
                                                    &nbsp Tambah
                                                   
                                                </button>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="card-body">
                                        <div class="container-fluid">
                                            <div class="table-responsive">

                                                <asp:GridView ID="GridUpdate_Password_slikloginviewer" runat="server" Width="100%"
                                                    CssClass="table table-sm table-striped table-bordered table-hover"
                                                    AutoGenerateColumns="False"
                                                    AllowPaging="True"
                                                    OnPageIndexChanged="GridUpdate_Password_slikloginviewer_PageIndexChanged"
                                                    OnPageIndexChanging="GridUpdate_Password_slikloginviewer_PageIndexChanging"
                                                    OnRowDataBound="GridUpdate_Password_slikloginviewer_RowDataBound">
                                                    <PagerStyle HorizontalAlign="Right" />
                                                    <Columns>
                                                        <asp:BoundField DataField="userid" HeaderText="ID" />
                                                        <asp:BoundField DataField="uid_slik" HeaderText="User Name" />
                                                        <%--<asp:BoundField DataField="pwd_viewer" HeaderText="Nama Kerabat" />--%>

                                                        <asp:TemplateField HeaderText="Function">
                                                            <ItemStyle Width="15%"></ItemStyle>
                                                            <ItemTemplate>
                                                                <a id="lnkEdit" runat="server"
                                                                    data-toggle="modal"
                                                                    data-target="#myModaloginViewer" title="Edit Contact"
                                                                    data-aid='<%# Eval("userid") %>'
                                                                    data-aseq='<%# Eval("uid_slik") %>'
                                                                    data-aregno='<%# Eval("userid") %>'
                                                                    class="open-myModal-LoginViewer btn btn-xs btn-primary">
                                                                    <i class="fa fa-adjust" aria-hidden="true" title="Edit Contact"></i>
                                                                </a>
                                                                <a id="lnkDelete" runat="server"
                                                                    data-toggle="tooltip" title="Delete Contact"
                                                                    data-aid='<%# Eval("userid") %>'
                                                                    data-aseq='<%# Eval("uid_slik") %>'
                                                                    data-aregno='<%# Eval("userid") %>'
                                                                    class="actdelete btn btn-xs btn-danger">
                                                                    <i class="fa fa-times" aria-hidden="true" title="Delete Contact"></i>
                                                                </a>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>

                                                <%--</dx:PanelContent>
                                                    </PanelCollection>
                                                </dx:ASPxCallbackPanel>--%>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <!-- Row end -->
                    </dx:PanelContent>
                </PanelCollection>

            </dx:ASPxCallbackPanel>


            <dx:ASPxCallbackPanel runat="server" ID="gridPanel3" ClientInstanceName="gridPanel3" OnCallback="gridPanel_Callback_sliktasklistextract">
                <ClientSideEvents EndCallback="function(s, e) {
                        if (s.cp_new != '' && s.cp_new != undefined) {
                            window.open(s.cp_new,'_parent');
                            s.cp_new = '';
                        }
                        if (s.cp_url != '' && s.cp_url != undefined) {
                            window.open(s.cp_url,'_blank,toolbar=no, location=yes,status=no,menubar=no,scrollbars=yes,resizable=no');
                            s.cp_url = '';
                        }
                        if (s.cp_alert != '' && s.cp_alert != undefined) {
                            alert(s.cp_alert);
                            s.cp_alert = '';
                        }
                    }" />
                <PanelCollection>
                    <dx:PanelContent ID="PanelContent2" runat="server">
                        <!-- Row start -->
                        <div class="row modalpos">
                            <div class="col-md-12 col-sm-12 col-xs-12">
                                <div class="card card-primary card-outline">
                                    <div class="card-header">
                                        <div class="row">
                                            <div class="col col-xs-6">
                                                <h4 class="card-title">Setting User SLIK Extract</h4>
                                            </div>
                                            <div class="col col-xs-6 text-right">
                                                <button id="Button2" runat="server" type="button" class="open-myModal-tasklistextract btn btn-xs btn-success" data-toggle="modal" data-collateralid="" data-collateralseq="" data-target="#myModaltasklistextract">
                                                    <i class="fa fa-plus" aria-hidden="true"></i>
                                                    &nbsp Tambah
                                                   
                                                </button>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="card-body">
                                        <div class="container-fluid">
                                            <div class="table-responsive">

                                                <asp:GridView ID="gvsliktasklistextract" runat="server" Width="100%"
                                                    CssClass="table table-sm table-striped table-bordered table-hover"
                                                    AutoGenerateColumns="False"
                                                    AllowPaging="True"
                                                    OnPageIndexChanged="gvsliktasklistextract_PageIndexChanged"
                                                    OnPageIndexChanging="gvsliktasklistextract_PageIndexChanging"
                                                    OnRowDataBound="gvsliktasklistextract_RowDataBound">
                                                    <PagerStyle HorizontalAlign="Right" />
                                                    <Columns>
                                                        <asp:BoundField DataField="userid" HeaderText="ID" />
                                                        <asp:BoundField DataField="serviceid" HeaderText="User Name" />
                                                        <%--<asp:BoundField DataField="pwd_viewer" HeaderText="Nama Kerabat" />--%>

                                                        <asp:TemplateField HeaderText="Function">
                                                            <ItemStyle Width="15%"></ItemStyle>
                                                            <ItemTemplate>
                                                                <a id="lnkEdit" runat="server"
                                                                    data-toggle="modal"
                                                                    data-target="#myModaltasklistextract" title="Edit Tasklist"
                                                                    data-aid='<%# Eval("extractid") %>'
                                                                    data-aseq='<%# Eval("serviceid") %>'
                                                                    data-aregno='<%# Eval("userid") %>'
                                                                    class="open-myModal-tasklistextract btn btn-xs btn-primary">
                                                                    <i class="fa fa-adjust" aria-hidden="true" title="Edit Tasklist"></i>
                                                                </a>
                                                                <a id="lnkDelete" runat="server"
                                                                    data-toggle="tooltip" title="Delete Tasklist"
                                                                    data-aid='<%# Eval("extractid") %>'
                                                                    data-aseq='<%# Eval("serviceid") %>'
                                                                    data-aregno='<%# Eval("userid") %>'
                                                                    class="actdelete3 btn btn-xs btn-danger">
                                                                    <i class="fa fa-times" aria-hidden="true" title="Delete Tasklist"></i>
                                                                </a>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>

                                                <%--</dx:PanelContent>
                                                    </PanelCollection>
                                                </dx:ASPxCallbackPanel>--%>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <!-- Row end -->
                    </dx:PanelContent>
                </PanelCollection>

            </dx:ASPxCallbackPanel>


            <!-- start main modal myModaltasklistextract-->
            <div class="modal fade" id="myModaltasklistextract" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog"
                aria-labelledby="myModaltasklistextractLabel" aria-hidden="true">

                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title" id="H1">Slik Tasklist Extract</h4>
                            <dx:ASPxButton ID="ASPxButton2" runat="server" AutoPostBack="False"
                                Text="x" ClientInstanceName="btnClose" CssClass="btn btn-sm close" formnovalidate>
                                <ClientSideEvents Click="function(s, e) { 
                                        $('#ModalSliktasklistextract').attr('src', '');
                                        $('#myModaltasklistextract').modal('hide');
                                        gridPanel.PerformCallback('u:' + e.callbackData);                                                     
                                    }"></ClientSideEvents>
                            </dx:ASPxButton>
                        </div>

                        <div class="modal-body">
                            <iframe id="ModalSliktasklistextract" name="ModalSliktasklistextract" class="embed-responsive-item" framespacing="0" frameborder="0" border="0" width="100%" height="350px"></iframe>
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal-dialog -->
                </div>
                <!-- /.modal -->
            </div>
            <!-- end main modal -->



            <!-- start main modal -->
            <div class="modal fade" id="myModaloginViewer" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog"
                aria-labelledby="myModaloginViewerLabel" aria-hidden="true">

                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">Slik Login Viewer</h4>
                            <dx:ASPxButton ID="btnClose" runat="server" AutoPostBack="False"
                                Text="x" ClientInstanceName="btnClose" CssClass="btn btn-sm close" formnovalidate>
                                <ClientSideEvents Click="function(s, e) { 
                                        $('#ModalSlikLoginViewer').attr('src', '');
                                        $('#myModaloginViewer').modal('hide');
                                        gridPanel.PerformCallback('u:' + e.callbackData);                                                     
                                    }"></ClientSideEvents>
                            </dx:ASPxButton>
                        </div>

                        <div class="modal-body">
                            <iframe id="ModalSlikLoginViewer" name="ModalSlikLoginViewer" class="embed-responsive-item" framespacing="0" frameborder="0" border="0" width="100%" height="350px"></iframe>
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal-dialog -->
                </div>
                <!-- /.modal -->
            </div>
            <!-- end main modal -->

            <!-- start main modal -->
            <div class="modal fade" id="myModalogin" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog"
                aria-labelledby="myModaloginLabel" aria-hidden="true">

                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">

                            <h4 class="modal-title">Slik Login</h4>
                            <dx:ASPxButton ID="ASPxButton1" runat="server" AutoPostBack="False"
                                Text="x" ClientInstanceName="btnClose" CssClass="btn btn-sm close" formnovalidate>
                                <ClientSideEvents Click="function(s, e) { 
                                        $('#ModalSlikLogin').attr('src', '');
                                        $('#myModalogin').modal('hide');
                                        gridPanel.PerformCallback('u:' + e.callbackData);                                                     
                                    }"></ClientSideEvents>
                            </dx:ASPxButton>
                        </div>

                        <div class="modal-body">
                            <iframe id="ModalSlikLogin" name="ModalSlikLogin" class="embed-responsive-item" framespacing="0" frameborder="0" border="0" width="100%" height="350px"></iframe>
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal-dialog -->
                </div>
                <!-- /.modal -->
            </div>
            <!-- end main modal -->

        </form>
    </div>
</body>
</html>
