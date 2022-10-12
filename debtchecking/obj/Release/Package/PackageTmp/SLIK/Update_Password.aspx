<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Update_Password.aspx.cs" Inherits="DebtChecking.SLIK.Update_Password" %>

<%@ Register TagPrefix="dx" Namespace="DevExpress.Web" Assembly="DevExpress.Web.v20.2, Version=20.2, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>User Slik Management</title>
    <Template:Admin runat="server" ID="Template" />

    <style>
        input[type=text], input[type=number], textarea {
            text-transform: unset !important;
        }
    </style>
</head>
<body>
    <div class="container-fluid text-sm">
        <form id="form1" runat="server">
            <dx:ASPxCallbackPanel runat="server" ID="mainPanel" ClientInstanceName="mainPanel" OnCallback="mainPanel_Callback">
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
                        if (s.cp_close_modal != '' && s.cp_close_modal != undefined) {
                            $('#'+ s.cp_close_modal +'').modal('hide');
                            s.cp_close_modal = '';
                        }
                        if (s.cp_tab != '' && s.cp_tab != undefined) {
                            $('#'+ s.cp_tab +'').click();
                            s.cp_tab = '';
                        }
                    }" />
                <PanelCollection>
                    <dx:PanelContent ID="PanelContent1" runat="server">
                        <div class="row">
                            <div class="col-sm-12">
                                <ul class="nav nav-tabs" id="custom-tabs-two-tab" role="tablist">
                                    <li class="nav-item">
                                        <a class="nav-link active" id="link-tab-sliklogin" data-toggle="pill"
                                            href="#tabsliklogin" role="tab" aria-controls="tabsliklogin"
                                            aria-selected="true">SLIK Login</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" id="link-tab-slikviewer" data-toggle="pill"
                                            href="#tabslikviewer" role="tab" aria-controls="tabslikviewer"
                                            aria-selected="false">SLIK Viewer</a>
                                    </li>
                                </ul>
                                <div class="tab-content" id="tabContent">
                                    <div class="tab-pane fade active show" id="tabsliklogin" role="tabpanel"
                                        aria-labelledby="tabsliklogin">
                                        <div class="row modalpos">
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <div class="card">
                                                    <div class="card-body">
                                                        <div class="row">
                                                            <div class="col-sm-6">
                                                                <div class="row">
                                                                    <div class="col col-xs-6">
                                                                        <div class="h5">SLIK Login</div>
                                                                    </div>
                                                                    <div class="col col-xs-6 text-right">
                                                                        <button id="btnAddSLIKLogin" type="button" class="btn btn-xs btn-success">
                                                                            <i class="fa fa-plus" aria-hidden="true"></i>
                                                                            Tambah
                                                                        </button>
                                                                    </div>
                                                                </div>
                                                                <dx:ASPxGridView ID="GridSLIKLogin" runat="server" Width="100%" Theme="MetropolisBlue">
                                                                    <Columns>
                                                                        <dx:GridViewDataColumn FieldName="userid" Caption="ID"></dx:GridViewDataColumn>
                                                                        <dx:GridViewDataColumn FieldName="uid_slik" Caption="UserName"></dx:GridViewDataColumn>
                                                                        <dx:GridViewDataColumn>
                                                                            <DataItemTemplate>
                                                                                <a id="lnkEdit" runat="server"
                                                                                    data-toggle="modal"
                                                                                    data-target="#myModalogin" title="Edit"
                                                                                    data-userid='<%# Eval("userid") %>'
                                                                                    data-uid_slik='<%# Eval("uid_slik") %>'
                                                                                    data-active='<%# Eval("active") %>'
                                                                                    data-flag_spv='<%# Eval("flag_spv") %>'
                                                                                    data-pwd='<%# Eval("pwd_slik") %>'
                                                                                    class="sliklogin_edit btn btn-xs btn-primary">
                                                                                    <i class="fa fa-adjust" aria-hidden="true" title="Edit Contact"></i>
                                                                                </a>
                                                                                <a id="lnkDelete" runat="server"
                                                                                    data-toggle="tooltip" title="Delete"
                                                                                    data-userid='<%# Eval("userid") %>'
                                                                                    data-uid_slik='<%# Eval("uid_slik") %>'
                                                                                    data-active='<%# Eval("active") %>'
                                                                                    data-flag_spv='<%# Eval("flag_spv") %>'
                                                                                    class="sliklogin_delete btn btn-xs btn-danger">
                                                                                    <i class="fa fa-times" aria-hidden="true" title="Delete Contact"></i>
                                                                                </a>
                                                                            </DataItemTemplate>
                                                                        </dx:GridViewDataColumn>
                                                                    </Columns>
                                                                </dx:ASPxGridView>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tab-pane fade" id="tabslikviewer" role="tabpanel"
                                        aria-labelledby="tabslikviewer">
                                        <!-- Row start -->
                                        <div class="row modalpos">
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <div class="card">
                                                    <div class="card-body">
                                                        <div class="row">
                                                            <div class="col-sm-6">
                                                                <div class="row">
                                                                    <div class="col col-xs-6">
                                                                        <div class="h5">
                                                                            SLIK Viewer
                                                                        </div>
                                                                    </div>
                                                                    <div class="col col-xs-6 text-right">
                                                                        <button id="btnAddSLIKViewer" type="button" class="btn btn-xs btn-success" data-toggle="modal" data-target="#myModaloginViewer">
                                                                            <i class="fa fa-plus" aria-hidden="true"></i>
                                                                            Tambah
                                                                        </button>
                                                                    </div>
                                                                </div>
                                                                <dx:ASPxGridView ID="GridSLIKViewer" runat="server" Width="100%"
                                                                    Theme="MetropolisBlue">
                                                                    <Columns>
                                                                        <dx:GridViewDataColumn FieldName="userid" Caption="ID"></dx:GridViewDataColumn>
                                                                        <dx:GridViewDataColumn FieldName="uid_slik" Caption="UserName"></dx:GridViewDataColumn>
                                                                        <dx:GridViewDataColumn>
                                                                            <DataItemTemplate>
                                                                                <a id="lnkEdit" runat="server"
                                                                                    data-toggle="modal"
                                                                                    data-target="#myModaloginViewer" title="Edit"
                                                                                    data-userid='<%# Eval("userid") %>'
                                                                                    data-uid_slik='<%# Eval("uid_slik") %>'
                                                                                    data-pwd='<%# Eval("pwd_viewer") %>'
                                                                                    data-active='<%# Eval("active") %>' class="slikviewer_edit btn btn-xs btn-primary">
                                                                                    <i class="fa fa-adjust" aria-hidden="true" title="Edit Contact"></i>
                                                                                </a>
                                                                                <a id="lnkDelete" runat="server"
                                                                                    data-toggle="tooltip" title="Delete"
                                                                                    data-userid='<%# Eval("userid") %>'
                                                                                    data-uid_slik='<%# Eval("uid_slik") %>'
                                                                                    data-active='<%# Eval("active") %>'
                                                                                    class="slikviewer_delete btn btn-xs btn-danger">
                                                                                    <i class="fa fa-times" aria-hidden="true" title="Delete Contact"></i>
                                                                                </a>
                                                                            </DataItemTemplate>
                                                                        </dx:GridViewDataColumn>
                                                                    </Columns>
                                                                </dx:ASPxGridView>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- Row end -->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxCallbackPanel>

            <div class="modal fade" id="modalSLIKLogin" tabindex="-1" role="dialog"
                aria-labelledby="modalSLIKLogin" aria-hidden="true">
                <div class="modal-dialog modal-xl">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="Label">User SLIK Login</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-sm-6">

                                    <div class="form-group row">
                                        <label class="col-sm-4 col-form-label">
                                            User ID
                                        </label>
                                        <div class="col-sm-8">
                                            <asp:TextBox runat="server" ID="sliklogin_userid" CssClass="form-control input-sm"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-4 col-form-label">
                                            User ID SLIK
                                        </label>
                                        <div class="col-sm-8">
                                            <asp:TextBox runat="server" ID="sliklogin_uid_slik" CssClass="form-control input-sm"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-4 col-form-label">
                                            Password
                                        </label>
                                        <div class="col-sm-8">
                                            <asp:TextBox runat="server" ID="sliklogin_pwd_slik" CssClass="form-control input-sm"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-4 col-form-label">
                                            Is Active ?
                                        </label>
                                        <div class="col-sm-8">
                                            <asp:DropDownList runat="server" ID="sliklogin_active" CssClass="form-control">
                                                <asp:ListItem Selected="True" Text="No" Value="0"></asp:ListItem>
                                                <asp:ListItem Text="yes" Value="1"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label class="col-sm-4 col-form-label">
                                            Is Supervisor ?
                                        </label>
                                        <div class="col-sm-8">
                                            <asp:DropDownList runat="server" ID="sliklogin_flag_spv" CssClass="form-control">
                                                <asp:ListItem Selected="True" Text="No" Value="0"></asp:ListItem>
                                                <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <div class="text-center">
                                <button id="btnsaveSLIKLogin" type="submit" class="btn btn-success mr-1">Save</button>
                                <button class="btn btn-success mr-1" data-dismiss="modal" aria-hidden="true">Cancel</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="modalSLIKViewer" tabindex="-1" role="dialog"
                aria-labelledby="modalSLIKViewer" aria-hidden="true">
                <div class="modal-dialog modal-xl">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="Label">User SLIK Viewer</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-sm-6">

                                    <div class="form-group row">
                                        <label class="col-sm-4 col-form-label">
                                            User ID
                                        </label>
                                        <div class="col-sm-8">
                                            <asp:TextBox runat="server" ID="slikviewer_userid" CssClass="form-control input-sm"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-4 col-form-label">
                                            User ID SLIK
                                        </label>
                                        <div class="col-sm-8">
                                            <asp:TextBox runat="server" ID="slikviewer_uid_slik" CssClass="form-control input-sm"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-4 col-form-label">
                                            Password
                                        </label>
                                        <div class="col-sm-8">
                                            <asp:TextBox runat="server" ID="slikviewer_pwd_viewer" CssClass="form-control input-sm"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-4 col-form-label">
                                            Is Active ?
                                        </label>
                                        <div class="col-sm-8">
                                            <asp:DropDownList runat="server" ID="slikviewer_active" CssClass="form-control">
                                                <asp:ListItem Selected="True" Text="No" Value="0"></asp:ListItem>
                                                <asp:ListItem Text="yes" Value="1"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <div class="text-center">
                                <button id="btnsaveSLIKViewer" class="btn btn-success mr-1">Save</button>
                                <button type="button" class="btn btn-success" data-dismiss="modal" aria-hidden="true">Cancel</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</body>
