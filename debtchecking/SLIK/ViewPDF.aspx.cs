using System;

namespace DebtChecking.Facilities
{
    public partial class ViewPDF : DataPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string idebid = Request.QueryString["idebid"];
            string detailid = Request.QueryString["detailid"];
            string sql = "select top 1 ideb_pdf from trn_ideb_detail_attrs where trn_ideb_detail_id = @1";
            conn.ExecReader(sql, new object[] { detailid }, dbtimeout);
            if (conn.hasRow())
            {
                byte[] pdfbyte = (byte[])conn.GetNativeFieldValue(0);
                Response.ContentType = "application/pdf";
                Response.AddHeader("content-length", pdfbyte.Length.ToString());
                Response.BinaryWrite(pdfbyte);
            }
            else
            {
                Response.Write("<center><b><font color='red'>PDF data not found</font></b></center>");
            }
        }
    }
}