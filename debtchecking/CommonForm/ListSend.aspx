<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ListSend.aspx.cs" Inherits="DebtChecking.CommonForm.ListSend" %>

<%@ Register TagPrefix="dx" Namespace="DevExpress.Web" Assembly="DevExpress.Web.v20.2, Version=20.2, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<%@ Register Src="~/CommonForm/UC_ListFilter.ascx" TagName="UC_ListFilter" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ListSend Page</title>
    <link href="../include/style.css" type="text/css" rel="Stylesheet" />
    <!-- #include file="~/include/onepost.html" -->
    <Template:Admin runat="server" ID="Template" />
    <script src="../include/cek_mandatoryOnly.js" language="javascript" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <dx:ASPxCallbackPanel ID="listPanel" ClientInstanceName="listPanel" runat="server" Width="100%">
                <PanelCollection>
                    <dx:PanelContent ID="PanelContent1" runat="server">
                        <uc1:UC_ListFilter ID="UC_ListFilter1" runat="server" />
                        <table class="Box1" width="98%">
                            <tr class="H1">
                                <td><b>
                                    <asp:Label ID="TitleHeader" runat="server"></asp:Label></b></td>
                            </tr>
                            <tr>
                                <td style="vertical-align: top">
                                    <dx:ASPxGridView ID="grid" runat="server" ClientInstanceName="grid"
                                        AutoGenerateColumns="False" Width="100%" Font-Size="11px" OnLoad="grid_Load"
                                        OnHtmlRowPrepared="grid_HtmlRowPrepared"
                                        OnAfterPerformCallback="grid_AfterPerformCallback">
                                        <SettingsBehavior AutoFilterRowInputDelay="-1" />
                                        <Columns>
                                            <dx:GridViewCommandColumn ShowSelectCheckbox="True" VisibleIndex="0" Width="1px">
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
                                </td>
                            </tr>
                            <tr>
                                <td class="F2">
                                    <table class="Tbl02">
                                        <tr>
                                            <td>Assign to:</td>
                                            <td>
                                                <asp:DropDownList ID="ddl_Officer" runat="server" CssClass="mandatory"></asp:DropDownList></td>
                                            <td>
                                                <asp:Button class="Bt1" ID="btnSave" runat="server" Text="Assign" OnClick="btnSave_Click" OnClientClick="if (!confirm('Are you sure??')) return false;" /></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxCallbackPanel>
        </div>
    </form>
</body>
</html>