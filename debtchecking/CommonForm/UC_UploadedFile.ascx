<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UC_UploadedFile.ascx.cs" Inherits="DebtChecking.CommonForm.UC_UploadedFile" %>

<%@ Register TagPrefix="dx" Namespace="DevExpress.Web" Assembly="DevExpress.Web.v20.2, Version=20.2, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <Template:Admin ID="templ" runat="server" />
    <title></title>
    <script>
        function cekUploadFile(e) {
            Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(BeginRequestHandler);
            function BeginRequestHandler(sender, args) { var oControl = args.get_postBackElement(); oControl.disabled = true; }
        }
    </script>
</head>
<body>
    <div class="container-fluid">
        <form id="form1" runat="server">
            <table class="Tbl0" id="tbm" runat="server">
                <tr>
                    <td class="H1" colspan="2">
                        <asp:Label ID="ttl" runat="server">File Upload</asp:Label></td>
                </tr>
                <tr valign="top">
                    <td width="40%">
                        <table class="Tbl0">
                            <tr>
                                <td class="B03">File</td>
                                <td class="BS">:</td>
                                <td class="B11">
                                    <dx:ASPxUploadControl ID="upfile" runat="server" Font-Size="X-Small" Width="100%"
                                        OnFileUploadComplete="upfile_FileUploadComplete">
                                        <ValidationSettings
                                            MaxFileSize="2048000"
                                            MaxFileSizeErrorText="File size must not exceed 200kB!">
                                        </ValidationSettings>
                                    </dx:ASPxUploadControl>
                                    <asp:Label ID="lblEr" runat="server"></asp:Label>
                                    <label id="LBL_MAXDOCFILESIZE" runat="server">(maximum file size: 200kB)</label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" class="F1">
                                    <input type="button" id="btnup" runat="server" class="Bt1" value="Upload"></input>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td width="100%">
                        <table class="Tbl0">
                            <tr>
                                <td>
                                    <dx:ASPxCallbackPanel ID="panelFile" runat="server" Width="100%"
                                        OnCallback="panelFile_Callback">
                                        <PanelCollection>
                                            <dx:PanelContent ID="PanelContent3" runat="server">
                                                <table class="Tbl0">
                                                    <tr>
                                                        <td>
                                                            <asp:GridView ID="gridfile" runat="server" AutoGenerateColumns="false"
                                                                Width="100%" CssClass="Dg1" OnRowDataBound="gridfile_RowDataBound">
                                                                <HeaderStyle CssClass="H1" />
                                                                <AlternatingRowStyle CssClass="Alt1" />
                                                                <RowStyle HorizontalAlign="Center" />
                                                                <Columns>
                                                                    <asp:BoundField DataField="SEQ" HeaderText="No" />
                                                                    <asp:BoundField DataField="FILENAME" HeaderText="Nama File">
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="DATE" HeaderText="Tanggal" DataFormatString="{0:dd-MMM-yyyy}" />
                                                                    <asp:TemplateField HeaderText="Function">
                                                                        <ItemTemplate>
                                                                            <asp:HyperLink ID="LNK_DOWN" runat="server">download</asp:HyperLink>
                                                                            <asp:HyperLink ID="LNK_DEL" runat="server">delete</asp:HyperLink>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </dx:PanelContent>
                                        </PanelCollection>
                                    </dx:ASPxCallbackPanel>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>