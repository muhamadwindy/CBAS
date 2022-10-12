<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReportPivot.aspx.cs" Inherits="DebtChecking.Report.ReportPivot" %>

<%@ Register TagPrefix="dx" Namespace="DevExpress.Web" Assembly="DevExpress.Web.v20.2, Version=20.2, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<%@ Register Assembly="DevExpress.Web.ASPxPivotGrid.v20.2" Namespace="DevExpress.Web.ASPxPivotGrid" TagPrefix="dxwpg" %>

<%@ Register Src="UC_ReportFilter.ascx" TagName="UC_ReportFilter" TagPrefix="uc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <Template:Admin runat="server" ID="Template" />
</head>
<body>
    <form id="form1" runat="server">

        <div>
            <dx:ASPxCallbackPanel ID="mainPanel" ClientInstanceName="mainPanel"
                runat="server" Width="100%">
                <PanelCollection>
                    <dx:PanelContent runat="server">
                        <uc1:UC_ReportFilter ID="UC_ReportFilter1" runat="server" />

                        <div class="card card-primary card-outline">
                            <div class="card-header">
                                <h3 class="card-title">
                                    <i class="fas fa-list-alt"></i>
                                    <asp:Label ID="TitleHeader" runat="server"></asp:Label>
                                </h3>
                            </div>
                            <div class="card-body">
                                <div class="row p-1">
                                    <div class="col-sm-12">
                                        <button type="button" class="btn btn-success" onclick="grid.PerformCallback('e:pdf')">
                                            <i class="fa fa-file-pdf"></i>
                                            Export to PDF
                                        </button>
                                        <button type="button" class="btn btn-success" onclick="grid.PerformCallback('e:xls')">
                                            <i class="fa fa-file-excel"></i>
                                            Export to XLS
                                        </button>
                                        <button type="button" class="btn btn-success" onclick="grid.PerformCallback('e:rtf')">
                                            <i class="fa fa-file"></i>
                                            Export to RTF
                                        </button>
                                        <button type="button" class="btn btn-success" onclick="grid.PerformCallback('e:csv')">
                                            <i class="fa fa-file-csv"></i>
                                            Export to CSV
                                        </button>
                                    </div>
                                </div>
                                <div class="row p-1">
                                    <div class="col-sm-12">
                                        <dxwpg:ASPxPivotGrid ID="grid" Width="100%" runat="server" ClientInstanceName="grid" OnLoad="grid_Load" OnCustomCallback="grid_CustomCallback">
                                            <ClientSideEvents AfterCallback="function(s, e) {
    if(s.hasOwnProperty('cp_export') && s.cp_export!='')
	{
		window.open(s.cp_export);
		s.cp_export = '';
	}
}" />
                                        </dxwpg:ASPxPivotGrid>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <dxwpg:ASPxPivotGridExporter ID="gridExport" runat="server" ASPxPivotGridID="grid">
                        </dxwpg:ASPxPivotGridExporter>
                    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxCallbackPanel>
        </div>
    </form>
</body>
</html>