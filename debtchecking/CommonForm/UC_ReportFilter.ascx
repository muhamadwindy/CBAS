<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UC_ReportFilter.ascx.cs" Inherits="DebtChecking.Report.UC_ReportFilter" %>

<style>
    .form-control {
        height: 25px !important;
        padding: 0
    }

    .dxeButtonEditSys {
        border-spacing: 0;
        border-collapse: unset;
    }

    .dxeButtonEdit {
        border: 1px solid #9F9F9F;
    }

        .dxeButtonEdit td.dxic {
            padding-left: 10px;
        }

    body input.dxeEditArea {
        color: #A0A0A0;
    }
</style>
<div id="mainTbl" runat="server" class="card card-primary card-outline">
    <div class="card-header">
        <h3 class="card-title">
            <i class="fas fa-search"></i>
            Search Criteria
        </h3>
    </div>
    <div class="card-body">
        <div class="row">
            <div class="col-12 col-md-6">
                <asp:Table ID="tblSearch" runat="server" Width="100%">
                </asp:Table>
            </div>
        </div>
        <div class="row">
            <div class="col-12 col-md-6">
                <input runat="server" class="btn btn-primary btn-sm hidden" type="button" value="Search" onclick="mainPanel.PerformCallback()" />
                <input runat="server" id="clrButton" class="btn btn-default btn-sm" style="display: none" type="button" value="Clear" />
            </div>
        </div>
    </div>
</div>