using DevExpress.Spreadsheet;
using DMS.Tools;
using MWSFramework;
using System;
using System.Collections.Specialized;
using System.IO;
using System.Web;

namespace DebtChecking.Facilities
{
    public partial class UploadBulk : DataPage
    {

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private string genreqid(string cust_type)
        {
            string reqid = "";
            object[] param = new object[] { cust_type };
            conn.ExecReader("exec sp_gen_requestid @1", param, dbtimeout);
            if (conn.hasRow()) reqid = conn.GetFieldValue(0);
            return reqid;
        }

        protected void linkDownloadTemplate_Click(object sender, EventArgs e)
        {
            string url = ResolveUrl("~/TemplateFile/Template_Request_SLIK.xlsx");
            string file = System.IO.Path.GetFileName(url);

            Response.Clear();
            Response.ContentType = "text/html";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + file);
            Response.WriteFile(url); //use your file path here.
            Response.Flush();
            Response.End();
        }

        private static string targetFolder;
        private static string targetPath;

        protected void UploadControl_FileUploadComplete(object sender, DevExpress.Web.FileUploadCompleteEventArgs e)
        {
            targetFolder = HttpContext.Current.Server.MapPath("~/Upload/RequestSLIK");
            targetPath = Path.Combine(targetFolder, new Guid() + ".xlsx");
            e.UploadedFile.SaveAs(targetPath);
        }

        private string getValWorkSheet(Worksheet sheetUtamane, string v)
        {
            string value = sheetUtamane.Cells[v].Value.ToString();
            return value.Contains(" - ") ? value.Split('-')[0].Trim() : value.Trim();
        }

