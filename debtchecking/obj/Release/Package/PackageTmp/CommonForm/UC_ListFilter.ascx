<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UC_ListFilter.ascx.cs" Inherits="DebtChecking.List.UC_ListFilter" %>
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

    .form-control {
        font-size: inherit !important;
    }
</style>
<div id="mainTbl" runat="server" class="card">
    <div class="card-body">
        <div class="row">
            <div class="col-12 col-md-6">
                <asp:Table ID="tblSearch" runat="server">
                </asp:Table>
            </div>
        </div>
        <div class="row">
            <div class="col-12 col-md-6">
                <button id="Button1" runat="server" class="btn btn-primary btn-sm" type="submit">Search</button>
                <button runat="server" id="clrButton" class="btn btn-default btn-sm" type="button">Clear</button>
                <button id="btnnew" runat="server" class="btn btn-success btn-sm" type="button" style="display: none">Input New</button>
            </div>
        </div>
    </div>
</div>