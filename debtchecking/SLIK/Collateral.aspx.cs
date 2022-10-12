using DevExpress.Web;
using EvoPdf.HtmlToPdf;
using MWSFramework;
using System;
using System.Data;

namespace DebtChecking.SLIK
{
    public partial class Collateral : DataPage
    {
        #region retrieve

        private void retrieve_debiturinfo(string key)
        {
            string sql = "select * from slik_vw_applicant where appid = @1";
            DataTable dt = conn.GetDataTable(sql, new object[] { key }, dbtimeout);
            staticFramework.retrieve(dt, appid);
            staticFramework.retrieve(dt, reffnumber);
            staticFramework.retrieve(dt, status_app);
            staticFramework.retrieve(dt, cust_name);
            staticFramework.retrieve(dt, pob_dob);
            staticFramework.retrieve(dt, ktp);
            staticFramework.retrieve(dt, genderdesc);
            //staticFramework.retrieve(dt, full_ktpaddress);
            staticFramework.retrieve(dt, final_policy);
        }

        #endregion retrieve

        #region databinding

        private void gridbind_agunan(string key)
        {
            object[] par = new object[] { key };
            DataTable dt = conn.GetDataTable("exec SP_GET_IDEB_AGUNAN @1", par, dbtimeout);
            GridViewColl.DataSource = dt;
            GridViewColl.DataBind();
        }

        #endregion databinding

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                retrieve_debiturinfo(Request.QueryString["regno"]);
                if (Request.QueryString["bypasssession"] != null)
                {
                    btnprint.Visible = false;
                    btnpdf.Visible = false;
                }
            }
            else
            {
                retrieve_debiturinfo(Request.QueryString["regno"]);
            }
        }

        #region agunan

        protected void GridViewColl_Load(object sender, EventArgs e)
        {
            gridbind_agunan(Request.QueryString["regno"]);
        }

        #endregion agunan

        protected void pdfPanel_Callback(object source, CallbackEventArgsBase e)
        {
            try
            {
                string DownloadPath = Server.MapPath("../Download/pdf/");

                PdfConverter pdfConverter = new PdfConverter();
                // set the license key
                pdfConverter.LicenseKey = "Vn1ndmVldmdkdmV4Y3ZlZ3hnZHhvb29v";
                // save the PDF bytes in a file on disk
                string url = Request.Url.ToString() + "&bypasssession=1";
                string filename = Request.QueryString["regno"] + "_" + USERID + "_" + DateTime.Now.ToString("ddMMyyHHmmss") + ".pdf";
                string fullfilename = DownloadPath + filename;
                pdfConverter.SavePdfFromUrlToFile(url, fullfilename);
                pdfPanel.JSProperties["cp_redirect"] = "../Download/pdf/" + filename;
                pdfPanel.JSProperties["cp_target"] = "_blank";
                //Response.Write("<script>window.open('../Download/pdf/" + filename + "');</script>");
            }
            catch (Exception ex)
            {
                pdfPanel.JSProperties["cp_alert"] = ex.Message;
            }
        }
    }
}