        protected void mainPanel_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            if (e.Parameter.StartsWith("excproc:"))
            {
                string fileName = e.Parameter.Split(':')[1];
                string messages = "";

                // Create a new workbook.
                Workbook workbook = new Workbook();

                // Load a workbook from the file.
                workbook.LoadDocument(targetPath, DocumentFormat.Xlsx);

                try
                {
                    Worksheet sheetUtamane = workbook.Worksheets[0];
                    Array[] temp_app_list = new Array[40];
                    for (int i = 2; i <= 41; i++)
                    {
                        Object[] temp_app = new Object[2];
                        temp_app[0] = getValWorkSheet(sheetUtamane, "A" + i);
                        if (string.IsNullOrEmpty(temp_app[0].ToString()))
                        {
                            continue;
                        }
                        NameValueCollection Keys = new NameValueCollection();
                        NameValueCollection Fields = new NameValueCollection();

                        staticFramework.saveNVC(Fields, "inputby", USERID);
                        staticFramework.saveNVC(Fields, "reqstatus", "ADM");

                        string genreq = genreqid(getValWorkSheet(sheetUtamane, "H" + i));
                        temp_app[1] = genreq;

                        temp_app_list[i - 2] = temp_app;
                        staticFramework.saveNVC(Keys, "requestid", genreq);
                        staticFramework.saveNVC(Fields, "productid", getValWorkSheet(sheetUtamane, "B" + i));

                        string branchid = Convert.ToInt32(getValWorkSheet(sheetUtamane, "C" + i)).ToString("000");
                        staticFramework.saveNVC(Fields, "branchid", branchid);
                        staticFramework.saveNVC(Fields, "purpose", Convert.ToInt32(getValWorkSheet(sheetUtamane, "D" + i)).ToString());
                        staticFramework.saveNVC(Fields, "cust_name", getValWorkSheet(sheetUtamane, "E" + i));

                        DateTime dob = DateTime.Parse(getValWorkSheet(sheetUtamane, "F" + i));
                        staticFramework.saveNVC(Fields, "dob", dob);

                        decimal ktp = Decimal.Parse(getValWorkSheet(sheetUtamane, "G" + i), System.Globalization.NumberStyles.Any);
                        staticFramework.saveNVC(Fields, "ktp", ktp);
                        staticFramework.saveNVC(Fields, "cust_type", getValWorkSheet(sheetUtamane, "H" + i));

                        decimal npwp = Decimal.Parse(getValWorkSheet(sheetUtamane, "I" + i) == "" ? "0" : getValWorkSheet(sheetUtamane, "I" + i), System.Globalization.NumberStyles.Any);
                        staticFramework.saveNVC(Fields, "npwp", npwp);
                        staticFramework.saveNVC(Fields, "status_bpkb", getValWorkSheet(sheetUtamane, "J" + i));
                        staticFramework.saveNVC(Fields, "nama_bpkb", getValWorkSheet(sheetUtamane, "K" + i));
                        staticFramework.saveNVC(Fields, "pob", getValWorkSheet(sheetUtamane, "L" + i));
                        staticFramework.saveNVC(Fields, "gender", (getValWorkSheet(sheetUtamane, "M" + i)).ToString() == "Perempuan" ? "F" : "M");
                        staticFramework.saveNVC(Fields, "mother_name", getValWorkSheet(sheetUtamane, "N" + i));
                        staticFramework.saveNVC(Fields, "homeaddress", getValWorkSheet(sheetUtamane, "O" + i));
                        staticFramework.saveNVC(Fields, "phonenumber", getValWorkSheet(sheetUtamane, "P" + i));

                        Fields["inputdate"] = "getdate()";
                        staticFramework.save(Fields, Keys, "apprequest", conn);
                    }

                    Worksheet sheetLainnya = workbook.Worksheets[1];

                    for (int i = 2; i <= 101; i++)
                    {
                        string NoInSheet = getValWorkSheet(sheetLainnya, "A" + i);
                        if (string.IsNullOrEmpty(NoInSheet))
                        {
                            continue;
                        }
                        NameValueCollection Keys = new NameValueCollection();
                        NameValueCollection Fields = new NameValueCollection();
                        string requestid = "";
                        for (int idx_app = 0; idx_app < temp_app_list.Length; idx_app++)
                        {
                            object[] dataapp = (object[])temp_app_list[idx_app];
                            if (NoInSheet == dataapp[0].ToString())
                            {
                                requestid = dataapp[1].ToString();
                                break;
                            }
                        }

                        if (requestid == "")
                        {
                            messages += "SLIK Lainnya Nomor " + NoInSheet + " tidak match dengan SLIK Utama!";
                            break;
                        }
                        staticFramework.saveNVC(Keys, "requestid", requestid);
                        staticFramework.saveNVC(Keys, "seq", "");
                        staticFramework.saveNVC(Fields, "cust_type", getValWorkSheet(sheetLainnya, "B" + i));
                        staticFramework.saveNVC(Fields, "cust_name", getValWorkSheet(sheetLainnya, "D" + i));
                        staticFramework.saveNVC(Fields, "status_app", getValWorkSheet(sheetLainnya, "C" + i));

                        DateTime dob = DateTime.Parse(getValWorkSheet(sheetLainnya, "E" + i));
                        staticFramework.saveNVC(Fields, "dob", dob);

                        decimal ktp = Decimal.Parse(getValWorkSheet(sheetLainnya, "F" + i) == "" ? "0" : getValWorkSheet(sheetLainnya, "F" + i), System.Globalization.NumberStyles.Any);
                        staticFramework.saveNVC(Fields, "ktp", ktp);
                        staticFramework.saveNVC(Fields, "pob", getValWorkSheet(sheetLainnya, "H" + i));

                        decimal npwp = Decimal.Parse(getValWorkSheet(sheetLainnya, "G" + i) == "" ? "0" : getValWorkSheet(sheetLainnya, "G" + i), System.Globalization.NumberStyles.Any);
                        staticFramework.saveNVC(Fields, "npwp", npwp == 0 ? "" : npwp.ToString());
                        staticFramework.saveNVC(Fields, "homeaddress", getValWorkSheet(sheetLainnya, "K" + i));
                        staticFramework.saveNVC(Fields, "phonenumber", getValWorkSheet(sheetLainnya, "L" + i));
                        staticFramework.saveNVC(Fields, "gender", (getValWorkSheet(sheetLainnya, "I" + i)).ToString() == "Perempuan" ? "F" : "M");
                        staticFramework.saveNVC(Fields, "mother_name", getValWorkSheet(sheetLainnya, "J" + i));

                        Fields["inputdate"] = "getdate()";
                        staticFramework.save(Fields, Keys, "apprequestsupp",
                            "DECLARE @seq INT \n" +
                            "SELECT @seq=ISNULL(MAX(seq),0)+1 FROM apprequestsupp " +
                            "WHERE requestid='" + requestid + "' \n", conn);
                    }

                    messages = "File " + fileName + " berhasil diproses!";
                }
                catch (Exception ex)
                {
                    messages = "Upload Gagal, Mohon Periksa Kembali Dokumen Anda. Message : " + ex.Message;
                }
                finally
                {
                    File.Delete(targetPath);
                }

                mainPanel.JSProperties["cp_alert"] = messages;
            }
        }
    }
}