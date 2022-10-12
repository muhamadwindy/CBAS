<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UploadTemplate.aspx.cs" Inherits="MikroMnt.Parameter.UploadTemplate" %>

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Page</title>
    <link href="../include/style.css" type="text/css" rel="Stylesheet" />
    <!-- #include file="~/include/onepost.html" -->
    <!-- #include file="~/include/uc/UC_Number.html" -->
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table width="100%">
                <tr>
                    <td class="H0" align="right">
                        <a href="ParamSet.aspx?set=ent&ismaker=1&title=Calculation Parameter">
                            <img src="../image/back.jpg" alt="back" /></a>
                        <a href="../Body.aspx">
                            <img alt="" src="../image/MainMenu.jpg" border="0" />
                        </a>
                        <a href="../Logout.aspx">
                            <img alt="" src="../image/logout.jpg" border="0" />
                        </a>
                    </td>
                </tr>
            </table>

            <dx:ASPxCallbackPanel ID="PanelFile" ClientInstanceName="PanelFile" runat="server">
                <PanelCollection>
                    <dx:PanelContent ID="PanelContent3" runat="server">
                        <table width="50%" align="center" class="Box1">
                            <tr>
                                <td colspan="3" align="center" class="H1">Upload Calculator Template</td>
                            </tr>
                            <tr>
                                <td>Catatan </td>
                                <td>:</td>
                                <td>
                                    <asp:Label runat="server" ID="Label1" ForeColor="#336699">Pastikan nama sheet 
                    dari file yang akan diimport adalah &quot;New Loan&quot;</asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>Select File </td>
                                <td>:</td>
                                <td>
                                    <dx:ASPxUploadControl ID="ImportFile" runat="server" ClientInstanceName="ImportFile"
                                        OnFileUploadComplete="ImportFile_FileUploadComplete" Font-Size="X-Small" Width="100%">
                                        <ClientSideEvents FileUploadComplete="function(s, e) { processing=false; callback(PanelFile,'r:',false); }"></ClientSideEvents>
                                    </dx:ASPxUploadControl>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" align="center">
                                    <input id="btnSave" runat="server" class="Bt1" onclick="
    if (ImportFile.GetText() != '') {
        if (!processing) {
            processing = true;
            ImportFile.UploadFile();
        };
    }"
                                        type="button" value=" Upload "></input>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" align="center">
                                    <asp:Label runat="server" ID="lbl_result" ForeColor="Red"></asp:Label>
                            </tr>
                        </table>

                    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxCallbackPanel>

        </div>
    </form>
</body>
</html>