<script>

    $(document).on("click", "#btnAddSLIKLogin", function () {

        $('#sliklogin_userid').removeAttr('readonly');
        $('#sliklogin_userid').val('');
        $('#sliklogin_uid_slik').val('');
        $('#sliklogin_pwd_slik').val('');
        $('#modalSLIKLogin').modal('show');
    });

    $(document).on("click", "#btnAddSLIKViewer", function () {

        $('#slikviewer_userid').removeAttr('readonly');
        $('#slikviewer_userid').val('');
        $('#slikviewer_uid_slik').val('');
        $('#slikviewer_pwd_viewer').val('');
        $('#modalSLIKViewer').modal('show');
    });

    $(document).on("click", "#btnsaveSLIKLogin", function () {

        var strValidation = ($('#sliklogin_userid').val() == "" ? "User ID is required\r\n" : "") +
            ($('#sliklogin_uid_slik').val() == "" ? "User ID SLIK is required\r\n" : "") +
            ($('#sliklogin_pwd_slik').val() == "" ? "Password is required\r\n" : "");

        if (strValidation != "") {
            alert(strValidation);
        } else {
            callback(mainPanel, "sliklogin_save");
        }
        return false;
    });

    $(document).on("click", "#btnsaveSLIKViewer", function () {
        var strValidation = ($('#slikviewer_userid').val() == "" ? "User ID is required\r\n" : "") +
            ($('#slikviewer_uid_slik').val() == "" ? "User ID SLIK is required\r\n" : "") +
            ($('#slikviewer_pwd_viewer').val() == "" ? "Password is required\r\n" : "");

        if (strValidation != "") {
            alert(strValidation);
        } else {
            callback(mainPanel, "slikviewer_save");
        }
        return false;

    });

    $(document).on("click", ".sliklogin_delete", function () {

        var userid = $(this).data('userid');
        var uid_slik = $(this).data('uid_slik');
        if (confirm('Are you sure to delete ' + uid_slik + ' ?')) {
            callback(mainPanel, "sliklogin_delete:" + userid + "|" + uid_slik);
        }
    });

    $(document).on("click", ".sliklogin_edit", function () {

        $('#sliklogin_userid').attr('readonly', 'readonly');
        var userid = $(this).data('userid');
        var uid_slik = $(this).data('uid_slik');
        var active = $(this).data('active');
        var flag_spv = $(this).data('flag_spv');
        var pwd = $(this).data('pwd');
        $('#sliklogin_userid').val(userid);
        $('#sliklogin_uid_slik').val(uid_slik);
        $('#sliklogin_pwd_slik').val(pwd);
        $('#sliklogin_active').val((active == "True" ? 1 : 0));
        $('#sliklogin_flag_spv').val((flag_spv == "True" ? 1 : 0));
        $('#modalSLIKLogin').modal('show');

    });
    $(document).on("click", ".slikviewer_edit", function () {

        $('#slikviewer_userid').attr('readonly', 'readonly');
        var userid = $(this).data('userid');
        var uid_slik = $(this).data('uid_slik');
        var active = $(this).data('active');
        var pwd = $(this).data('pwd');
        $('#slikviewer_userid').val(userid);
        $('#slikviewer_uid_slik').val(uid_slik);
        $('#slikviewer_pwd_viewer').val(pwd);
        $('#slikviewer_active').val((active == "True" ? 1 : 0));
        $('#modalSLIKViewer').modal('show');

    });

    $(document).on("click", ".slikviewer_delete", function () {

        var userid = $(this).data('userid');
        var uid_slik = $(this).data('uid_slik');
        if (confirm('Are you sure to delete ' + uid_slik + ' ?')) {
            callback(mainPanel, "slikviewer_delete:" + userid + "|" + uid_slik);
        }
    });
</script>
</html>