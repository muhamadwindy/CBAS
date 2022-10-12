<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Report.aspx.cs" Inherits="DebtChecking.Report.Report" %>

<%@ Register TagPrefix="dx" Namespace="DevExpress.Web" Assembly="DevExpress.Web.v20.2, Version=20.2, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <Template:Admin runat="server" ID="Template" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid text-sm">
            <div class="card">
                <div class="card-body">
                    <div class="row">
                        <div class="col-sm-6">
                            <asp:Table ID="tblFilter" runat="server">
                            </asp:Table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="card-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <dx:ASPxCallbackPanel ID="mainPanel" runat="server" Width="100%" BackColor="Transparent"
                                ClientInstanceName="mainPanel" OnCallback="mainPanel_Callback">
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
                                        <asp:HiddenField ID="paramSearch" runat="server" />
                                        <dx:ASPxGridView ID="ASPxGridView1" runat="server" OnBeforeExport="ASPxGridView1_BeforeExport" OnPageIndexChanged="ASPxGridView1_PageIndexChanged">
                                        </dx:ASPxGridView>
                                    </dx:PanelContent>
                                </PanelCollection>
                            </dx:ASPxCallbackPanel>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
<script>
    $("#btnSearch").click(function (event) {
        event.preventDefault(); // cancel default behavior
        var filterField = $("input[name^='filter']");
        var strFilter = "";
        for (var field of filterField) {
            strFilter += field.value + ",";
        }
        mainPanel.PerformCallback('search:' + strFilter.substring(0, strFilter.length - 1));
    });
    window.onbeforeunload = function () {
        mainPanel.PerformCallback('remsession:');
    }
</script>
</html>