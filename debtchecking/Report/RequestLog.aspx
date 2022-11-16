<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RequestLog.aspx.cs" Inherits="DebtChecking.Report.RequestLog" %>

<%@ Register TagPrefix="dx" Namespace="DevExpress.Web" Assembly="DevExpress.Web.v20.2, Version=20.2, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>

    <Template:Admin runat="server" ID="Template" />
    <script>
        function Search() {

            let param = $('#txtIDRequest').val() + '|';
            param += $('#txtPeriode').val() == "" ? ' - ' : $('#txtPeriode').val();
            PanelPengajuanRequest.PerformCallback('s:' + param);
        }
        function bindDataTableRequestLog() {
            let prtable = $('#<%=GridReport.ClientID%>').DataTable({
                responsive: true,
                destroy: true,
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

        $(document).ready(function () {
            bindDataTableRequestLog();
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">

        <div class="container-fluid text-sm">

            <div class="row">
                <div class="col-sm-12">
                    <div class="card card-primary card-outline card-tabs">
                        <div class="card-header p-0 pt-1 border-bottom-0">
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
                                                <label class="col-sm-2 col-form-label">Request ID</label>
                                                <div class="col-sm-5">
                                                    <input id="txtIDRequest" type="text" maxlength="200"
                                                        class="form-control form-control-sm" />
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-sm-2 col-form-label">Periode</label>
                                                <div class="col-sm-5">
                                                    <input id="txtPeriode" type="text" maxlength="100"
                                                        class="form-control form-control-sm daterange" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-2">
                                                </div>
                                                <div class="col-sm-10">
                                                    <button id="PR_btnSearch" type="button"
                                                        onclick="Search();return false;"
                                                        class="btn btn-sm btn-primary">
                                                        Search</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-12">
                                    <dx:ASPxCallbackPanel ID="PanelPengajuanRequest" ClientInstanceName="PanelPengajuanRequest"
                                        OnCallback="PanelPengajuanRequest_Callback"
                                        runat="server" Width="100%">
                                        <ClientSideEvents EndCallback="function(s,e) { 
                                            debugger;
                                              bindDataTableRequestLog();                                              
                                              }" />
                                        <PanelCollection>
                                            <dx:PanelContent runat="server">
                                                <div class="row">
                                                    <div class="col-sm-12">
                                                        <asp:GridView ID="GridReport" runat="server"
                                                            RowHeaderColumn="true"
                                                            ShowHeaderWhenEmpty="true"
                                                            EmptyDataText="No Data!"
                                                            CssClass="table table-sm table-bordered table-responsive">
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

    </form>
</body>
</html>
