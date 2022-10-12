<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UC_UploadFile.ascx.cs" Inherits="DebtChecking.CommonForm.UC_UploadFile" %>

<%@ Register TagPrefix="dx" Namespace="DevExpress.Web" Assembly="DevExpress.Web.v20.2, Version=20.2, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>

<table class="Tbl0" id="tbm" runat="server">
    <tr>
        <td class="H1" colspan="2">
            <asp:Label ID="ttl" runat="server">File Upload</asp:Label></td>
    </tr>
    <tr valign="top">
        <td width="40%">
            <table class="Tbl0">
                <tr>
                    <td class="B03">Select File</td>
                    <td class="BS">:</td>
                    <td class="B11">
                        <dx:ASPxUploadControl ID="upfile" runat="server" Font-Size="X-Small" Width="100%"
                            OnFileUploadComplete="upfile_FileUploadComplete">
                        </dx:ASPxUploadControl>
                        <asp:Label ID="lblEr" runat="server"></asp:Label>
                        <!-- <label id="LBL_MAXDOCFILESIZE" runat="server">(maximum file size: 200kB)</label> -->
                    </td>
                </tr>
                <tr>
                    <td colspan="3" class="F1">
                        <input type="button" id="btnup" runat="server" class="Bt1" value="Upload"></input>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>