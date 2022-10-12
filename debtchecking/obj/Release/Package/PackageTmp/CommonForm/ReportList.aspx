<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReportList.aspx.cs" Inherits="DebtChecking.Report.ReportList" %>

<%@ Register Src="UC_ReportFilter.ascx" TagName="UC_ReportFilter" TagPrefix="uc1" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web" Assembly="DevExpress.Web.v20.2, Version=20.2, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
    <title></title>

    <Template:Admin runat="server" ID="Template" />
    <!-- #include file="~/include/onepost.html" -->
    <script>

        var ftable;
        function bindDataTable(s, e) {
            ftable = $('#<%=grid.ClientID%>').DataTable({
                responsive: true,
                dom: 'Bfrtip',
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

            var tableFilter = document.getElementById("ctl00_ContentPlaceHolder1_mainPanel_UC_ReportFilter1_tblSearch");
            var grid = document.getElementById("ctl00_ContentPlaceHolder1_mainPanel_grid");

            for (var r = 0, n = tableFilter.rows.length; r < n; r++) {
                var idxSearchCol = getColumnIndexesByClass(tableFilter.rows[r].cells[0].innerHTML);

                var element = tableFilter.rows[r].cells[2].children[0];
                $('#' + element.id).attr('data-index', idxSearchCol);

                $('#' + element.id).keyup(function () {
                    var idsrc = $('#' + element.id).attr('data-index');
                    //setSearchParam($(this).val(), idsrc);

                    var xxx = $(this).data('index');
                    ftable.column($(this).data('index')).search($(this).val()).draw();
                });
            }

            function getColumnIndexesByClass(judul) {
                for (var i = 0, row; row = grid.rows[i]; i++) {
                    for (var j = 0, col; col = row.cells[j]; j++) {
                        if (judul == col.innerHTML) {
                            return j;
                        }
                    }
                }
            }

            var datanotfound = $('#ctl00_ContentPlaceHolder1_mainPanel_grid tbody td')[0];
            if (datanotfound.innerHTML == "&nbsp;") {
                datanotfound.parentElement.remove();
                var trnot = document.createElement("tr");
                var tdnot = document.createElement("td");
                $(tdnot).attr('colspan', '100');
                tdnot.innerHTML = "Data not found!";
                trnot.append(tdnot);
                $('#ctl00_ContentPlaceHolder1_mainPanel_grid tbody').append(trnot);

            }

        }

        $(document).ready(function () {

            //$('#ctl00_ContentPlaceHolder1_mainPanel_UC_ReportFilter1_InputFilter4').keyup(function () {
            //    ftable.search($(this).val()).draw();
            //});

            //function setSearchParam(ygdicari, idx) {

            //    $.fn.dataTable.ext.search.push(
            //        function (settings, data, dataIndex) {
            //            var val_data = data[idx]; // use data for the age column

            //            if (val_data == ygdicari) {
            //                return true;
            //                break;
            //            }
            //            return false;
            //        }
            //    );
            //}

        });
    </script>
</head>
<body>
    <form id="form1" runat="server">

        <dx:ASPxCallbackPanel ID="mainPanel" ClientInstanceName="mainPanel" OnCallback="mainPanel_Callback"
            runat="server" Width="100%" ClientSideEvents-EndCallback="bindDataTable">
            <PanelCollection>
                <dx:PanelContent runat="server">
                    <uc1:UC_ReportFilter ID="UC_ReportFilter1" runat="server" />
                    <div class="card card-primary card-outline">
                        <div class="card-header">
                            <h3 class="card-title">
                                <i class="fas fa-list-alt"></i>&nbsp;Data Report
                                        <asp:Label ID="TitleHeader" runat="server"></asp:Label>
                            </h3>
                        </div>
                        <div class="card-body">
                            <div class="row p-1">
                                <div class="col-sm-12">
                                    <asp:GridView ID="grid"
                                        RowHeaderColumn="True" ShowHeaderWhenEmpty="true" runat="server" AutoGenerateColumns="false"
                                        CssClass="table table-sm table-bordered">
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxCallbackPanel>
    </form>
</body>
</html>