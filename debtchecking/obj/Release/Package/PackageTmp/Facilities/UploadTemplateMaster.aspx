﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UploadTemplateMaster.aspx.cs" Inherits="DebtChecking.Facilities.UploadTemplateMaster" %>

<%@ Register TagPrefix="dx" Namespace="DevExpress.Web" Assembly="DevExpress.Web.v20.2, Version=20.2, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link href="../include/style.css" type="text/css" rel="Stylesheet" />
    <!-- #include file="~/include/onepost.html" -->
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <table width="50%" align="center" class="Box1" id="tbl_upload">
                <tr>
                    <td colspan="3" align="center" class="H1">Upload Loan Calculator Master Template</td>
                </tr>
                <tr>
                    <td class="B01">Select File </td>
                    <td class="BS">:</td>
                    <td class="B11">
                        <dx:ASPxUploadControl ID="ImportFile" runat="server" ClientInstanceName="ImportFile"
                            OnFileUploadComplete="ImportFile_FileUploadComplete" Font-Size="X-Small" Width="400">
                            <ClientSideEvents FileUploadComplete="function(s, e) {
                        processing=false;
                        tbl_upload.style.display = 'none';
                        form1.TXT_PROGRESS.value = '';
                        callback(PanelFile,'',false);
                        tbl_upload.style.display = '';
                     }"></ClientSideEvents>
                        </dx:ASPxUploadControl>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" align="center">
                        <input id="btnSave" runat="server" class="Bt1" onclick="if (ImportFile.GetText() != '') {
        if (!processing) {
            processing = true;
            ImportFile.UploadFile();
        };
    };"
                            type="button" value=" Upload " />
                    </td>
                </tr>
                <tr>
                    <td colspan="3" align="center">
                        <asp:TextBox ID="TXT_PROGRESS" runat="server" ReadOnly="true" BorderStyle="None" Columns="60" Visible="false"></asp:TextBox>
                    </td>
                </tr>
            </table>

            <dx:ASPxCallbackPanel ID="PanelFile" ClientInstanceName="PanelFile" runat="server" OnCallback="PanelFile_Callback">
                <PanelCollection>
                    <dx:PanelContent ID="PanelContent3" runat="server">
                        <center>
                            <asp:TextBox ID="TXT_RESULT" runat="server" ReadOnly="true" BorderStyle="None" Columns="60" Visible="false"></asp:TextBox>
                        </center>
                    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxCallbackPanel>
        </div>
    </form>
</body>
</html>