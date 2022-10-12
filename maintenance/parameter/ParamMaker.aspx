<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ParamMaker.aspx.cs" Inherits="MikroMnt.Parameter.ParamMaker" %>

<%@ Register Src="USC_paraminput.ascx" TagName="USC_paraminput" TagPrefix="uc1" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
    <link href="../include/style.css" type="text/css" rel="Stylesheet" />
    <!-- #include file="~/include/onepost.html" -->
    <!-- #include file="~/include/uc/UC_Currency.html" -->
    <!-- #include file="~/include/uc/UC_Decimal.html" -->
    <style type="text/css">
        .hide {
            display: none;
        }

        .pendingDelete {
            display: none;
        }
    </style>
    <script src="../App_Themes/mwstyle/plugins/jquery/jquery.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <%--  <table width="100%">
        <tr>
            <td class="H0" align="right">
                <a href="<% =BackURL %>"><img src="../image/back.jpg" alt="back" /></a>
                <a href="../Body.aspx"><img src="../image/MainMenu.JPG" alt="mainmenu" /></a>
                <a href="../Logout.aspx" target="_top"><img src="../image/logout.jpg" alt="logout" /></a>
            </td>
        </tr>
    </table>--%>
            <table class="Box1" width="100%">
                <tr class="H1">
                    <td>
                        <asp:Label ID="title" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <dx:ASPxPageControl ID="PageCtrl" runat="server" ActiveTabIndex="0"
                            Width="100%">
                            <TabPages>
                                <dx:TabPage Text="Existing Parameter">
                                    <ContentCollection>
                                        <dx:ContentControl ID="ContentControl1" runat="server">
                                            <dx:ASPxGridView ID="grid" ClientInstanceName="grid" runat="server"
                                                AutoGenerateColumns="False"
                                                Width="100%"
                                                Font-Size="10px"
                                                OnLoad="grid_Load"
                                                OnBeforeColumnSortingGrouping="grid_BeforeColumnSortingGrouping"
                                                OnCustomCallback="grid_CustomCallback">
                                                <Settings ShowFilterRow="True" ShowGroupedColumns="True"
                                                    ShowGroupPanel="True" />
                                                <Columns>
                                                    <dx:GridViewCommandColumn VisibleIndex="0" Width="1px" ShowClearFilterButton="true">
                                                    </dx:GridViewCommandColumn>
                                                    <dx:GridViewDataColumn Caption="Function" VisibleIndex="1" Width="1%">
                                                        <CellStyle Wrap="False">
                                                        </CellStyle>
                                                        <HeaderTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <input class="Bt1" type="button" value="New" onclick="popup$panel$USC_paraminput1$clrButton.click(); popup.Show()" />
                                                                    </td>
                                                                </tr>
                                                                <tr class="<%=funcCss %>">
                                                                    <td>
                                                                        <input class="Bt1" type="button" onclick="grid.ExpandAll();" value=" Expand All " />
                                                                    </td>
                                                                </tr>
                                                                <tr class="<%=funcCss %>">
                                                                    <td>
                                                                        <input class="Bt1" type="button" onclick="grid.CollapseAll();" value="Collapse All" />
                                                                    </td>
                                                                </tr>
                                                            </table>

                                                        </HeaderTemplate>
                                                        <DataItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <input class="Bt1" type="button" value="Edit" onclick="<%# "popup.Show();panel.PerformCallback('r:" + Container.KeyValue.ToString().Replace("'","\\'") + "')"%>" />
                                                                    </td>
                                                                    <td>
                                                                        <input class="Bt1 deleteData" type="button" value="Delete"  data-id="<%#Container.KeyValue.ToString() %>" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </DataItemTemplate>
                                                    </dx:GridViewDataColumn>
                                                </Columns>
                                                <SettingsBehavior AutoFilterRowInputDelay="-1" />
                                                <SettingsPager PageSize="12">
                                                </SettingsPager>
                                            </dx:ASPxGridView>
                                            <script>

                                                $('.deleteData').on("click", function(){
                                                    if (confirm('Are You Sure ?')) {
                                                        var id = $(this).data('id');
                                                        debugger;
                                                        gridpending.PerformCallback('d:' + id);
                                                        alert('berhasil');
                                                    } 
                                                });
                                                        
                                            </script>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:TabPage>
                                <dx:TabPage Text="Pending Approval">
                                    <ContentCollection>
                                        <dx:ContentControl ID="ContentControl2" runat="server">
                                            <dx:ASPxGridView ID="gridpending" ClientInstanceName="gridpending"
                                                runat="server" AutoGenerateColumns="False"
                                                Width="100%"
                                                Font-Size="10px"
                                                OnLoad="gridpending_Load"
                                                OnBeforeColumnSortingGrouping="gridpending_BeforeColumnSortingGrouping"
                                                OnCustomCallback="gridpending_CustomCallback">
                                                <Settings ShowFilterRow="True" ShowGroupedColumns="True"
                                                    ShowGroupPanel="True" />
                                                <Columns>
                                                    <dx:GridViewCommandColumn VisibleIndex="0" Width="1px" ShowClearFilterButton="true">
                                                    </dx:GridViewCommandColumn>
                                                    <dx:GridViewDataColumn Caption="Function" VisibleIndex="0" Width="1%">
                                                        <CellStyle Wrap="False">
                                                        </CellStyle>
                                                        <HeaderTemplate>
                                                            <table>
                                                                <tr class="<%=funcpendCss %>">
                                                                    <td>
                                                                        <input class="Bt1" type="button" onclick="gridpending.ExpandAll();" value=" Expand All " />
                                                                    </td>
                                                                </tr>
                                                                <tr class="<%=funcpendCss %>">
                                                                    <td>
                                                                        <input class="Bt1" type="button" onclick="gridpending.CollapseAll();" value="Collapse All" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </HeaderTemplate>
                                                        <DataItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td class="<%# "pending" + Eval("__STATUS").ToString() %>">
                                                                        <input class="Bt1" type="button" value="Edit" onclick="<%# "popup.Show();panel.PerformCallback('rp:" + Container.KeyValue.ToString().Replace("'","\\'") + "')"%>" />
                                                                    </td>
                                                                    <td>
                                                                        <input class="Bt1" type="button" value="Delete" onclick="<%# "gridpending.PerformCallback('dp:" + Container.KeyValue.ToString().Replace("'","\\'") + "')"%>" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </DataItemTemplate>
                                                    </dx:GridViewDataColumn>
                                                </Columns>
                                                <SettingsBehavior AutoFilterRowInputDelay="-1" />
                                                <SettingsPager PageSize="12">
                                                </SettingsPager>
                                            </dx:ASPxGridView>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:TabPage>
                            </TabPages>
                        </dx:ASPxPageControl>

                        <dx:ASPxPopupControl ID="popup" ClientInstanceName="popup" runat="server" HeaderText="" Width="800px" 
                            PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" CloseAction="CloseButton" Modal="True"
                            AllowDragging="True" EnableAnimation="False" >
                            <ContentCollection>
                                <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server" Height="100%">
                                    <dx:ASPxCallbackPanel ID="panel" runat="server" ClientInstanceName="panel"
                                        OnCallback="panel_Callback">
                                        <ClientSideEvents EndCallback="function(s, e){ if(panel.cp_action=='s'){processing=false; gridpending.PerformCallback('');}                            
                                            
                                if (s.hasOwnProperty('cp_closepopup') && s.cp_closepopup != '') {
                                            
                                                            popup.Hide();
                                            alert('Berhasil!');
                                }
                                            }" />
                                        <PanelCollection>
                                            <dx:PanelContent ID="PanelContent1" runat="server">
                                                <uc1:USC_paraminput ID="USC_paraminput1" runat="server" />
                                            </dx:PanelContent>
                                        </PanelCollection>
                                    </dx:ASPxCallbackPanel>
                                </dx:PopupControlContentControl>
                            </ContentCollection>
                        </dx:ASPxPopupControl>

                    </td>
                </tr>
            </table>

        </div>
    </form>
</body>
</html>
