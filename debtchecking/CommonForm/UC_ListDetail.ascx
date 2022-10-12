<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UC_ListDetail.ascx.cs" Inherits="DebtChecking.List.UC_ListDetail" %>

<%@ Register Assembly="DevExpress.Web.v20.2" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Src="UC_ListFilter.ascx" TagName="UC_ListFilter" TagPrefix="uc1" %>
<style>
    .text-sm .content-header {
        padding: 5px .5rem;
    }
</style>

<dx:ASPxCallbackPanel ID="listPanel" ClientInstanceName="listPanel" runat="server" Width="100%">

    <PanelCollection>
        <dx:PanelContent ID="PanelContent1" runat="server">
            <div class="card card-primary card-outline">
                <div class="card-header">
                    <h3 class="card-title">
                        <i class="fas fa-list-alt"></i>
                        <asp:Label ID="TitleHeader" runat="server"></asp:Label>
                    </h3>
                </div>
                <div class="card-body overflow-auto">
                    <uc1:UC_ListFilter ID="UC_ListFilter1" runat="server" />
                    <dx:ASPxGridView ID="grid" runat="server" ClientInstanceName="grid" Theme="MaterialCompact"
                        AutoGenerateColumns="False" Width="100%" Font-Size="11px" OnLoad="grid_Load"
                        OnHtmlRowPrepared="grid_HtmlRowPrepared"
                        OnAfterPerformCallback="grid_AfterPerformCallback">
                        <ClientSideEvents
                            EndCallback="function(s, e) {
                try
                {
                    window.parent.resizeFrame();
                }
                catch(e)
                {
                };
                }" />
                        <%--<SettingsBehavior AutoFilterRowInputDelay="-1" />--%>
                        <Columns>
                            <dx:GridViewCommandColumn Visible="false" VisibleIndex="0" Width="1px">
                            </dx:GridViewCommandColumn>
                            <dx:GridViewCommandColumn Visible="false" ShowSelectCheckbox="True" VisibleIndex="0" Width="1px">
                                <HeaderTemplate>
                                    <table>
                                        <tr>
                                            <td>
                                                <a href="javascript:grid.SelectRows();">Select All</a>&nbsp;<br />
                                                <a href="javascript:grid.UnselectRows();">Unselect All</a>&nbsp;
                                            </td>
                                        </tr>
                                    </table>
                                </HeaderTemplate>
                            </dx:GridViewCommandColumn>
                        </Columns>
                    </dx:ASPxGridView>
                    <dx:ASPxGridViewExporter ID="gridExport" runat="server" GridViewID="grid"></dx:ASPxGridViewExporter>
                </div>
                <div class="card-footer">
                    <asp:Button class="Bt1" ID="btnSave" runat="server" Text="Process" Visible="false" OnClick="btnSave_Click" />
                    <asp:Button class="Bt1" ID="btnExport" runat="server" Text="Export" Visible="false" OnClick="btnExport_Click" />
                </div>
            </div>
        </dx:PanelContent>
    </PanelCollection>
</dx:ASPxCallbackPanel>