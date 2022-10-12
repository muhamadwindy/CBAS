using DevExpress.Web;
using DMS.Tools;
using EvoPdf.HtmlToPdf;

//using Newtonsoft.Json;
//using Newtonsoft.Json.Linq;
using Ionic.Zip;
using MWSFramework;
using System;
using System.Data;
using System.IO;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace DebtChecking.Facilities
{
    public partial class SLIKResult : DataPage
    {
        private int i;

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
            staticFramework.retrieve(dt, npwp);
            staticFramework.retrieve(dt, genderdesc);
            staticFramework.retrieve(dt, mother_name);
            //staticFramework.retrieve(dt, full_ktpaddress);
            staticFramework.retrieve(dt, full_homeaddress);
            staticFramework.retrieve(dt, full_officeaddress);
            staticFramework.retrieve(dt, full_econaddress);
            staticFramework.retrieve(dt, final_policy);
        }

        private void runcreditpolicy(string key)
        {
            object[] par = new object[] { key };
            conn.ExecNonQuery("exec slik_clearPolicy @1", par, dbtimeout);
            string sql = "select * from slik_vw_creditpolicy where appid = @1 ";
            DataTable dt = conn.GetDataTable(sql, par, dbtimeout);
            for (int i = 0; i <= dt.Rows.Count - 1; i++)
            {
                DecSystem d = new DecSystem(conn);
                string resultid = dt.Rows[i]["fasilitasid"].ToString();
                par = new object[] { resultid, "SLIK" };
                try
                {
                    string ResultID = d.execute("AND [slik_ideb_kredit].[fasilitasid]=@1", par, "POLICY", "SLIK", null);
                    par = new object[] { resultid, "POLICY", "SLIK", ResultID };
                    conn.ExecuteNonQuery("EXEC SP_APPDECSYSRES @1,@2,@3,@4", par, dbtimeout);
                }
                catch { }
            }
            par = new object[] { key };
            conn.ExecNonQuery("exec slik_updFinalPolicy @1", par, dbtimeout);
        }

        private void cekrules()
        {
            conn.ExecReader("select approval_group from scallgroup where groupid = @1", new object[] { GROUPID }, dbtimeout);
            if (conn.hasRow())
            {
                if (conn.GetFieldValue(0).ToString() == "1")
                {
                    Button1.Disabled = false;
                }
                else
                {
                    Button1.Disabled = true;
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                retrieve_debiturinfo(Request.QueryString["regno"]);
                ViewData(Request.QueryString["regno"]);
                ViewDataNotFound(Request.QueryString["regno"]);
                cekrules();
            }
            else
            {
                retrieve_debiturinfo(Request.QueryString["regno"]);
                ViewData(Request.QueryString["regno"]);
                ViewDataNotFound(Request.QueryString["regno"]);
            }
        }

        private void ViewData(string key)
        {
            string src = "";
            try
            {
                DataTable dt = conn.GetDataTable("exec sp_slik_resultmatch_byreffnum @1", new object[] { key }, dbtimeout);
                for (i = 0; i <= dt.Rows.Count - 1; i++)
                {
                    string nik = dt.Rows[i]["nik"].ToString();
                    string detailid = dt.Rows[i]["trn_ideb_detail_id"].ToString();
                    string idebid = dt.Rows[i]["trn_ideb_id"].ToString();
                    //string pdfviewsite = ConfigurationSettings.AppSettings["pdfviewsite"];
                    string pdfviewsite = "ViewPDF.aspx?";

                    TB_SIDLIST.Rows.Add(new TableRow());
                    TB_SIDLIST.Rows[i].Cells.Add(new TableCell());
                    //checkbox
                    //System.Web.UI.WebControls.CheckBox ck = new CheckBox();
                    //ck.ID = "CK_" + i.ToString();
                    //if ((bool)dt.Rows[i]["selected"]) { ck.Checked = true; } else { ck.Checked = false; }
                    //TB_SIDLIST.Rows[i].Cells[0].Controls.Add(ck);
                    //hidden seq
                    System.Web.UI.HtmlControls.HtmlInputHidden hdn = new HtmlInputHidden();
                    hdn.ID = "HD_" + i.ToString();
                    hdn.Value = dt.Rows[i]["nik"].ToString();
                    TB_SIDLIST.Rows[i].Cells[0].Controls.Add(hdn);
                    //hyperlink
                    System.Web.UI.WebControls.HyperLink h = new HyperLink();
                    h.ID = "HL_" + i.ToString();
                    h.ClientIDMode = ClientIDMode.Static;
                    h.Target = "IFR_TEXT";
                    h.Text = dt.Rows[i]["linkname"].ToString();
                    h.Attributes.Add("style", "cursor:hand");
                    string urlnavigate = "notyetuploaded.html";
                    if (!String.IsNullOrEmpty(idebid) && !String.IsNullOrEmpty(detailid))
                        urlnavigate = pdfviewsite + "idebid=" + idebid + "&detailid=" + detailid;
                    h.Attributes.Add("onclick", "javascript:kliklink('" + h.ClientID + "','" + urlnavigate + "')");
                    if (dt.Rows[i]["POLRES"].ToString() != "1") h.ForeColor = System.Drawing.Color.Red;
                    h.ToolTip = dt.Rows[i]["result_name"].ToString();
                    TB_SIDLIST.Rows[i].Cells[0].Controls.Add(h);
                    if (i == 0)
                    {
                        src = urlnavigate;
                        urlframe.Value = urlnavigate;
                    }
                    //hyperlink matching score
                    System.Web.UI.WebControls.HyperLink h2 = new HyperLink();
                    h2.ID = "HLmatch_" + i.ToString();
                    //h2.Text = " (" + dt.Rows[i]["match_level"].ToString() + ")";
                    h2.Text = "Detail";
                    h2.CssClass = "label label-success label-sm ml-2";
                    //h2.Font.Underline = true;
                    h2.Attributes.Add("style", "cursor:hand");
                    h2.Attributes.Add("onclick", "javascript:PopupPage('DetailValidation.aspx?id=" + dt.Rows[i]["resultid"].ToString() + "',800,600)");
                    TB_SIDLIST.Rows[i].Cells[0].Controls.Add(h2);
                }
            }
            catch (Exception ex)
            {
                MyPage.popMessage(this, ex.Message);
            }
            nikcount.Value = i.ToString();
            if (i == 0)
            {
                dv_found.Attributes.Add("style", "display:none");
            }
            else
            {
                TR_MSG.Visible = false;
                TR_FRAME.Visible = true;
                IFR_TEXT.Attributes.Add("src", src);
                btnpdf.Style.Add("display", "none");
                //disini
                if (GROUPID.ToString() == "00")
                {
                    btnpdf.Style.Remove("display");
                }
            }
        }

        private void ViewDataNotFound(string key)
        {
            string src = "";
            int found = i;
            try
            {
                DataTable dt2 = conn.GetDataTable("exec sp_slik_notfound_byreffnum @1", new object[] { key }, dbtimeout);
                for (int c = 0; c <= dt2.Rows.Count - 1; c++)
                {
                    TB_NIHIL.Rows.Add(new TableRow());
                    TB_NIHIL.Rows[c].Cells.Add(new TableCell());
                    i++;
                    //hyperlink
                    System.Web.UI.WebControls.HyperLink h = new HyperLink();
                    h.ID = "HL_" + i.ToString();
                    h.ClientIDMode = ClientIDMode.Static;
                    h.Target = "IFR_TEXT";
                    h.Text = "- <u>Combination " + (c + 1).ToString() + "</u>";
                    h.Attributes.Add("style", "cursor:hand");
                    string urlnavigate = "SLIKNotFound.aspx?id=" + dt2.Rows[c]["combinationid"].ToString();
                    h.Attributes.Add("onclick", "javascript:kliklink('" + h.ClientID + "','" + urlnavigate + "')");
                    TB_NIHIL.Rows[c].Cells[0].Controls.Add(h);
                    if (found == 0 && c == 0)
                    {
                        src = urlnavigate;
                        urlframe.Value = urlnavigate;
                    }
                }
                if (dt2.Rows.Count == 0) dv_nihil.Attributes.Add("style", "display:none");
            }
            catch (Exception ex)
            {
                //MyPage.popMessage(this, ex.Message);
            }
            if (found == 0) dv_found.Attributes.Add("style", "display:none");
            if (i == 0)
            {
                //LBL_MSG.Text = "DATA ONPROCESS";
                DataTable dtRes = conn.GetDataTable("exec sp_slik_check_status @1", new object[] { key }, dbtimeout);

                if (dtRes.Rows.Count > 0)
                {
                    LBL_MSG.Text = dtRes.Rows[0][0].ToString();
                }
                else
                {
                    LBL_MSG.Text = "DATA NOT AVAILABLE";
                }

                TR_MSG.Visible = true;
                TR_FRAME.Visible = false;
                btnprint.Visible = false;
                btnpdf.Visible = false;
            }
            if (found == 0 && i > 0)
            {
                TR_MSG.Visible = false;
                TR_FRAME.Visible = true;
                IFR_TEXT.Attributes.Add("src", src);
            }
        }

        protected static bool EnabledControls(Control ctrl, bool postback)
        {
            foreach (Control child in ctrl.Controls)
                try
                {
                    postback = EnabledControls(child, postback);
                }
                catch { }

            switch (ctrl.GetType().Name)
            {
                case "HyperLink":
                    HyperLink a = (HyperLink)ctrl;
                    a.Enabled = true;
                    break;

                default:
                    break;
            }

            return postback;
        }

        #region mainpanel callback

        protected void mainPanel_Callback(object source, CallbackEventArgsBase e)
        {
            if (e.Parameter == "s:")
            {
                try
                {
                    int seq;
                    for (int x = 0; x < int.Parse(nikcount.Value); x++)
                    {
                        CheckBox c = Page.FindControl("CK_" + x.ToString()) as CheckBox;
                        HtmlInputHidden hd = Page.FindControl("HD_" + x.ToString()) as HtmlInputHidden;
                        if (c != null)
                        {
                            seq = x + 1;
                            string selection = "1";
                            string chkSeq = "";
                            if (c.Checked) { selection = "1"; } else { selection = "0"; }
                            chkSeq = hd.Value;
                            string SP = "exec SLIK_UPDATE_SELECTION @1,@2,@3";
                            object[] prmtr = new object[] { Request.QueryString["regno"], chkSeq, selection };
                            conn.ExecuteNonQuery(SP, prmtr, dbtimeout);
                        }
                    }
                    runcreditpolicy(Request.QueryString["regno"]);
                    retrieve_debiturinfo(Request.QueryString["regno"]);
                    mainPanel.JSProperties["cp_alert"] = "Data Saved & Recalculated.";
                    mainPanel.JSProperties["cp_export"] = "";
                    mainPanel.JSProperties["cp_filename"] = "";
                }
                catch (Exception ex)
                {
                    string errmsg = ex.Message;
                    if (errmsg.IndexOf("Last Query") > 0)
                        errmsg = errmsg.Substring(0, errmsg.IndexOf("Last Query"));
                    //mainPanel.JSProperties["cp_alert"] = errmsg;
                }
            }
            else if (e.Parameter == "d:")
            {
                try
                {
                    string sql = "select p.reffnumber, p.cust_name, n.nik, a.ideb_content_ina, a.ideb_pdf from trn_ideb_detail_attrs a " +
                            "join trn_ideb_details d on d.trn_ideb_detail_id = a.trn_ideb_detail_id " +
                            "join slik_appnik n on n.trn_ideb_detail_id = d.trn_ideb_detail_id and n.match = 1 " +
                            "join slik_applicant p on p.appid = n.appid where p.appid = @1";
                    DataTable dt = conn.GetDataTable(sql, new object[] { Request.QueryString["regno"] }, dbtimeout);

                    string DownloadPath = "../Download/All/" + USERID + "/";
                    string PhysicalPath = Server.MapPath(DownloadPath);
                    if (!Directory.Exists(PhysicalPath)) Directory.CreateDirectory(PhysicalPath);

                    DirectoryInfo diTemp = new DirectoryInfo(PhysicalPath);
                    foreach (FileInfo Finf_loopVariable in diTemp.GetFiles("*.*"))
                    {
                        File.Delete(Finf_loopVariable.FullName);
                    }

                    string reffnumber = null, cust_name = null;

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        reffnumber = dt.Rows[i]["reffnumber"].ToString();
                        cust_name = dt.Rows[i]["cust_name"].ToString();
                        string pdffilename = reffnumber + "_" + cust_name + "_" + dt.Rows[i]["nik"].ToString() + ".pdf";
                        pdffilename = PhysicalPath + "\\" + pdffilename;
                        byte[] pdfbyte = (byte[])dt.Rows[i]["ideb_pdf"];
                        File.WriteAllBytes(pdffilename, pdfbyte);

                        string txtfilename = reffnumber + "_" + cust_name + "_" + dt.Rows[i]["nik"].ToString() + ".txt";
                        txtfilename = PhysicalPath + "\\" + txtfilename;
                        string json = dt.Rows[i]["ideb_content_ina"].ToString();
                        //var fjson = JToken.Parse(json).ToString(Formatting.Indented);
                        File.WriteAllText(txtfilename, json);
                    }

                    if (!String.IsNullOrEmpty(reffnumber))
                    {
                        System.Collections.Generic.IList<string> documentPaths = new System.Collections.Generic.List<string>();
                        DirectoryInfo diTemp2 = new DirectoryInfo(PhysicalPath);
                        foreach (FileInfo Finf_loopVariable in diTemp2.GetFiles("*.*"))
                        {
                            documentPaths.Add(Finf_loopVariable.FullName);
                        }

                        using (ZipFile Zip = new ZipFile())
                        {
                            Zip.AddFiles(documentPaths, false, "");
                            Zip.Save(string.Format(PhysicalPath + "{0}_{1}.zip", reffnumber, cust_name));
                        }

                        mainPanel.JSProperties["cp_export"] = DownloadPath + reffnumber + "_" + cust_name + ".zip";
                        mainPanel.JSProperties["cp_filename"] = reffnumber + "_" + cust_name + ".zip";
                    }
                    else
                    {
                        mainPanel.JSProperties["cp_alert"] = "No data to download";
                    }
                }
                catch (Exception ex)
                {
                    string errmsg = ex.Message;
                    if (errmsg.IndexOf("Last Query") > 0)
                        errmsg = errmsg.Substring(0, errmsg.IndexOf("Last Query"));
                    mainPanel.JSProperties["cp_alert"] = errmsg;
                }
            }
        }

        #endregion mainpanel callback

        protected void Button1_Click(object sender, EventArgs e)
        {
            int seq;
            for (int x = 0; x < i; x++)
            {
                CheckBox c = Page.FindControl("CK_" + x.ToString()) as CheckBox;
                HtmlInputHidden hd = Page.FindControl("HD_" + x.ToString()) as HtmlInputHidden;
                if (c != null)
                {
                    seq = x + 1;
                    string selection = "1";
                    string chkSeq = "";
                    if (c.Checked) { selection = "1"; } else { selection = "0"; }
                    chkSeq = hd.Value;
                    string SP = "exec SLIK_UPDATE_SELECTION @1,@2,@3";
                    object[] prmtr = new object[] { Request.QueryString["regno"], chkSeq, selection };
                    conn.ExecuteNonQuery(SP, prmtr, dbtimeout);
                }
            }
            runcreditpolicy(Request.QueryString["regno"]);
            MyPage.popMessage(this, "Data Saved & Recalculated.");
        }

        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);
            EnabledControls(this, false);
        }

        protected void pdfPanel_Callback(object source, CallbackEventArgsBase e)
        {
            try
            {
                string DownloadPath = Server.MapPath("../Download/pdf/");

                PdfConverter pdfConverter = new PdfConverter();
                // set the license key
                pdfConverter.LicenseKey = "Vn1ndmVldmdkdmV4Y3ZlZ3hnZHhvb29v";
                // save the PDF bytes in a file on disk
                //string url = Request.Url.ToString().Substring(0, Request.Url.ToString().LastIndexOf("/")) + "/" + e.Parameter + "&bypasssession=1";
                string url = "";

                string a = e.Parameter.ToString();
                string b = urlframe.Value;

                if (urlframe.Value.LastIndexOf("7000") > 0)
                    url = e.Parameter.ToString();
                else
                    url = Request.Url.ToString().Substring(0, Request.Url.ToString().LastIndexOf("/")) + "/" + e.Parameter.ToString() + "&bypasssession=1";

                //url = Request.Url.ToString().Substring(0, Request.Url.ToString().LastIndexOf("/")) + "/" + urlframe.Value + "&bypasssession=1";

                //url = urlframe.Value;

                if (url.Contains("ViewPDF.aspx"))
                {
                    pdfPanel.JSProperties["cp_redirect"] = url;
                    pdfPanel.JSProperties["cp_target"] = "_blank";
                }
                else
                {
                    Guid guid = Guid.NewGuid();
                    string filename = guid.ToString() + ".pdf";
                    string fullfilename = DownloadPath + filename;
                    pdfConverter.SavePdfFromUrlToFile(url, fullfilename);
                    pdfPanel.JSProperties["cp_redirect"] = "../Download/pdf/" + filename;
                    pdfPanel.JSProperties["cp_target"] = "_blank";
                }

                //Response.Write("<script>window.open('../Download/pdf/" + filename + "');</script>");
            }
            catch (Exception ex)
            {
                pdfPanel.JSProperties["cp_alert"] = ex.Message;
            }
        }
    }
}