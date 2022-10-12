using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DMS.Tools;
using MWSFramework;
using System.Data;
using System.Text;

namespace DebtChecking.SLIK
{
    public partial class SLIKReport_SKBF_PDF : DataPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GenerateData();
            }
        }

        private void GenerateData()
        {
            string reffNumber = Request.QueryString["reffnumber"];
            if (!string.IsNullOrEmpty(reffNumber))
            {
                string query = "exec dbo.UspReportSKBF @1";
                object[] par = new object[] { reffNumber };
                DataSet ds = conn.GetDataSet(query, par, dbtimeout);
                DataTable dtHead = ds.Tables[0];
                DataTable dtPosition = ds.Tables[1];
                DataTable dtDetail = ds.Tables[2];

                if (dtHead.AsEnumerable()
                    .Where(x => x.Field<string>("status_app") == "A").Count() > 0)
                {
                    DataTable dtCust = dtHead.AsEnumerable()
                   .Where(x => x.Field<string>("status_app") == "A").CopyToDataTable();

                    string custName = GetFieldValueDatatable(dtCust, "cust_name", 0);
                    string totalFasilitas = GetFieldValueDatatable(dtCust, "Total", 0);
                    string totalAktif = GetFieldValueDatatable(dtCust, "Active", 0);
                    string plafon = GetFieldValueDatatable(dtCust, "Plafon", 0);
                    string bakiDebet = GetFieldValueDatatable(dtCust, "BakiDebet", 0);
                    string policyResult = GetFieldValueDatatable(dtCust, "FinalPolicy", 0);
                    lblCustName.InnerHtml = custName;
                    lblTotalFasilitasAktif.InnerHtml = totalFasilitas + " / " + totalAktif;
                    lblPlafonBakiDebet.InnerHtml = "Rp " + plafon + " / Rp " + bakiDebet;
                    final_policy.Text = policyResult;
                    string kontrakLunas = GetKontrakLunas(dtDetail, "a").ToString();
                    divKontrakLunas.InnerHtml = kontrakLunas;
                    string kontrakAktif = GetKontrakAktif(dtDetail, "a").ToString();
                    divKontrakAktif.InnerHtml = kontrakAktif;
                    string kontrakWO = GetKontrakWO(dtDetail, "a").ToString();
                    divKontrakWO.InnerHtml = kontrakWO;
                }

                int totalPosition = dtPosition.Rows.Count;
                StringBuilder sbReport = new StringBuilder();
                for (int i = 0; i < totalPosition; i++)
                {
                    string statusApp = GetFieldValueDatatable(dtPosition, "status_app", i);
                    string statusDesc = GetFieldValueDatatable(dtPosition, "status_desc", i);
                    sbReport.Append("<br />");
                    sbReport.Append(GenerateReportTambahan(statusApp, statusDesc, dtHead, dtDetail));
                }
                divLoopReport.InnerHtml = sbReport.ToString();
            }
        }

        private StringBuilder GenerateReportTambahan(string statusApp, string statusDesc, DataTable dtHead, DataTable dtDetail)
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

                sb.Append(" <div class=\"card card-primary card-outline\"> \n");
                sb.Append(" <div class=\"card-header\">\r\n " +
                    "<h4 class=\"card-title\" runat=\"server\">Report SLIK Result - " + statusDesc + "</h4>\r\n </div>");
                sb.Append(" <div class=\"card-body\">");
                sb.Append(" <div> \n");
                sb.Append("<div class=\"row\">\r\n                       " +
                    " <div class=\"col-sm-12\">\r\n                           " +
                   "<table style=\"border:0;width:100%\"> \n " +
                   "<tr>  <td style=\"width:25%\">Customer Name</td> \n  <td style=\"width:10px\">:</td> \n " +
                   " <td><b><span> " + custName + "</span></b></td> \n </tr> \n " +
                   "<tr><td style=\"width:30%\">Total Fasilitas / Aktif</td><td style=\"width:10px\">:</td> \n " +
                   "<td><b><span>" + totalFasilitas + " / " + totalAktif +"</span></b></td> \n </tr> \n " +
                   "<tr><td style=\"width:30%\">Plafon Efektif / Baki Debet</td> <td style=\"width:10px\">:</td> \n " +
                   "<td><b><span>" + plafon + " / Rp " + bakiDebet +"</span></b></td> \n</tr> \n" +
                   "</table> \n" +                                
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
                        + " | " + worst + " | " + lastRepeatedOvd + " | Lunas " + tglKondisi + " | " + frekuensiRestru + " | Estimasi Angsuran " + angsuran);
                    sb.Append("</div>");
                }
            }

            sb.Append("<br />");
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

        private StringBuilder GetKontrakWO(DataTable dt, string statusApp)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append(" \n <hr /> \n  <b>Kontrak Fasiltas HAPUS BUKU / HAPUS TAGIH :</b> <hr /> \n");
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