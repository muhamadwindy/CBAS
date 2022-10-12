<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Collateral.aspx.cs" Inherits="DebtChecking.SLIK.Collateral" %>

<%@ Register TagPrefix="dx" Namespace="DevExpress.Web" Assembly="DevExpress.Web.v20.2, Version=20.2, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SID Text Page</title>
    <!-- #include file="~/include/onepost.html" -->
    <Template:Admin runat="server" ID="Template" />
</head>
<body class="text-sm">
    <form id="form1" runat="server">
        <a id="idepfile" href='<%= ResolveUrl("~/SLIK/SLIKResult.aspx?passurl&mntitle=SLIK%20Checking%20Result&regno=") + Request.QueryString["regno"]%>'>IDeb File</a>
        | <a id="creditsummary" href='<%= ResolveUrl("~/SLIK/SLIKCreditSummary.aspx?passurl&mntitle=SLIK%20Checking%20Result&regno=") + Request.QueryString["regno"]%>'>Credit Summary</a>
        |
            <label>Collateral</label>

        <table class="card p-2" width="100%">
            <tr>
                <td>
                    <h6>Data Debitur</h6>
                    <hr />
                    <table id="DataDebitur" width="100%">

                        <tr valign="top">
                            <td width="50%">
                                <table class="table table-sm table-borderless table-responsive" width="100%">
                                    <tr>
                                        <td>Customer Name</td>
                                        <td>:</td>
                                        <td>
                                            <asp:Label Font-Bold="true" ID="cust_name" runat="server"></asp:Label>
                                            <input type="hidden" runat="server" id="status_app" />
                                            <input type="hidden" runat="server" id="reffnumber" />
                                            <input type="hidden" runat="server" id="appid" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Place / Date Of Birth</td>
                                        <td>:</td>
                                        <td>
                                            <asp:Label ID="pob_dob" runat="server"></asp:Label></td>
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
                                <table class="table table-sm table-borderless table-responsive" width="100%">
                                    <tr>
                                        <td>KTP / NIK</td>
                                        <td>:</td>
                                        <td>
                                            <asp:Label ID="ktp" runat="server"></asp:Label></td>
                                    </tr>
                                    <%--   <tr>
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
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2" style="display: none">
                                <button id="btnprint" runat="server" class="btn btn-sm btn-primary " onclick="this.style.display = 'none'; document.getElementById('ctl00_ContentPlaceHolder1_btnpdf').style.display = 'none'; window.print(); this.style.display = ''; document.getElementById('ctl00_ContentPlaceHolder1_btnpdf').style.display = '';">
                                    <span class="fa fa-print"></span>&nbsp;Print</button>
                                <button id="btnpdf" class="btn btn-sm btn-primary" runat="server" onclick="callback(pdfPanel, '')">
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
                    </table>
                    <h6>Data Agunan</h6>
                    <hr />
                    <table id="DataAgunan" width="100%">
                        <tr>
                            <td>
                                <dx:ASPxGridView ID="GridViewColl" runat="server" Width="100%" AutoGenerateColumns="False" Theme="MaterialCompact"
                                    ClientInstanceName="GridViewColl" KeyFieldName="COLL_SEQ"
                                    OnLoad="GridViewColl_Load" Font-Size="X-Small">
                                    <Columns>
                                        <dx:GridViewDataTextColumn Caption="NIK" FieldName="nik"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn Caption="Bank" FieldName="ljkName"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn Caption="Jenis Agunan" FieldName="jenisAgunanKet"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn Caption="Nilai Bank" FieldName="nilaiAgunanMenurutLJK">
                                            <PropertiesTextEdit DisplayFormatString="{0:###,##0.##}"></PropertiesTextEdit>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn Caption="Nilai Independen" FieldName="nilaiAgunanIndep">
                                            <PropertiesTextEdit DisplayFormatString="{0:###,##0.##}"></PropertiesTextEdit>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn Caption="Tgl Penilaian" FieldName="tglPenilaianPelapor">
                                            <PropertiesTextEdit DisplayFormatString="dd/MMM/yyyy"></PropertiesTextEdit>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn Caption="Pemilik" FieldName="namaPemilikAgunan"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn Caption="Bukti Kepemilikan" FieldName="buktiKepemilikan"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn Caption="Pengikatan" FieldName="jenisPengikatanKet"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn Caption="Alamat Jaminan" FieldName="alamatAgunan"></dx:GridViewDataTextColumn>
                                    </Columns>
                                    <SettingsPager PageSize="10" />
                                    <Settings ShowFilterRow="false" ShowGroupPanel="false" ShowGroupedColumns="true" />
                                    <SettingsBehavior AllowGroup="true" />
                                </dx:ASPxGridView>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>