<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SLIKResult.aspx.cs" Inherits="DebtChecking.Facilities.SLIKResult" %>

<%@ Register TagPrefix="dx" Namespace="DevExpress.Web" Assembly="DevExpress.Web.v20.2, Version=20.2, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>SID Text</title>
    <Template:Admin runat="server" ID="Template" />
    <!-- #include file="~/include/onepost.html" -->
    <script language="javascript" type="text/javascript">
        function kliklink(linkid, url) {
            linkdesc = document.getElementById(linkid).innerHTML;
            document.getElementById(linkid).innerHTML = "<b>" + linkdesc + "</b>";
            document.getElementById("IFR_TEXT").src = url;
            document.getElementById("pdfPanel_urlframe").value = url;
            if (url.indexOf('PDF') > 0 || url.indexOf('notyetuploaded') >= 0) document.getElementById("btnpdf").style.display = 'none';
            else document.getElementById("btnpdf").style.display = '';
        }
    </script>
</head>
<body class="text-sm">
    <form id="form1" runat="server">
        <label>IDeb File</label>
        | <a id="creditsummary" href='<%= ResolveUrl("~/SLIK/SLIKCreditSummary.aspx?passurl&mntitle=SLIK%20Checking%20Result&regno=") + Request.QueryString["regno"]%>'>Credit Summary</a>
        | <a id="collateral" href='<%= ResolveUrl("~/SLIK/Collateral.aspx?passurl&mntitle=SLIK%20Checking%20Result&regno=") + Request.QueryString["regno"]%>'>Collateral</a>

        <div>
            <dx:ASPxCallbackPanel ID="mainPanel" runat="server" Width="100%"
                OnCallback="mainPanel_Callback" ClientInstanceName="mainPanel">
                <ClientSideEvents EndCallback="function(s, e) {
	if(s.hasOwnProperty('cp_export') && s.cp_export!='')
	{
	    window.open(s.cp_export);
	    /*mydoc = window.open();
        mydoc.document.write(s.cp_export);
        mydoc.document.execCommand('saveAs',true,s.cp_filename+'.txt');
        mydoc.close();
		s.cp_export = '';*/
		return false;
	}
}" />
                <PanelCollection>
                    <dx:PanelContent ID="PanelContent1" runat="server">

                        <table id="DataDebitur" class="card" width="100%">
                            <tr style="display: none">
                                <td class="H1" colspan="2">Data Debitur</td>
                            </tr>
                            <tr valign="top">
                                <td width="50%">
                                    <table class="table table-sm  table-borderless table-responsive m-2" width="100%">
                                        <tr>
                                            <td>Customer Name</td>
                                            <td>:</td>
                                            <td>
                                                <asp:Label Font-Bold="true" ID="cust_name" runat="server"></asp:Label>
                                                <input type="hidden" runat="server" id="appid" />
                                                <input id="reffnumber" runat="server" type="hidden" />
                                                <input id="nikcount" runat="server" type="hidden" />
                                                <asp:Label ID="status_app" runat="server" Style="display: none"></asp:Label>
                                                <%--<a href="javascript:PopupPage('DetailCustomer.aspx?regno='+document.getElementById('mainPanel_appid').value,640,400)">[detail]</a>--%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Place / Date of Birth</td>
                                            <td>:</td>
                                            <td>
                                                <asp:Label ID="pob_dob" runat="server"></asp:Label></td>
                                        </tr>
                                        <tr style="display: none">
                                            <td>NPWP</td>
                                            <td>:</td>
                                            <td>
                                                <asp:Label ID="npwp" runat="server"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td>Gender</td>
                                            <td>:</td>
                                            <td>
                                                <asp:Label ID="genderdesc" runat="server"></asp:Label></td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="50%">
                                    <table width="100%" class="table table-sm table-borderless table-responsive  m-2">
                                        <tr>
                                            <td>KTP / NIK</td>
                                            <td>:</td>
                                            <td>
                                                <asp:Label ID="ktp" runat="server"></asp:Label></td>
                                        </tr>
                                        <%-- <tr>
                                                <td>KTP Address</td>
                                                <td>:</td>
                                                <td>
                                                    <asp:Label ID="full_ktpaddress" runat="server"></asp:Label></td>
                                            </tr>--%>
                                        <tr style="display: none">
                                            <td>Policy Result</td>
                                            <td>:</td>
                                            <td>
                                                <asp:Label Font-Bold="true" Font-Size="Small" ForeColor="Red" ID="final_policy" runat="server"></asp:Label></td>
                                        </tr>
                                        <tr style="display: none">
                                            <td>Mother Name</td>
                                            <td>:</td>
                                            <td>
                                                <asp:Label ID="mother_name" runat="server"></asp:Label></td>
                                        </tr>
                                        <tr style="display: none">
                                            <td>Home Address</td>
                                            <td>:</td>
                                            <td>
                                                <asp:Label ID="full_homeaddress" runat="server"></asp:Label></td>
                                        </tr>
                                        <tr style="display: none">
                                            <td>Emergency Name / Address</td>
                                            <td>:</td>
                                            <td>
                                                <asp:Label ID="full_econaddress" runat="server"></asp:Label></td>
                                        </tr>
                                        <tr style="display: none">
                                            <td>Office Name / Address</td>
                                            <td>:</td>
                                            <td>
                                                <asp:Label ID="full_officeaddress" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxCallbackPanel>
            <div class="card">
                <table width="100%">
                    <tr style="display: none">
                        <td class="H1" colspan="2">HASIL CREDIT CHECKING</td>
                    </tr>
                    <tr>
                        <td align="center" colspan="2">
                            <input type="button" visible="false" value="Preview" id="btnprint" runat="server" name="btnprint" onclick="javascript: PopupPage(document.getElementById('IFR_TEXT').contentWindow.document.location + '&preview=1', 800, 600, 'yes');" />
                            <button type="button" id="btnpdf" class="btn btn-primary m-2" runat="server"
                                onclick='callback(pdfPanel, document.getElementById("pdfPanel_urlframe").value)'>
                                <span class="fa fa-file-pdf"></span>&nbsp;Save As PDF
                            </button>
                            <dx:ASPxCallbackPanel ID="pdfPanel" runat="server" Width="100%"
                                OnCallback="pdfPanel_Callback" ClientInstanceName="pdfPanel">
                                <PanelCollection>
                                    <dx:PanelContent ID="PanelContent2" runat="server">
                                        <input type="hidden" id="urlframe" runat="server" />
                                    </dx:PanelContent>
                                </PanelCollection>
                            </dx:ASPxCallbackPanel>
                        </td>
                    </tr>
                    <tr id="TR_FRAME" runat="server">
                        <td colspan="2">
                            <table width="100%">
                                <tr>
                                    <td valign="top" width="210">
                                        <div id="dv_found" runat="server" class="m-2">
                                            <h4><span class="badge badge-success">FOUND</span></h4>
                                            <hr />
                                            <asp:Table ID="TB_SIDLIST" runat="server" Width="100%" CssClass="table table-sm table-bordered"></asp:Table>
                                            <p>
                                                <button runat="server" id="Button1" type="button" style="display: none" class="btn btn-sm btn-primary mb-2" onclick="callback(mainPanel, 's:');">
                                                    <span class="fa fa-save"></span>&nbsp;Save & Recalculate</button>
                                                <br />
                                                <button runat="server" id="Button2" type="button" style="display: none" class="btn btn-sm  btn-primary mb-2" onclick="callback(mainPanel, 'd:');">
                                                    <span class="fa fa-download"></span>&nbsp;Download PDF&TXT</button>
                                            </p>
                                        </div>
                                        <div id="dv_nihil" runat="server"><u><strong>NOT FOUND</strong></u></div>
                                        <br />
                                        <asp:Table ID="TB_NIHIL" runat="server" Width="100%" CellSpacing="0" CellPadding="2"></asp:Table>
                                    </td>
                                    <td style="border-right: #33ffff groove; border-top: #33ffff groove; border-left: #33ffff groove; border-bottom: #33ffff groove"
                                        valign="top" bordercolor="#33ffff" align="center">

                                        <asp:HtmlIframe ID="IFR_TEXT" name="IFR_TEXT" frameborder="no" width="100%" height="600" runat="server"></asp:HtmlIframe>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr id="TR_MSG" runat="server">
                        <td align="center" colspan="2">
                            <asp:Label ID="LBL_MSG" Font-Bold="true" runat="server" ForeColor="Red" Text="DATA ONPROCESS"></asp:Label></td>
                    </tr>
                </table>
            </div>
        </div>
    </form>
</body>
</html>