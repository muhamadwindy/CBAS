<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SLIKCreditSummary.aspx.cs" Inherits="DebtChecking.Facilities.SLIKCreditSummary" %>

<%@ Register TagPrefix="dx" Namespace="DevExpress.Web" Assembly="DevExpress.Web.v20.2, Version=20.2, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
    <title>SID Text Page</title>
    <!-- #include file="~/include/onepost.html" -->
    <Template:Admin runat="server" ID="Template" />
    <script>
        function printPDF(param) {
            debugger;
            param.style.display = 'none';
            document.getElementById('ctl00_ContentPlaceHolder1_mainPanel_btnpdf').style.display = 'none';
            //window.print();

            var printContent = document.getElementById("ctl00_ContentPlaceHolder1_mainPanel_GridViewKREDIT");
            var windowUrl = 'about:blank';
            var uniqueName = new Date();
            var windowName = 'Print' + uniqueName.getTime();

            var printWindow = window.open(windowUrl, windowName, 'left=50000,top=50000,width=800,height=600');
            printWindow.document.body.innerHTML = printContent.innerHTML;
            printWindow.document.close();
            printWindow.focus();
            printWindow.print();
            printWindow.close();

            param.style.display = '';
            document.getElementById('ctl00_ContentPlaceHolder1_mainPanel_btnpdf').style.display = '';
        }

        function call_kredit(param) {
            var fasilitasid = $(param).attr('commandargument')
            callbackpopup(PopupSID, PNL_KREDIT, "r:" + fasilitasid);
        }

        function call_histori(param) {
            debugger;
            var fasilitasid = $(param).attr('commandargument')
            callbackpopup(PopupHistory, PNL_HISTORY, "r:" + fasilitasid);
        }
    </script>
