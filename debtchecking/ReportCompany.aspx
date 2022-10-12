<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="ReportCompany.aspx.cs" Inherits="DebtChecking.ReportCompany" %>

<%@ Register TagPrefix="dx" Namespace="DevExpress.Web" Assembly="DevExpress.Web.v20.2, Version=20.2, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title></title>
    <Template:Admin runat="server" ID="Template" />
    <script>
        function Search(panel) {
            var param;
            if (panel.globalName == 'PanelPengajuanRequest') {
                param = $('#PR_txtIDRequest').val() + '|';
                param += $('#PR_txtPeriode').val() == "" ? ' - ' : $('#PR_txtPeriode').val();
            } else if (panel.globalName == 'PanelRingkasanHasilSLIK') {
                param = $('#RHS_txtIDRequestCBAS').val() + '|';
                param += $('#RHS_txtIDPermintaanCBAS').val() + '|';
                param += $('#RHS_txtPeriode').val() == "" ? ' - ' : $('#RHS_txtPeriode').val();
            } else if (panel.globalName == 'PanelDebitur') {
                param = $('#D_txtIDRequestCBAS').val() + '|';
                param += $('#D_txtIDPermintaanCBAS').val() + '|';
                param += $('#D_txtPeriode').val() == "" ? ' - ' : $('#D_txtPeriode').val();
            } else if (panel.globalName == 'PanelPengurus') {
                param = $('#PG_txtIDRequestCBAS').val() + '|';
                param += $('#PG_txtIDPermintaanCBAS').val() + '|';
                param += $('#PG_txtPeriode').val() == "" ? ' - ' : $('#PG_txtPeriode').val();
            } else if (panel.globalName == 'PanelFasilitas') {
                param = $('#FA_txtIDRequestCBAS').val() + '|';
                param += $('#FA_txtIDPermintaanCBAS').val() + '|';
                param += $('#FA_txtIDFasilitas').val() + '|';
                param += $('#FA_txtPeriode').val() == "" ? ' - ' : $('#FA_txtPeriode').val();
            } else if (panel.globalName == 'PanelAgunan') {
                param = $('#AG_txtIDRequestCBAS').val() + '|';
                param += $('#AG_txtIDPermintaanCBAS').val() + '|';
                param += $('#AG_txtIDFasilitas').val() + '|';
                param += $('#AG_txtPeriode').val() == "" ? ' - ' : $('#AG_txtPeriode').val();
            } else if (panel.globalName == 'PanelPenjamin') {
                param = $('#PJ_txtIDRequestCBAS').val() + '|';
                param += $('#PJ_txtIDPermintaanCBAS').val() + '|';
                param += $('#PJ_txtIDFasilitas').val() + '|';
                param += $('#PJ_txtPeriode').val() == "" ? ' - ' : $('#PJ_txtPeriode').val();
            }
            panel.PerformCallback('s:' + param);
        }
        $(document).ready(function () {
            $(window).keydown(function (event) {
                if (event.keyCode == 13) {
                    event.preventDefault();
                    return false;
                }
            });
        });
        $(document).ready(function () {
            $('#PR_txtIDRequest').on('keyup', function (event) {
                debugger
                if (event.keyCode === 13) {
                    $("#PR_btnSearch").click();
                }
            });
            $('#RHS_txtIDRequestCBAS').on('keyup', function (event) {
                debugger
                if (event.keyCode === 13) {
                    $("#RHS_btnSearch").click();
                }
            });
            $('#D_txtIDRequestCBAS').on('keyup', function (event) {
                debugger
                if (event.keyCode === 13) {
                    $("#D_btnSearch").click();
                }
            });
            $('#PG_txtIDRequestCBAS').on('keyup', function (event) {
                debugger
                if (event.keyCode === 13) {
                    $("#D_btnSearch").click();
                }
            });
            $('#FA_txtIDRequestCBAS').on('keyup', function (event) {
                debugger
                if (event.keyCode === 13) {
                    $("#FA_btnSearch").click();
                }
            });
            $('#AG_txtIDRequestCBAS').on('keyup', function (event) {
                debugger
                if (event.keyCode === 13) {
                    $("#AG_btnSearch").click();
                }
            });
            $('#PJ_txtIDRequestCBAS').on('keyup', function (event) {
                debugger
                if (event.keyCode === 13) {
                    $("#PJ_btnSearch").click();
                }
            });
        });

        function bindDataTablePengajuanRequest(s, e) {
            prtable = $('#<%=GridPengajuanRequest.ClientID%>').DataTable({
                responsive: true,
                dom: 'Bfrtip',
                "lengthChange": false,
                searching: false,
                buttons: [{
                    extend: 'excel',
                    text: 'Export To Excel',
                    className: 'btn btn-success mr-1 mb-1',
                    title: 'Customized EXCEL Title',
                    filename: 'report'
                }, {
                    extend: 'csv',
                    text: 'Export To CSV',
                    className: 'btn btn-success mr-1 mb-1',
                    filename: 'report'
                }]

            });
        }
        function bindDataTableRingkasanHasilSLIK(s, e) {
            rhstable = $('#<%=GridRingkasanHasilSLIK.ClientID%>').DataTable({
                responsive: true,
                dom: 'Bfrtip',
                "lengthChange": false,
                searching: false,
                buttons: [{
                    extend: 'excel',
                    text: 'Export To Excel',
                    className: 'btn btn-success mr-1 mb-1',
                    title: 'Customized EXCEL Title',
                    filename: 'report'
                }, {
                    extend: 'csv',
                    text: 'Export To CSV',
                    className: 'btn btn-success mr-1 mb-1',
                    filename: 'report'
                }]

            });
        }
        function bindDataTableDebitur(s, e) {
            debtable = $('#<%=GridDebitur.ClientID%>').DataTable({
                responsive: true,
                dom: 'Bfrtip',
                searching: false,
                "lengthChange": false,
                buttons: [{
                    extend: 'excel',
                    text: 'Export To Excel',
                    className: 'btn btn-success mr-1 mb-1',
                    title: 'Customized EXCEL Title',
                    filename: 'report'
                }, {
                    extend: 'csv',
                    text: 'Export To CSV',
                    className: 'btn btn-success mr-1 mb-1',
                    filename: 'report'
                }]

            });
        }
        function bindDataTablePengurus(s, e) {
            pgtable = $('#<%=GridPengurus.ClientID%>').DataTable({
                responsive: true,
                dom: 'Bfrtip',
                searching: false,
                "lengthChange": false,
                buttons: [{
                    extend: 'excel',
                    text: 'Export To Excel',
                    className: 'btn btn-success mr-1 mb-1',
                    title: 'Customized EXCEL Title',
                    filename: 'report'
                }, {
                    extend: 'csv',
                    text: 'Export To CSV',
                    className: 'btn btn-success mr-1 mb-1',
                    filename: 'report'
                }]

            });
        }
        function bindDataTableFasilitas(s, e) {
            fasbtable = $('#<%=GridFasilitas.ClientID%>').DataTable({
                responsive: true,
                dom: 'Bfrtip',
                searching: false,
                "lengthChange": false,
                buttons: [{
                    extend: 'excel',
                    text: 'Export To Excel',
                    className: 'btn btn-success mr-1 mb-1',
                    title: 'Customized EXCEL Title',
                    filename: 'report'
                }, {
                    extend: 'csv',
                    text: 'Export To CSV',
                    className: 'btn btn-success mr-1 mb-1',
                    filename: 'report'
                }]

            });
        }
        function bindDataTableAgunan(s, e) {
            agbtable = $('#<%=GridAgunan.ClientID%>').DataTable({
                responsive: true,
                dom: 'Bfrtip',
                searching: false,
                "lengthChange": false,
                buttons: [{
                    extend: 'excel',
                    text: 'Export To Excel',
                    className: 'btn btn-success mr-1 mb-1',
                    title: 'Customized EXCEL Title',
                    filename: 'report'
                }, {
                    extend: 'csv',
                    text: 'Export To CSV',
                    className: 'btn btn-success mr-1 mb-1',
                    filename: 'report'
                }]

            });
        }
        function bindDataTablePenjamin(s, e) {
            pjbtable = $('#<%=GridPenjamin.ClientID%>').DataTable({
                responsive: true,
                dom: 'Bfrtip',
                searching: false,
                "lengthChange": false,
                buttons: [{
                    extend: 'excel',
                    text: 'Export To Excel',
                    className: 'btn btn-success mr-1 mb-1',
                    title: 'Customized EXCEL Title',
                    filename: 'report'
                }, {
                    extend: 'csv',
                    text: 'Export To CSV',
                    className: 'btn btn-success mr-1 mb-1',
                    filename: 'report'
                }]

            });
        }
    </script>
