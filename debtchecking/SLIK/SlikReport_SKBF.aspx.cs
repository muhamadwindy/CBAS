using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using DMS.Tools;
using MWSFramework;
using System.Collections.Specialized;
using DevExpress.Web;
using System.Data;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.Script.Serialization;
using Newtonsoft.Json;
using DevExpress.Utils.About;
using evointernal;
using DebtChecking.CommonForm;
using System.Text;
using NReco.PdfGenerator;
using DevExpress.XtraPrinting.Export.Web;
using System.Net;

namespace DebtChecking.SLIK
{
    public partial class SlikReport_SKBF : DataPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string reffNumber = Request.QueryString["reffnumber"];
                retrieve_data();
            }
        }

        private void retrieve_data()
        {
            string reffNumber = Request.QueryString["reffnumber"];
            string query = "exec dbo.UspReportSKBF @1";
            object[] par = new object[] { reffNumber };
            DataSet ds = conn.GetDataSet(query, par, dbtimeout);
            DataTable dtHead = ds.Tables[0];
            DataTable dtPosition = ds.Tables[1];
            DataTable dtDetail = ds.Tables[2];

            if(dtHead.AsEnumerable()
                .Where(x => x.Field<string>("status_app") == "A").Count() > 0)
            {
                DataTable dtCust = dtHead.AsEnumerable()
               .Where(x => x.Field<string>("status_app") == "A").CopyToDataTable();

                string custName = GetFieldValueDatatable(dtCust, "cust_name", 0);
                string totalFasilitas = GetFieldValueDatatable(dtCust, "Total", 0);
                string totalAktif = GetFieldValueDatatable(dtCust, "Active", 0);
                string plafon = GetFieldValueDatatable(dtCust, "Plafon", 0);
                string bakiDebet = GetFieldValueDatatable(dtCust, "BakiDebet", 0);
                string finalPolicy = GetFieldValueDatatable(dtCust, "FinalPolicy", 0);
                lblCustName.InnerHtml = custName;
                lblTotalFasilitasAktif.InnerHtml = totalFasilitas + " / " + totalAktif;
                lblPlafonBakiDebet.InnerHtml = "Rp " + plafon + " / Rp " + bakiDebet;
                final_policy.Text = finalPolicy;
                string kontrakLunas = GetKontrakLunas(dtDetail, "a").ToString();
                divKontrakLunas.InnerHtml = kontrakLunas;
                string kontrakAktif = GetKontrakAktif(dtDetail, "a").ToString();
                divKontrakAktif.InnerHtml = kontrakAktif;
                string kontrakWO = GetKontrakWO(dtDetail, "a").ToString();
                divKontrakWO.InnerHtml = kontrakWO;
            }

            int totalPosition = dtPosition.Rows.Count;
            StringBuilder sbReport = new StringBuilder();
            for(int i = 0; i < totalPosition; i++)
            {
                string statusApp = GetFieldValueDatatable(dtPosition, "status_app", i);
                string statusDesc = GetFieldValueDatatable(dtPosition, "status_desc", i);
                sbReport.Append("<br />");
                sbReport.Append(GenerateReportTambahan(statusApp, statusDesc, dtHead, dtDetail));
            }
            divLoopReport.InnerHtml = sbReport.ToString();
           
        }

        private StringBuilder GenerateReportTambahan(string statusApp, string statusDesc, DataTable dtHead, DataTable dtDetail)
        {
            StringBuilder sb = new StringBuilder();
            if(dtHead.AsEnumerable()
                .Where(x=>x.Field<string>("status_app").ToLower() == statusApp.ToLower()).Count() > 0)
            {
                DataTable dtHeadProcess = dtHead.AsEnumerable()
                .Where(x => x.Field<string>("status_app").ToLower() == statusApp.ToLower()).CopyToDataTable();
                string custName = GetFieldValueDatatable(dtHeadProcess, "cust_name", 0);
                string totalFasilitas = GetFieldValueDatatable(dtHeadProcess, "Total", 0);
                string totalAktif = GetFieldValueDatatable(dtHeadProcess, "Active", 0);
                string plafon = GetFieldValueDatatable(dtHeadProcess, "Plafon", 0);
                string bakiDebet = GetFieldValueDatatable(dtHeadProcess, "BakiDebet", 0);

                sb.Append(" <div class=\"card card-primary card-outline\"> \n");
                sb.Append(" <div class=\"card-header\">\r\n " +
                    "<h4 class=\"card-title\" runat=\"server\">Report SLIK Result - " + statusDesc + "</h4>\r\n </div>");
                sb.Append(" <div class=\"card-body\">");
                sb.Append(" <div> \n");
                sb.Append("<div class=\"row\">\r\n                       " +
                    " <div class=\"col-sm-10\">\r\n                           " +
                    " <div class=\"form-group row\">\r\n                                " +
                    "<div class=\"col-sm-4\">Customer Name</div>\r\n                                " +
                    "<div class=\"col-sm-1\">:</div>\r\n                                " +
                    "<div class=\"col-sm-7\"><b><label>"+custName+"</label></b></div>\r\n  " +
                    "</div>\r\n                 " +
                    "<div class=\"form-group row\">\r\n                                " +
                    "<div class=\"col-sm-4\">Total Fasilitas / Aktif</div>\r\n                                " +
                    "<div class=\"col-sm-1\">:</div>\r\n                                " +
                    "<div class=\"col-sm-7\"><b><label>"+ totalFasilitas + " / " + totalAktif+"</label></b></div>\r\n                           " +
                    " </div>\r\n                             " +
                    "<div class=\"form-group row\">\r\n                               " +
                    " <div class=\"col-sm-4\">Plafon Efektif / Baki Debet</div>\r\n                                " +
                    "<div class=\"col-sm-1\">:</div>\r\n                                " +
                    "<div class=\"col-sm-7\"><b><label>Rp "+ plafon+" / Rp "+ bakiDebet +"</label></b></div>\r\n                            " +
                    "</div>\r\n                        " +
                    "</div>\r\n                    " +
                    "</div>");

                // kontrak lunas
                sb.Append(GetKontrakLunas(dtDetail, statusApp));

                // kontrak aktif
                sb.Append(GetKontrakAktif(dtDetail, statusApp));

                // kontrak WO
                sb.Append(GetKontrakWO(dtDetail, statusApp));

                sb.Append("</div> \n"); // div 
                sb.Append("</div> \n"); // div card body
                sb.Append("</div> \n"); // div primary
            }

            
            return sb;
        }

        private StringBuilder GenerateReportTambahanTxt(string statusApp, string statusDesc, DataTable dtHead, DataTable dtDetail)
        {
            StringBuilder sb = new StringBuilder();
            if (dtHead.AsEnumerable()
                .Where(x => x.Field<string>("status_app").ToLower() == statusApp.ToLower()).Count() > 0)
            {
                DataTable dtHeadProcess = dtHead.AsEnumerable()
                .Where(x => x.Field<string>("status_app").ToLower() == statusApp.ToLower()).CopyToDataTable();
                string custName = GetFieldValueDatatable(dtHeadProcess, "cust_name", 0);
                string totalFasilitas = GetFieldValueDatatable(dtHeadProcess, "Total", 0);
                string totalAktif = GetFieldValueDatatable(dtHeadProcess, "Active", 0);
                string plafon = GetFieldValueDatatable(dtHeadProcess, "Plafon", 0);
                string bakiDebet = GetFieldValueDatatable(dtHeadProcess, "BakiDebet", 0);

                sb.Append("Report SLIK Result - " + statusDesc + " \r\n");
                sb.Append("Customer Name : " + custName + " \r\n");
                sb.Append("Total Fasilitas / Aktif : " + totalFasilitas + " / " + totalAktif + " \r\n");
                sb.Append("Plafon Efektif / Baki Debet : Rp " + plafon + " / Rp " + bakiDebet + " \r\n");

                // kontrak lunas
                sb.Append(GetKontrakLunasTxt(dtDetail, statusApp));

                // kontrak aktif
                sb.Append(GetKontrakAktifTxt(dtDetail, statusApp));

                // kontrak WO
                sb.Append(GetKontrakWOTxt(dtDetail, statusApp));

                sb.Append("\r\r\n");
            }


            return sb;
        }

        private StringBuilder GetKontrakLunas(DataTable dt, string statusApp)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append(" \n <hr /> \n  <b>Kontrak Lunas :</b>  <hr /> \n");
            if (dt.AsEnumerable()
                .Where(x => x.Field<string>("status_app").ToLower() == statusApp.ToLower()
                && x.Field<string>("Kontrakinfo").ToLower() == "lunas").Count() > 0)
            {
                DataTable dtDetail = dt.AsEnumerable()
                .Where(x => x.Field<string>("status_app").ToLower() == statusApp.ToLower() && x.Field<string>("Kontrakinfo").ToLower() == "lunas")
                .CopyToDataTable();
                int total = dtDetail.Rows.Count;
                for (int i = 0; i < total; i++)
                {
                    string pelapor = GetFieldValueDatatable(dtDetail, "ljkKet", i);
                    string tglAwalAkad = GetFieldValueDatatable(dtDetail, "tanggalAkadAwal", i);
                    string tglJatuhTempo = GetFieldValueDatatable(dtDetail, "tanggalJatuhTempo", i);
                    string jenisKredit = GetFieldValueDatatable(dtDetail, "JenisKredit", i);
                    string plafon = GetFieldValueDatatable(dtDetail, "plafon", i);
                    string baki = GetFieldValueDatatable(dtDetail, "bakiDebet", i);
                    string worst = GetFieldValueDatatable(dtDetail, "WorstCollDay", i);
                    string lastRepeatedOvd = GetFieldValueDatatable(dtDetail, "LastRepeatedOvd", i);
                    string tglKondisi = GetFieldValueDatatable(dtDetail, "tanggalKondisi", i);
                    string frekuensiRestru = GetFieldValueDatatable(dtDetail, "frekuensiRestru", i);
                    string angsuran = GetFieldValueDatatable(dtDetail, "Angsuran", i);

                    sb.Append("<div class=\"col-sm-12\"><b>" + (i + 1) + ". </b> ");
                    sb.Append(pelapor + " | " + tglAwalAkad + " - " + tglJatuhTempo + " | " + jenisKredit + " | Plafon Rp " + plafon + " | Baki Rp " + baki
                        + " | " + worst + " | " + lastRepeatedOvd + " | Lunas " + tglKondisi + " | " + frekuensiRestru);
                    sb.Append("</div>");
                }
            }
            
            sb.Append("<br />");
            return sb;
        }

        private StringBuilder GetKontrakLunasTxt(DataTable dt, string statusApp)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("Kontrak Lunas : \n");
            if (dt.AsEnumerable()
                .Where(x => x.Field<string>("status_app").ToLower() == statusApp.ToLower()
                && x.Field<string>("Kontrakinfo").ToLower() == "lunas").Count() > 0)
            {
                DataTable dtDetail = dt.AsEnumerable()
                .Where(x => x.Field<string>("status_app").ToLower() == statusApp.ToLower() && x.Field<string>("Kontrakinfo").ToLower() == "lunas")
                .CopyToDataTable();
                int total = dtDetail.Rows.Count;
                for (int i = 0; i < total; i++)
                {
                    string pelapor = GetFieldValueDatatable(dtDetail, "ljkKet", i);
                    string tglAwalAkad = GetFieldValueDatatable(dtDetail, "tanggalAkadAwal", i);
                    string tglJatuhTempo = GetFieldValueDatatable(dtDetail, "tanggalJatuhTempo", i);
                    string jenisKredit = GetFieldValueDatatable(dtDetail, "JenisKredit", i);
                    string plafon = GetFieldValueDatatable(dtDetail, "plafon", i);
                    string baki = GetFieldValueDatatable(dtDetail, "bakiDebet", i);
                    string worst = GetFieldValueDatatable(dtDetail, "WorstCollDay", i);
                    string lastRepeatedOvd = GetFieldValueDatatable(dtDetail, "LastRepeatedOvd", i);
                    string tglKondisi = GetFieldValueDatatable(dtDetail, "tanggalKondisi", i);
                    string frekuensiRestru = GetFieldValueDatatable(dtDetail, "frekuensiRestru", i);
                    string angsuran = GetFieldValueDatatable(dtDetail, "Angsuran", i);

                    sb.Append((i + 1) + ". ");
                    sb.Append(pelapor + " | " + tglAwalAkad + " - " + tglJatuhTempo + " | " + jenisKredit + " | Plafon Rp " + plafon + " | Baki Rp " + baki
                        + " | " + worst + " | " + lastRepeatedOvd + " | Lunas " + tglKondisi + " | " + frekuensiRestru);
                    sb.Append("\r\n");
                }
            }
            return sb;
        }

        private StringBuilder GetKontrakAktif(DataTable dt, string statusApp)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append(" \n <hr /> \n  <b>Kontrak Fasiltas Aktif :</b> <hr /> \n");
            if (dt.AsEnumerable()
                .Where(x => x.Field<string>("status_app").ToLower() == statusApp.ToLower() 
                && x.Field<string>("KontrakInfo").ToLower() == "aktif").Count() > 0)
            {
                DataTable dtDetail = dt.AsEnumerable()
                .Where(x => x.Field<string>("status_app").ToLower() == statusApp.ToLower() && x.Field<string>("KontrakInfo").ToLower() == "aktif")
                .CopyToDataTable();
                int total = dtDetail.Rows.Count;
                for (int i = 0; i < total; i++)
                {
                    string pelapor = GetFieldValueDatatable(dtDetail, "ljkKet", i);
                    string tglAwalAkad = GetFieldValueDatatable(dtDetail, "tanggalAkadAwal", i);
                    string tglJatuhTempo = GetFieldValueDatatable(dtDetail, "tanggalJatuhTempo", i);
                    string jenisKredit = GetFieldValueDatatable(dtDetail, "JenisKredit", i);
                    string plafon = GetFieldValueDatatable(dtDetail, "plafon", i);
                    string baki = GetFieldValueDatatable(dtDetail, "bakiDebet", i);
                    string worst = GetFieldValueDatatable(dtDetail, "WorstCollDay", i);
                    string lastRepeatedOvd = GetFieldValueDatatable(dtDetail, "LastRepeatedOvd", i);
                    string aktif = GetFieldValueDatatable(dtDetail, "aktif", i);
                    string tglKondisi = GetFieldValueDatatable(dtDetail, "tanggalKondisi", i);
                    string frekuensiRestru = GetFieldValueDatatable(dtDetail, "frekuensiRestru", i);
                    string tunggakan = GetFieldValueDatatable(dtDetail, "Tunggakan", i);

                    sb.Append("<div class=\"col-sm-12\"><b>" + (i + 1) + ". </b> ");
                    sb.Append(pelapor + " | " + tglAwalAkad + " - " + tglJatuhTempo + " | " + jenisKredit + " | Plafon Rp " + plafon + " | Baki Rp " + baki
                        + " | " + worst + " | " + lastRepeatedOvd + " | " + aktif + " | Tunggakan " + tunggakan + " | " + frekuensiRestru);
                    sb.Append("</div>");
                }
            }                
            sb.Append("<br />");
            return sb;
        }

        private StringBuilder GetKontrakAktifTxt(DataTable dt, string statusApp)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("Kontrak Fasiltas Aktif : \r\n");
            if (dt.AsEnumerable()
                .Where(x => x.Field<string>("status_app").ToLower() == statusApp.ToLower()
                && x.Field<string>("KontrakInfo").ToLower() == "aktif").Count() > 0)
            {
                DataTable dtDetail = dt.AsEnumerable()
                .Where(x => x.Field<string>("status_app").ToLower() == statusApp.ToLower() && x.Field<string>("KontrakInfo").ToLower() == "aktif")
                .CopyToDataTable();
                int total = dtDetail.Rows.Count;
                for (int i = 0; i < total; i++)
                {
                    string pelapor = GetFieldValueDatatable(dtDetail, "ljkKet", i);
                    string tglAwalAkad = GetFieldValueDatatable(dtDetail, "tanggalAkadAwal", i);
                    string tglJatuhTempo = GetFieldValueDatatable(dtDetail, "tanggalJatuhTempo", i);
                    string jenisKredit = GetFieldValueDatatable(dtDetail, "JenisKredit", i);
                    string plafon = GetFieldValueDatatable(dtDetail, "plafon", i);
                    string baki = GetFieldValueDatatable(dtDetail, "bakiDebet", i);
                    string worst = GetFieldValueDatatable(dtDetail, "WorstCollDay", i);
                    string lastRepeatedOvd = GetFieldValueDatatable(dtDetail, "LastRepeatedOvd", i);
                    string aktif = GetFieldValueDatatable(dtDetail, "aktif", i);
                    string tglKondisi = GetFieldValueDatatable(dtDetail, "tanggalKondisi", i);
                    string frekuensiRestru = GetFieldValueDatatable(dtDetail, "frekuensiRestru", i);
                    string tunggakan = GetFieldValueDatatable(dtDetail, "Tunggakan", i);

                    sb.Append((i + 1) + ". ");
                    sb.Append(pelapor + " | " + tglAwalAkad + " - " + tglJatuhTempo + " | " + jenisKredit + " | Plafon Rp " + plafon + " | Baki Rp " + baki
                        + " | " + worst + " | " + lastRepeatedOvd + " | " + aktif + " | Tunggakan " + tunggakan + " | " + frekuensiRestru);
                    sb.Append("\r\n");
                }
            }
            return sb;
        }

        private StringBuilder GetKontrakWO(DataTable dt, string statusApp)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append(" \n <hr /> \n  <b>Kontrak Fasiltas HAPUS BUKU / HAPUS TAGIH :</b> <hr /> \n");
            if(dt.AsEnumerable()
               .Where(x => x.Field<string>("status_app").ToLower() == statusApp.ToLower()
               && x.Field<string>("KontrakInfo").ToLower() == "wo").Count() > 0)
            {
                DataTable dtDetail = dt.AsEnumerable()
               .Where(x => x.Field<string>("status_app").ToLower() == statusApp.ToLower() && x.Field<string>("KontrakInfo").ToLower() == "wo")
               .CopyToDataTable();
                int total = dtDetail.Rows.Count;
                for (int i = 0; i < total; i++)
                {
                    string pelapor = GetFieldValueDatatable(dtDetail, "ljkKet", i);
                    string tglAwalAkad = GetFieldValueDatatable(dtDetail, "tanggalAkadAwal", i);
                    string tglJatuhTempo = GetFieldValueDatatable(dtDetail, "tanggalJatuhTempo", i);
                    string jenisKredit = GetFieldValueDatatable(dtDetail, "JenisKredit", i);
                    string plafon = GetFieldValueDatatable(dtDetail, "plafon", i);
                    string baki = GetFieldValueDatatable(dtDetail, "bakiDebet", i);
                    string worst = GetFieldValueDatatable(dtDetail, "WorstCollDay", i);
                    string lastRepeatedOvd = GetFieldValueDatatable(dtDetail, "LastRepeatedOvd", i);
                    string aktif = GetFieldValueDatatable(dtDetail, "aktif", i);
                    string tglKondisi = GetFieldValueDatatable(dtDetail, "tanggalKondisi", i);
                    string frekuensiRestru = GetFieldValueDatatable(dtDetail, "frekuensiRestru", i);
                    string tunggakan = GetFieldValueDatatable(dtDetail, "Tunggakan", i);
                    string frekuensiTunggakan = GetFieldValueDatatable(dtDetail, "frekuensiTunggakan", i);

                    sb.Append("<div class=\"col-sm-12\"><b>" + (i + 1) + ". </b> ");
                    sb.Append(pelapor + " | " + tglAwalAkad + " - " + tglJatuhTempo + " | " + jenisKredit + " | Plafon Rp " + plafon + " | Baki Rp " + baki
                        + " | " + worst + " | " + lastRepeatedOvd + " | WO " + tglKondisi + " | Tunggakan " + tunggakan + " | "
                        + " | Freq Tunggak" + frekuensiTunggakan + " | " + frekuensiRestru);
                    sb.Append("</div>");
                }
            }
           
            sb.Append("<br />");
            return sb;
        }

        private StringBuilder GetKontrakWOTxt(DataTable dt, string statusApp)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("Kontrak Fasiltas HAPUS BUKU / HAPUS TAGIH : \r\n");
            if (dt.AsEnumerable()
               .Where(x => x.Field<string>("status_app").ToLower() == statusApp.ToLower()
               && x.Field<string>("KontrakInfo").ToLower() == "wo").Count() > 0)
            {
                DataTable dtDetail = dt.AsEnumerable()
               .Where(x => x.Field<string>("status_app").ToLower() == statusApp.ToLower() && x.Field<string>("KontrakInfo").ToLower() == "wo")
               .CopyToDataTable();
                int total = dtDetail.Rows.Count;
                for (int i = 0; i < total; i++)
                {
                    string pelapor = GetFieldValueDatatable(dtDetail, "ljkKet", i);
                    string tglAwalAkad = GetFieldValueDatatable(dtDetail, "tanggalAkadAwal", i);
                    string tglJatuhTempo = GetFieldValueDatatable(dtDetail, "tanggalJatuhTempo", i);
                    string jenisKredit = GetFieldValueDatatable(dtDetail, "JenisKredit", i);
                    string plafon = GetFieldValueDatatable(dtDetail, "plafon", i);
                    string baki = GetFieldValueDatatable(dtDetail, "bakiDebet", i);
                    string worst = GetFieldValueDatatable(dtDetail, "WorstCollDay", i);
                    string lastRepeatedOvd = GetFieldValueDatatable(dtDetail, "LastRepeatedOvd", i);
                    string aktif = GetFieldValueDatatable(dtDetail, "aktif", i);
                    string tglKondisi = GetFieldValueDatatable(dtDetail, "tanggalKondisi", i);
                    string frekuensiRestru = GetFieldValueDatatable(dtDetail, "frekuensiRestru", i);
                    string tunggakan = GetFieldValueDatatable(dtDetail, "Tunggakan", i);
                    string frekuensiTunggakan = GetFieldValueDatatable(dtDetail, "frekuensiTunggakan", i);

                    sb.Append((i + 1) + ". ");
                    sb.Append(pelapor + " | " + tglAwalAkad + " - " + tglJatuhTempo + " | " + jenisKredit + " | Plafon Rp " + plafon + " | Baki Rp " + baki
                        + " | " + worst + " | " + lastRepeatedOvd + " | WO " + tglKondisi + " | Tunggakan " + tunggakan + " | "
                        + " | Freq Tunggak" + frekuensiTunggakan + " | " + frekuensiRestru);
                    sb.Append("\r\n");
                }
            }
            return sb;
        }

        protected void BtnDownloadReport_Click(object sender, EventArgs e)
        {
            string exportType = ExportType.SelectedValue;
            if(exportType == "txt")
            {
                ExportToTextFile();
            }
            else if(exportType == "pdf")
            {
                ExportToPDF();

            }
        }

        private void ExportToPDF()
        {
            string paramSplit = "/SLIK/";
            string reffNumber = Request.QueryString["reffnumber"];
            string url = HttpContext.Current.Request.Url.ToString();
            string[] splitUrl = url.Split(new string[] { paramSplit }, StringSplitOptions.None);
            string url1 = splitUrl[0];
            string urlPdf = url1 + "" + paramSplit + "SLIKReport_SKBF_PDF.aspx?reffnumber="+reffNumber;
            // var htmlToPdf = new NReco.PdfGenerator.HtmlToPdfConverter();
            //htmlToPdf.GeneratePdfFromFile(urlPdf, null, "export.pdf");

            System.IO.StringWriter htmlStringWriter = new System.IO.StringWriter();
            Server.Execute("SLIKReport_SKBF_PDF.aspx?reffnumber="+reffNumber, htmlStringWriter);
            string htmlContent = htmlStringWriter.GetStringBuilder().ToString();

            //HttpWebRequest request = (HttpWebRequest)WebRequest.Create(urlPdf);
            //HttpWebResponse response = (HttpWebResponse)request.GetResponse();
            //String ver = response.ProtocolVersion.ToString();
            //StreamReader reader = new StreamReader(response.GetResponseStream());
            //string htmlContent = reader.ReadToEnd();

            var htmlToPdf = new NReco.PdfGenerator.HtmlToPdfConverter();
            var pdfBytes = htmlToPdf.GeneratePdf(htmlContent);

            Response.Clear();
            MemoryStream ms = new MemoryStream(pdfBytes);
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=Report.pdf");
            Response.Buffer = true;
            ms.WriteTo(Response.OutputStream);
            Response.End();
        }

        private void ExportToTextFile()
        {
            string custName = lblCustName.InnerHtml;
            string reffNumber = Request.QueryString["reffnumber"];
            string query = "exec dbo.UspReportSKBF @1";
            object[] par = new object[] { reffNumber };
            DataSet ds = conn.GetDataSet(query, par, dbtimeout);
            DataTable dtHead = ds.Tables[0];
            DataTable dtPosition = ds.Tables[1];
            DataTable dtDetail = ds.Tables[2];
            string dataExport = GenExportToTextFile(dtHead, dtPosition, dtDetail).ToString();
            Response.Clear();
            Response.ContentType = "application/text";
            Response.AddHeader("content-disposition", "attachment;filename=report_"+reffNumber+".txt");
            Response.Output.Write(dataExport);
            Response.Flush();
            Response.End();
        }

        private StringBuilder GenExportToTextFile(DataTable dtHead, DataTable dtPosition, DataTable dtDetail)
        {
            StringBuilder sb = new StringBuilder();
            
            if (dtHead.AsEnumerable()
               .Where(x => x.Field<string>("status_app") == "A").Count() > 0)
            {
                DataTable dtCust = dtHead.AsEnumerable()
               .Where(x => x.Field<string>("status_app") == "A").CopyToDataTable();

                string processDate = GetFieldValueDatatable(dtCust, "processDate", 0);
                string custName = GetFieldValueDatatable(dtCust, "cust_name", 0);
                string totalFasilitas = GetFieldValueDatatable(dtCust, "Total", 0);
                string totalAktif = GetFieldValueDatatable(dtCust, "Active", 0);
                string plafon = GetFieldValueDatatable(dtCust, "Plafon", 0);
                string bakiDebet = GetFieldValueDatatable(dtCust, "BakiDebet", 0);
                string policyResult = GetFieldValueDatatable(dtCust, "final_policy_desc", 0);

                sb.Append("Summary SLIK "+processDate+" \r\n");
                sb.Append("Report SLIK Result - Customer \r\n");
                sb.Append("Customer Name : " + custName + " \r\n");
                sb.Append("Total Fasilitas / Aktif : " + totalFasilitas + " / " + totalAktif + " \r\n");
                sb.Append("Plafon Efektif / Baki Debet : Rp " + plafon + " / Rp " + bakiDebet + " \r\n");
                sb.Append("Policy Result : " + policyResult + " \r\n");
                sb.Append("\r");
                sb.Append(GetKontrakLunasTxt(dtDetail, "a") + " \r\n");
                sb.Append(GetKontrakAktifTxt(dtDetail, "a") + " \r\n");
                sb.Append(GetKontrakWOTxt(dtDetail, "a") + " \r\n");
                sb.Append("\r\r\n\n");

                int totalPosition = dtPosition.Rows.Count;
                StringBuilder sbReport = new StringBuilder();
                for (int i = 0; i < totalPosition; i++)
                {
                    string statusApp = GetFieldValueDatatable(dtPosition, "status_app", i);
                    string statusDesc = GetFieldValueDatatable(dtPosition, "status_desc", i);
                    sbReport.Append(GenerateReportTambahanTxt(statusApp, statusDesc, dtHead, dtDetail));
                }
                sb.Append("\r\r");


            }

            return sb;
        }

        public static string GetDictionaryValueObject(Dictionary<string, object> param, string id)
        {
            return DebtChecking.CommonForm.CustomFunction.GetDictionaryValueObject(param, id);
        }

        public static string GetFieldValueDatatable(DataTable dt, int field, int row)
        {
            return DebtChecking.CommonForm.CustomFunction.GetFieldValueDatatable(dt, field, row);
        }

        public static string GetFieldValueDatatable(DataTable dt, string field, int row)
        {
            return DebtChecking.CommonForm.CustomFunction.GetFieldValueDatatable(dt, field, row);
        }

    }
}