</head>
<body class="text-sm">
    <form id="form1" runat="server">
        <a id="idepfile" href='<%= ResolveUrl("~/SLIK/SLIKResult.aspx?passurl&mntitle=SLIK%20Checking%20Result&regno=") + Request.QueryString["regno"]%>'>IDeb File</a>
        |
            <label>Credit Summary</label>
        | <a id="collateral" href='<%= ResolveUrl("~/SLIK/Collateral.aspx?passurl&mntitle=SLIK%20Checking%20Result&regno=") + Request.QueryString["regno"]%>'>Collateral</a>
        <div>
            <dx:ASPxCallbackPanel ID="mainPanel" runat="server" Width="100%"
                OnCallback="mainPanel_Callback" ClientInstanceName="mainPanel">
                <PanelCollection>
                    <dx:PanelContent ID="PanelContent1" runat="server">
                        <div class="card p-2">
                            <table id="Content" class="" width="100%" align="center">
                                <tr>
                                    <td>
                                        <h6>Data Debitur</h6>
                                        <hr />
                                        <table id="DataDebitur" width="100%">
                                            <tr valign="top">
                                                <td width="50%">
                                                    <table class="table table-sm  table-borderless table-responsive" width="100%">
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
                                                    <table class="table table-sm  table-borderless table-responsive" width="100%">
                                                        <tr id="Tr1" runat="server">
                                                            <td>KTP / NIK</td>
                                                            <td>:</td>
                                                            <td>
                                                                <asp:Label ID="ktp" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr style="display: none">
                                                            <td>Policy Result</td>
                                                            <td>:</td>
                                                            <td>
                                                                <asp:Label ForeColor="Red" Font-Bold="true" ID="final_policy" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr runat="server" style="display: none">
                                                            <td>&nbsp;</td>
                                                            <td>:</td>
                                                            <td>
                                                                <input runat="server" id="Button1" type="button" class="btn btn-sm btn-success" style="display: none" onclick="callback(mainPanel, 'r:');" value="Recalculate Policy" />
                                                                <input id="productid" runat="server" type="hidden" /></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" style="display: none" colspan="2">
                                                    <button type="button" id="btnprint" runat="server" class="btn btn-primary btn-sm"
                                                        onclick="callback(pdfPanel, 'p:')">
                                                        <span class="fa fa-print"></span>&nbsp;Print
                                                    </button>
                                                    <button type="button" id="btnpdf" class="btn btn-primary btn-sm" runat="server" onclick="callback(pdfPanel, 's:')">
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

                                        <h6>History Kredit</h6>
                                        <hr />
                                        <table id="DataKredit" width="100%">
                                            <tr>
                                                <td>

                                                    <dx:ASPxGridViewExporter ID="ASPxGridViewExporter1" runat="server"
                                                        GridViewID="GridViewKREDIT">
                                                    </dx:ASPxGridViewExporter>
                                                    <dx:ASPxGridView ID="GridViewKREDIT" runat="server" Width="100%" AutoGenerateColumns="False"
                                                        Theme="MaterialCompact" ClientInstanceName="GridViewKREDIT" KeyFieldName="fasilitasid" Font-Size="X-Small"
                                                        OnLoad="GridViewKREDIT_Load">
                                                        <Columns>
                                                            <dx:GridViewDataTextColumn Caption="ID Fasilitas" FieldName="fasilitasid"></dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="NIK" FieldName="nik"></dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Nama" FieldName="customerName"></dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Flag Fasilitas" FieldName="customerType"></dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Jenis Kredit Pembiayaan" FieldName="jenisKreditPembiayaanKet"></dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Tanggal Mulai" FieldName="tanggalMulai">
                                                                <PropertiesTextEdit DisplayFormatString="dd/MM/yyyy"></PropertiesTextEdit>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Tanggal Jatuh Tempo" FieldName="tanggalJatuhTempo">
                                                                <PropertiesTextEdit DisplayFormatString="dd/MM/yyyy"></PropertiesTextEdit>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Plafon" FieldName="plafon">
                                                                <PropertiesTextEdit DisplayFormatString="{0:###,##0.##}"></PropertiesTextEdit>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Outstanding" FieldName="outstandingPrincipal">
                                                                <PropertiesTextEdit DisplayFormatString="{0:###,##0.##}"></PropertiesTextEdit>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Suku Bunga (%)" FieldName="sukuBungaImbalan">
                                                                <PropertiesTextEdit DisplayFormatString="{0:###,##0.##}"></PropertiesTextEdit>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Kualitas Terakhir" FieldName="kualitasTerakhir"></dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="OVD" FieldName="jumlahHariTunggakan"></dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Kondisi" FieldName="kondisiKet"></dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Width="1%" CellStyle-Wrap="False">
                                                                <DataItemTemplate>
                                                                    <input id="Button1" runat="server" type="button" value="Detail" commandargument="<%# Container.KeyValue %>" onclick="call_kredit(this)" />
                                                                    <input id="Button6" runat="server" type="button" value="History" commandargument="<%# Container.KeyValue %>" onclick="call_histori(this)" />
                                                                </DataItemTemplate>
                                                            </dx:GridViewDataTextColumn>
                                                        </Columns>
                                                        <SettingsPager PageSize="20" />
                                                        <Settings ShowFilterRow="false" ShowGroupPanel="false" ShowGroupedColumns="true" ShowFooter="true" ShowPreview="true" />
                                                        <SettingsBehavior AllowGroup="true" />
                                                        <TotalSummary>
                                                            <dx:ASPxSummaryItem FieldName="ljkName" SummaryType="Count" />
                                                            <dx:ASPxSummaryItem FieldName="plafon" SummaryType="Sum" DisplayFormat="{0:###,##0.##}" />
                                                            <dx:ASPxSummaryItem FieldName="outstandingPrincipal" SummaryType="Sum" DisplayFormat="{0:###,##0.##}" />
                                                        </TotalSummary>
                                                    </dx:ASPxGridView>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxCallbackPanel>

            <dx:ASPxPopupControl ID="PopupSID" ClientInstanceName="PopupSID"
                runat="server" HeaderText="Detail" Width="800px"
                PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="TopSides"
                CloseAction="CloseButton" Modal="True" AllowDragging="True"
                EnableAnimation="False">
                <ContentCollection>
                    <dx:PopupControlContentControl ID="PopupControlContentControl3" runat="server">
                        <dx:ASPxCallbackPanel ID="PNL_KREDIT" runat="server" ClientInstanceName="PNL_KREDIT"
                            OnCallback="PNL_KREDIT_Callback">
                            <PanelCollection>
                                <dx:PanelContent ID="PanelContent8" runat="server">

                                    <div class="row">
                                        <div class="col-sm-12">

                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <table class="table table-sm table-responsive">
                                                        <tr>
                                                            <td>Pelapor</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "ljkName") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Cabang</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "cabangKet") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>No Rekening</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "noRekening") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Sifat Kredit</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "sifatKreditPembiayaanKet") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Jenis Kredit</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "jenisKreditPembiayaanKet") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Akad Kredit</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "akadKreditPembiayaanKet") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Baru/Perpanjangan</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "akadKreditPembiayaanKet") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>No Akad Awal</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "noAkadAwal") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Tanggal Akad Awal</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "tanggalAkadAwal") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>No Akad Akhir</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "noAkadAkhir") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Tanggal Akad Akhir</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "tanggalAkadAkhir") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Tanggal Awal Kredit</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "tanggalAwalKredit") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Tanggal Mulai</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "tanggalMulai") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Tanggal Jatuh Tempo</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "tanggalJatuhTempo") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Kategori Debitur</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "kategoriDebiturKet") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Jenis Penggunaan</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "jenisPenggunaanKet") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Sektor Ekonomi</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "sektorEkonomiKet") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Kredit Program Pemerintah</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "kreditProgramPemerintahKet") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Kab/Kota Lokasi Proyek</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "lokasiProyekKet") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Valuta</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "valutaKode") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Suku Bunga/Margin</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "sukuBungaImbalan") %> %</td>
                                                        </tr>
                                                        <tr>
                                                            <td>Keterangan</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "keterangan") %></td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div class="col-sm-6">
                                                    <table class="table table-sm table-responsive">
                                                        <tr>
                                                            <td>Tanggal Update</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "tanggalUpdate") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Kolektibilitas</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "kualitasTerakhir") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Jumlah Hari Tunggakan</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "jumlahHariTunggakan") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Nilai Proyek</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "nilaiProyek") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Plafon Awal</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "plafonAwal") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Plafon</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "plafon") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Baki Debet</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "outstandingPrincipal") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Realisasi/Pencairan Bulan Berjalan</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "realisasiBulanBerjalan") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Nilai dalam Mata Uang Asal</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "nilaiDalamMataUangAsal") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Sebab Macet</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "sebabMacetKet") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Tanggal Macet</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "tanggalMacet") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Tunggakan Pokok</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "tunggakanPokok") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Tunggakan Bunga</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "tunggakanBunga") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Frekuensi Tunggakan</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "frekuensiTunggakan") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Denda</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "denda") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Frekuensi Restrukturisasi</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "frekuensiRestrukturisasi") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Tanggal Restrukturisasi Akhir</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "tanggalRestrukturisasiAkhir") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Cara Restrukturisasi</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "restrukturisasiKet") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Kondisi</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "kondisiKet") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Tanggal Kondisi</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "tanggalKondisi") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Jenis Suku Bunga Kredit</td>
                                                            <td>:</td>
                                                            <td><%=DS(0, "jenisSukuBungaImbalanKet") %></td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <input id="Button2" runat="server" type="button" value="Close" class="btn btn-sm btn-primary" onclick="PopupSID.Hide();" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </dx:PanelContent>
                            </PanelCollection>
                        </dx:ASPxCallbackPanel>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>

            <dx:ASPxPopupControl ID="PopupHistory" ClientInstanceName="PopupHistory"
                runat="server" HeaderText="History" Width="800px"
                PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter"
                CloseAction="CloseButton" Modal="True" AllowDragging="True"
                EnableAnimation="False">
                <ContentCollection>
                    <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                        <dx:ASPxCallbackPanel ID="PNL_HISTORY" runat="server" ClientInstanceName="PNL_HISTORY"
                            OnCallback="PNL_HISTORY_Callback">
                            <PanelCollection>
                                <dx:PanelContent ID="PanelContent3" runat="server">
                                    <table width="100%" class="table table-sm table-responsive">
                                        <tr>
                                            <td align="center" colspan="3" width="15%"><%=DS(0, "tahunBulan12Ket") %></td>
                                            <td align="center" colspan="3" width="15%"><%=DS(0, "tahunBulan11Ket") %></td>
                                            <td align="center" colspan="3" width="15%"><%=DS(0, "tahunBulan10Ket") %></td>
                                            <td align="center" colspan="3" width="15%"><%=DS(0, "tahunBulan09Ket") %></td>
                                            <td align="center" colspan="3" width="15%"><%=DS(0, "tahunBulan08Ket") %></td>
                                            <td align="center" colspan="2" width="15%"><%=DS(0, "tahunBulan07Ket") %></td>
                                        </tr>
                                        <tr>
                                            <td align="center" width="6%" style="border: solid 1px black;" bgcolor="<%=DS(0, "tahunBulan12Color") %>"><%=DS(0, "tahunBulan12Kol") %>&nbsp;</td>
                                            <td align="center" width="7%" style="border: solid 1px black;" bgcolor="<%=DS(0, "tahunBulan12Color") %>"><%=DS(0, "tahunBulan12Ht") %>&nbsp;</td>
                                            <td align="center" width="1%">&nbsp;</td>
                                            <td align="center" width="6%" style="border: solid 1px black;" bgcolor="<%=DS(0, "tahunBulan11Color") %>"><%=DS(0, "tahunBulan11Kol") %>&nbsp;</td>
                                            <td align="center" width="7%" style="border: solid 1px black;" bgcolor="<%=DS(0, "tahunBulan11Color") %>"><%=DS(0, "tahunBulan11Ht") %>&nbsp;</td>
                                            <td align="center" width="1%">&nbsp;</td>
                                            <td align="center" width="6%" style="border: solid 1px black;" bgcolor="<%=DS(0, "tahunBulan10Color") %>"><%=DS(0, "tahunBulan10Kol") %>&nbsp;</td>
                                            <td align="center" width="7%" style="border: solid 1px black;" bgcolor="<%=DS(0, "tahunBulan10Color") %>"><%=DS(0, "tahunBulan10Ht") %>&nbsp;</td>
                                            <td align="center" width="1%">&nbsp;</td>
                                            <td align="center" width="6%" style="border: solid 1px black;" bgcolor="<%=DS(0, "tahunBulan09Color") %>"><%=DS(0, "tahunBulan09Kol") %>&nbsp;</td>
                                            <td align="center" width="7%" style="border: solid 1px black;" bgcolor="<%=DS(0, "tahunBulan09Color") %>"><%=DS(0, "tahunBulan09Ht") %>&nbsp;</td>
                                            <td align="center" width="1%">&nbsp;</td>
                                            <td align="center" width="6%" style="border: solid 1px black;" bgcolor="<%=DS(0, "tahunBulan08Color") %>"><%=DS(0, "tahunBulan08Kol") %>&nbsp;</td>
                                            <td align="center" width="7%" style="border: solid 1px black;" bgcolor="<%=DS(0, "tahunBulan08Color") %>"><%=DS(0, "tahunBulan08Ht") %>&nbsp;</td>
                                            <td align="center" width="1%">&nbsp;</td>
                                            <td align="center" width="6%" style="border: solid 1px black;" bgcolor="<%=DS(0, "tahunBulan07Color") %>"><%=DS(0, "tahunBulan07Kol") %>&nbsp;</td>
                                            <td align="center" width="7%" style="border: solid 1px black;" bgcolor="<%=DS(0, "tahunBulan07Color") %>"><%=DS(0, "tahunBulan07Ht") %>&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td align="center" colspan="3" width="15%"><%=DS(0, "tahunBulan06Ket") %></td>
                                            <td align="center" colspan="3" width="15%"><%=DS(0, "tahunBulan05Ket") %></td>
                                            <td align="center" colspan="3" width="15%"><%=DS(0, "tahunBulan04Ket") %></td>
                                            <td align="center" colspan="3" width="15%"><%=DS(0, "tahunBulan03Ket") %></td>
                                            <td align="center" colspan="3" width="15%"><%=DS(0, "tahunBulan02Ket") %></td>
                                            <td align="center" colspan="2" width="15%"><%=DS(0, "tahunBulan01Ket") %></td>
                                        </tr>
                                        <tr>
                                            <td align="center" width="6%" style="border: solid 1px black;" bgcolor="<%=DS(0, "tahunBulan06Color") %>"><%=DS(0, "tahunBulan06Kol") %>&nbsp;</td>
                                            <td align="center" width="7%" style="border: solid 1px black;" bgcolor="<%=DS(0, "tahunBulan06Color") %>"><%=DS(0, "tahunBulan06Ht") %>&nbsp;</td>
                                            <td align="center" width="1%">&nbsp;</td>
                                            <td align="center" width="6%" style="border: solid 1px black;" bgcolor="<%=DS(0, "tahunBulan05Color") %>"><%=DS(0, "tahunBulan05Kol") %>&nbsp;</td>
                                            <td align="center" width="7%" style="border: solid 1px black;" bgcolor="<%=DS(0, "tahunBulan05Color") %>"><%=DS(0, "tahunBulan05Ht") %>&nbsp;</td>
                                            <td align="center" width="1%">&nbsp;</td>
                                            <td align="center" width="6%" style="border: solid 1px black;" bgcolor="<%=DS(0, "tahunBulan04Color") %>"><%=DS(0, "tahunBulan04Kol") %>&nbsp;</td>
                                            <td align="center" width="7%" style="border: solid 1px black;" bgcolor="<%=DS(0, "tahunBulan04Color") %>"><%=DS(0, "tahunBulan04Ht") %>&nbsp;</td>
                                            <td align="center" width="1%">&nbsp;</td>
                                            <td align="center" width="6%" style="border: solid 1px black;" bgcolor="<%=DS(0, "tahunBulan03Color") %>"><%=DS(0, "tahunBulan03Kol") %>&nbsp;</td>
                                            <td align="center" width="7%" style="border: solid 1px black;" bgcolor="<%=DS(0, "tahunBulan03Color") %>"><%=DS(0, "tahunBulan03Ht") %>&nbsp;</td>
                                            <td align="center" width="1%">&nbsp;</td>
                                            <td align="center" width="6%" style="border: solid 1px black;" bgcolor="<%=DS(0, "tahunBulan02Color") %>"><%=DS(0, "tahunBulan02Kol") %>&nbsp;</td>
                                            <td align="center" width="7%" style="border: solid 1px black;" bgcolor="<%=DS(0, "tahunBulan02Color") %>"><%=DS(0, "tahunBulan02Ht") %>&nbsp;</td>
                                            <td align="center" width="1%">&nbsp;</td>
                                            <td align="center" width="6%" style="border: solid 1px black;" bgcolor="<%=DS(0, "tahunBulan01Color") %>"><%=DS(0, "tahunBulan01Kol") %>&nbsp;</td>
                                            <td align="center" width="7%" style="border: solid 1px black;" bgcolor="<%=DS(0, "tahunBulan01Color") %>"><%=DS(0, "tahunBulan01Ht") %>&nbsp;</td>
                                        </tr>
                                        <tr class="F1">
                                            <td align="center" colspan="17">&nbsp;</td>
                                        </tr>
                                        <tr class="F1">
                                            <td align="center" colspan="17">
                                                <input id="Button3" runat="server" type="button" value="Close" class="Bt1" onclick="PopupHistory.Hide();" />
                                            </td>
                                        </tr>
                                    </table>
                                </dx:PanelContent>
                            </PanelCollection>
                        </dx:ASPxCallbackPanel>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>
        </div>
    </form>
</body>
</html>