</head>
<body>
    <div class="container-fluid text-sm">
        <form id="form1" runat="server">
            <div class="row">
                <div class="col-sm-12">
                    <div class="card card-primary card-outline card-tabs">
                        <div class="card-header p-0 pt-1 border-bottom-0">
                            <ul class="nav nav-tabs" id="custom-tabs-two-tab" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active" id="link-tab-pengajuan-request" data-toggle="pill"
                                        href="#tab-pengajuan-request" role="tab" aria-controls="tab-pengajuan-request"
                                        aria-selected="true">Pengajuan Request</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="link-tab-ringk-slik" data-toggle="pill"
                                        href="#tab-ringk-slik" role="tab" aria-controls="tab-ringk-slik"
                                        aria-selected="false">Ringkasan Hasil SLIK</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="link-tab-debitur" data-toggle="pill"
                                        href="#tab-debitur" role="tab" aria-controls="tab-debitur"
                                        aria-selected="false">Debitur</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="link-tab-pengurus" data-toggle="pill"
                                        href="#tab-pengurus" role="tab" aria-controls="tab-pengurus"
                                        aria-selected="false">Pengurus</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="link-tab-fasilitas" data-toggle="pill"
                                        href="#tab-fasilitas" role="tab" aria-controls="tab-fasilitas"
                                        aria-selected="false">Fasilitas</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="link-tab-agunan" data-toggle="pill"
                                        href="#tab-agunan" role="tab" aria-controls="tab-agunan"
                                        aria-selected="false">Agunan</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="link-tab-penjamin" data-toggle="pill"
                                        href="#tab-penjamin" role="tab" aria-controls="tab-penjamin"
                                        aria-selected="false">Penjamin</a>
                                </li>
                            </ul>
                        </div>
                        <div class="card-body">
                            <div class="tab-content" id="tabContent">
                                <div class="tab-pane fade active show" id="tab-pengajuan-request" role="tabpanel"
                                    aria-labelledby="tab-pengajuan-request">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <div class="row">
                                                        <div class="col-sm-12">
                                                            <h6>Search Criteria : </h6>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-2 col-form-label">ID Request CBAS</label>
                                                        <div class="col-sm-5">
                                                            <input id="PR_txtIDRequest" type="text" maxlength="200"
                                                                class="form-control form-control-sm" />
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-2 col-form-label">Periode</label>
                                                        <div class="col-sm-5">
                                                            <input id="PR_txtPeriode" type="text" maxlength="100"
                                                                class="form-control form-control-sm datepicker" />
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-sm-2">
                                                        </div>
                                                        <div class="col-sm-10">
                                                            <button id="PR_btnSearch" type="button"
                                                                onclick="Search(PanelPengajuanRequest);return false;"
                                                                class="btn btn-sm btn-primary">
                                                                Search</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <hr />
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <dx:ASPxCallbackPanel ID="PanelPengajuanRequest" ClientInstanceName="PanelPengajuanRequest"
                                                        OnCallback="PanelPengajuanRequest_Callback"
                                                        ClientSideEvents-EndCallback="bindDataTablePengajuanRequest"
                                                        runat="server" Width="100%">
                                                        <PanelCollection>
                                                            <dx:PanelContent runat="server">
                                                                <div class="row">
                                                                    <div class="col-sm-12">
                                                                        <asp:GridView ID="GridPengajuanRequest" runat="server"
                                                                            OnRowDataBound="GridPengajuanRequest_RowDataBound"
                                                                            RowHeaderColumn="true"
                                                                            ShowHeaderWhenEmpty="true"
                                                                            EmptyDataText="No Data!"
                                                                            CssClass="table table-bordered table-responsive">
                                                                        </asp:GridView>
                                                                    </div>
                                                                </div>
                                                            </dx:PanelContent>
                                                        </PanelCollection>
                                                    </dx:ASPxCallbackPanel>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="tab-ringk-slik" role="tabpanel"
                                    aria-labelledby="tab-ringk-slik">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <div class="row">
                                                        <div class="col-sm-12">
                                                            <h6>Search Criteria : </h6>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-2 col-form-label">ID Request CBAS</label>
                                                        <div class="col-sm-5">
                                                            <input id="RHS_txtIDRequestCBAS" type="text" maxlength="200"
                                                                class="form-control form-control-sm" />
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-2 col-form-label">ID Permintaan CBAS</label>
                                                        <div class="col-sm-5">
                                                            <input id="RHS_txtIDPermintaanCBAS" type="text" maxlength="200"
                                                                class="form-control form-control-sm" />
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-2 col-form-label">Periode</label>
                                                        <div class="col-sm-5">
                                                            <input id="RHS_txtPeriode" type="text" maxlength="100"
                                                                class="form-control form-control-sm datepicker" />
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-sm-2">
                                                        </div>
                                                        <div class="col-sm-10">
                                                            <button id="RHS_btnSearch" type="button"
                                                                onclick="Search(PanelRingkasanHasilSLIK);return false;"
                                                                class="btn btn-sm btn-primary">
                                                                Search</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <hr />
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <dx:ASPxCallbackPanel ID="PanelRingkasanHasilSLIK" ClientInstanceName="PanelRingkasanHasilSLIK"
                                                        OnCallback="PanelRingkasanHasilSLIK_Callback"
                                                        ClientSideEvents-EndCallback="bindDataTableRingkasanHasilSLIK"
                                                        runat="server" Width="100%">
                                                        <PanelCollection>
                                                            <dx:PanelContent runat="server">
                                                                <div class="row">
                                                                    <div class="col-sm-12">
                                                                        <asp:GridView ID="GridRingkasanHasilSLIK" runat="server"
                                                                            OnRowDataBound="GridRingkasanHasilSLIK_RowDataBound"
                                                                            RowHeaderColumn="true"
                                                                            ShowHeaderWhenEmpty="true"
                                                                            EmptyDataText="No Data!"
                                                                            CssClass="table table-bordered table-responsive">
                                                                        </asp:GridView>
                                                                    </div>
                                                                </div>
                                                            </dx:PanelContent>
                                                        </PanelCollection>
                                                    </dx:ASPxCallbackPanel>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="tab-pengurus" role="tabpanel"
                                    aria-labelledby="tab-pengurus">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <div class="row">
                                                        <div class="col-sm-12">
                                                            <h6>Search Criteria : </h6>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-2 col-form-label">ID Request CBAS</label>
                                                        <div class="col-sm-5">
                                                            <input id="PG_txtIDRequestCBAS" type="text" maxlength="200"
                                                                class="form-control form-control-sm" />
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-2 col-form-label">ID Permintaan CBAS</label>
                                                        <div class="col-sm-5">
                                                            <input id="PG_txtIDPermintaanCBAS" type="text" maxlength="200"
                                                                class="form-control form-control-sm" />
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-2 col-form-label">Periode</label>
                                                        <div class="col-sm-5">
                                                            <input id="PG_txtPeriode" type="text" maxlength="100"
                                                                class="form-control form-control-sm datepicker" />
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-sm-2">
                                                        </div>
                                                        <div class="col-sm-10">
                                                            <button id="PG_btnSearch" type="button"
                                                                onclick="Search(PanelPengurus);return false;"
                                                                class="btn btn-sm btn-primary">
                                                                Search</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <hr />
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <dx:ASPxCallbackPanel ID="PanelPengurus" ClientInstanceName="PanelPengurus"
                                                        OnCallback="PanelPengurus_Callback"
                                                        ClientSideEvents-EndCallback="bindDataTablePengurus"
                                                        runat="server" Width="100%">
                                                        <PanelCollection>
                                                            <dx:PanelContent runat="server">
                                                                <div class="row">
                                                                    <div class="col-sm-12">
                                                                        <asp:GridView ID="GridPengurus" runat="server"
                                                                            OnRowDataBound="GridPengurus_RowDataBound"
                                                                            RowHeaderColumn="true"
                                                                            ShowHeaderWhenEmpty="true"
                                                                            EmptyDataText="No Data!"
                                                                            CssClass="table table-bordered table-responsive">
                                                                        </asp:GridView>
                                                                    </div>
                                                                </div>
                                                            </dx:PanelContent>
                                                        </PanelCollection>
                                                    </dx:ASPxCallbackPanel>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="tab-debitur" role="tabpanel"
                                    aria-labelledby="tab-debitur">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <div class="row">
                                                        <div class="col-sm-12">
                                                            <h6>Search Criteria : </h6>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-2 col-form-label">ID Request CBAS</label>
                                                        <div class="col-sm-5">
                                                            <input id="D_txtIDRequestCBAS" type="text" maxlength="200"
                                                                class="form-control form-control-sm" />
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-2 col-form-label">ID Permintaan CBAS</label>
                                                        <div class="col-sm-5">
                                                            <input id="D_txtIDPermintaanCBAS" type="text" maxlength="200"
                                                                class="form-control form-control-sm" />
                                                        </div>
                                                    </div>

                                                    <div class="form-group row">
                                                        <label class="col-sm-2 col-form-label">Periode</label>
                                                        <div class="col-sm-5">
                                                            <input id="D_txtPeriode" type="text" maxlength="100"
                                                                class="form-control form-control-sm datepicker" />
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-sm-2">
                                                        </div>
                                                        <div class="col-sm-10">
                                                            <button id="D_btnSearch" type="button"
                                                                onclick="Search(PanelDebitur);return false;"
                                                                class="btn btn-sm btn-primary">
                                                                Search</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <hr />
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <dx:ASPxCallbackPanel ID="PanelDebitur" ClientInstanceName="PanelDebitur"
                                                        OnCallback="PanelDebitur_Callback"
                                                        ClientSideEvents-EndCallback="bindDataTableDebitur"
                                                        runat="server" Width="100%">
                                                        <PanelCollection>
                                                            <dx:PanelContent runat="server">
                                                                <div class="row">
                                                                    <div class="col-sm-12">
                                                                        <asp:GridView ID="GridDebitur" runat="server"
                                                                            OnRowDataBound="GridView1_RowDataBound"
                                                                            RowHeaderColumn="true"
                                                                            ShowHeaderWhenEmpty="true"
                                                                            EmptyDataText="No Data!"
                                                                            CssClass="table table-bordered table-responsive">
                                                                        </asp:GridView>
                                                                    </div>
                                                                </div>
                                                            </dx:PanelContent>
                                                        </PanelCollection>
                                                    </dx:ASPxCallbackPanel>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="tab-fasilitas" role="tabpanel"
                                    aria-labelledby="tab-fasilitas">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <div class="row">
                                                        <div class="col-sm-12">
                                                            <h6>Search Criteria : </h6>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-2 col-form-label">ID Request CBAS</label>
                                                        <div class="col-sm-5">
                                                            <input id="FA_txtIDRequestCBAS" type="text" maxlength="200"
                                                                class="form-control form-control-sm" />
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-2 col-form-label">ID Permintaan CBAS</label>
                                                        <div class="col-sm-5">
                                                            <input id="FA_txtIDPermintaanCBAS" type="text" maxlength="200"
                                                                class="form-control form-control-sm" />
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-2 col-form-label">ID Fasilitas</label>
                                                        <div class="col-sm-5">
                                                            <input id="FA_txtIDFasilitas" type="text" maxlength="200"
                                                                class="form-control form-control-sm" />
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-2 col-form-label">Periode</label>
                                                        <div class="col-sm-5">
                                                            <input id="FA_txtPeriode" type="text" maxlength="100"
                                                                class="form-control form-control-sm datepicker" />
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-sm-2">
                                                        </div>
                                                        <div class="col-sm-10">
                                                            <button id="FA_btnSearch" type="button"
                                                                onclick="Search(PanelFasilitas);return false;"
                                                                class="btn btn-sm btn-primary">
                                                                Search</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <hr />
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <dx:ASPxCallbackPanel ID="PanelFasilitas" ClientInstanceName="PanelFasilitas"
                                                        OnCallback="PanelFasilitas_Callback"
                                                        ClientSideEvents-EndCallback="bindDataTableFasilitas"
                                                        runat="server" Width="100%">
                                                        <PanelCollection>
                                                            <dx:PanelContent runat="server">
                                                                <div class="row">
                                                                    <div class="col-sm-12">
                                                                        <asp:GridView ID="GridFasilitas" runat="server"
                                                                            OnRowDataBound="GridFasilitas_RowDataBound"
                                                                            RowHeaderColumn="true"
                                                                            ShowHeaderWhenEmpty="true"
                                                                            EmptyDataText="No Data!"
                                                                            CssClass="table table-bordered table-responsive">
                                                                        </asp:GridView>
                                                                    </div>
                                                                </div>
                                                            </dx:PanelContent>
                                                        </PanelCollection>
                                                    </dx:ASPxCallbackPanel>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="tab-agunan" role="tabpanel"
                                    aria-labelledby="tab-agunan">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <div class="row">
                                                        <div class="col-sm-12">
                                                            <h6>Search Criteria : </h6>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-2 col-form-label">ID Request CBAS</label>
                                                        <div class="col-sm-5">
                                                            <input id="AG_txtIDRequestCBAS" type="text" maxlength="200"
                                                                class="form-control form-control-sm" />
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-2 col-form-label">ID Permintaan CBAS</label>
                                                        <div class="col-sm-5">
                                                            <input id="AG_txtIDPermintaanCBAS" type="text" maxlength="200"
                                                                class="form-control form-control-sm" />
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-2 col-form-label">ID Fasilitas</label>
                                                        <div class="col-sm-5">
                                                            <input id="AG_txtIDFasilitas" type="text" maxlength="200"
                                                                class="form-control form-control-sm" />
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-2 col-form-label">Periode</label>
                                                        <div class="col-sm-5">
                                                            <input id="AG_txtPeriode" type="text" maxlength="100"
                                                                class="form-control form-control-sm datepicker" />
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-sm-2">
                                                        </div>
                                                        <div class="col-sm-10">
                                                            <button id="AG_btnSearch" type="button"
                                                                onclick="Search(PanelAgunan);return false;"
                                                                class="btn btn-sm btn-primary">
                                                                Search</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <hr />
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <dx:ASPxCallbackPanel ID="PanelAgunan" ClientInstanceName="PanelAgunan"
                                                        OnCallback="PanelAgunan_Callback"
                                                        ClientSideEvents-EndCallback="bindDataTableAgunan"
                                                        runat="server" Width="100%">
                                                        <PanelCollection>
                                                            <dx:PanelContent runat="server">
                                                                <div class="row">
                                                                    <div class="col-sm-12">
                                                                        <asp:GridView ID="GridAgunan" runat="server"
                                                                            OnRowDataBound="GridAgunan_RowDataBound"
                                                                            RowHeaderColumn="true"
                                                                            ShowHeaderWhenEmpty="true"
                                                                            EmptyDataText="No Data!"
                                                                            CssClass="table table-bordered table-responsive">
                                                                        </asp:GridView>
                                                                    </div>
                                                                </div>
                                                            </dx:PanelContent>
                                                        </PanelCollection>
                                                    </dx:ASPxCallbackPanel>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="tab-penjamin" role="tabpanel"
                                    aria-labelledby="tab-penjamin">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <div class="row">
                                                        <div class="col-sm-12">
                                                            <h6>Search Criteria : </h6>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-2 col-form-label">ID Request CBAS</label>
                                                        <div class="col-sm-5">
                                                            <input id="PJ_txtIDRequestCBAS" type="text" maxlength="200"
                                                                class="form-control form-control-sm" />
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-2 col-form-label">ID Permintaan CBAS</label>
                                                        <div class="col-sm-5">
                                                            <input id="PJ_txtIDPermintaanCBAS" type="text" maxlength="200"
                                                                class="form-control form-control-sm" />
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-2 col-form-label">ID Fasilitas</label>
                                                        <div class="col-sm-5">
                                                            <input id="PJ_txtIDFasilitas" type="text" maxlength="200"
                                                                class="form-control form-control-sm" />
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-2 col-form-label">Periode</label>
                                                        <div class="col-sm-5">
                                                            <input id="PJ_txtPeriode" type="text" maxlength="100"
                                                                class="form-control form-control-sm datepicker" />
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-sm-2">
                                                        </div>
                                                        <div class="col-sm-10">
                                                            <button id="PJ_btnSearch" type="button"
                                                                onclick="Search(PanelPenjamin);return false;"
                                                                class="btn btn-sm btn-primary">
                                                                Search</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <hr />
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <dx:ASPxCallbackPanel ID="PanelPenjamin" ClientInstanceName="PanelPenjamin"
                                                        OnCallback="PanelPenjamin_Callback"
                                                        ClientSideEvents-EndCallback="bindDataTablePenjamin"
                                                        runat="server" Width="100%">
                                                        <PanelCollection>
                                                            <dx:PanelContent runat="server">
                                                                <div class="row">
                                                                    <div class="col-sm-12">
                                                                        <asp:GridView ID="GridPenjamin" runat="server"
                                                                            OnRowDataBound="GridPenjamin_RowDataBound"
                                                                            RowHeaderColumn="true"
                                                                            ShowHeaderWhenEmpty="true"
                                                                            EmptyDataText="No Data!"
                                                                            CssClass="table table-bordered table-responsive">
                                                                        </asp:GridView>
                                                                    </div>
                                                                </div>
                                                            </dx:PanelContent>
                                                        </PanelCollection>
                                                    </dx:ASPxCallbackPanel>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- /.card -->
                    </div>
                </div>
            </div>
        </form>
    </div>
</body>
</html>