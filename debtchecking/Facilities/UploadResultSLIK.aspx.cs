using DMS.Tools;
using Microsoft.Office.Interop.Excel;
using MWSFramework;
using System;
using System.Collections;
using System.Collections.Specialized;
using System.IO;
using System.Reflection;
using System.Web;

namespace DebtChecking.Facilities
{
    public partial class UploadResultSLIK : DataPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        private void ProcessExcel(string path)
        {
            ApplicationClass app = new ApplicationClass();
            Workbook book = null;
            Range range = null;

            try
            {
                app.Visible = false;
                app.ScreenUpdating = false;
                app.DisplayAlerts = false;

                string execPath = Path.GetDirectoryName(Assembly.GetExecutingAssembly().CodeBase);

                book = app.Workbooks.Open(path, Missing.Value, Missing.Value, Missing.Value
                                                  , Missing.Value, Missing.Value, Missing.Value, Missing.Value
                                                 , Missing.Value, Missing.Value, Missing.Value, Missing.Value
                                                , Missing.Value, Missing.Value, Missing.Value);
                foreach (Worksheet sheet in book.Worksheets)
                {
                    //Console.WriteLine(@"Values for Sheet " + sheet.Index);

                    if (sheet.Index != 1)
                    {
                        break;
                    }
                    // get a range to work with
                    range = sheet.get_Range("A1", Missing.Value);
                    // get the end of values to the right (will stop at the first empty cell)
                    range = range.get_End(XlDirection.xlToRight);
                    // get the end of values toward the bottom, looking in the last column (will stop at first empty cell)
                    range = range.get_End(XlDirection.xlDown);

                    // get the address of the bottom, right cell
                    string downAddress = range.get_Address(
                        false, false, XlReferenceStyle.xlA1,
                        Type.Missing, Type.Missing);

                    // Get the range, then values from a1
                    range = sheet.get_Range("A1", downAddress);
                    object[,] values = (object[,])range.Value2;

                    for (int i = 2; i <= values.GetLength(0); i++)
                    {
                        int counter = 0;
                        ArrayList data = new ArrayList();
                        for (int j = 1; j <= values.GetLength(1); j++)
                        {
                            data.Add(values[i, j].ToString().Contains(" - ") ? values[i, j].ToString().Split('-')[0].Trim() : values[i, j].ToString());
                        }

                        NameValueCollection Keys = new NameValueCollection();
                        NameValueCollection Fields = new NameValueCollection();
                        Fields["inputdate"] = "getdate()";
                        staticFramework.saveNVC(Fields, "inputby", USERID);
                        staticFramework.saveNVC(Fields, "reqstatus", "DRF");
                        staticFramework.saveNVC(Keys, "requestid", genreqid(data[6].ToString()));
                        staticFramework.saveNVC(Fields, "productid", data[counter++]);

                        string branchid = Convert.ToInt32(data[counter++]).ToString("000");
                        staticFramework.saveNVC(Fields, "branchid", branchid);
                        staticFramework.saveNVC(Fields, "purpose", Convert.ToInt32(data[counter++]).ToString());
                        staticFramework.saveNVC(Fields, "cust_name", data[counter++]);

                        double d = double.Parse(data[counter++].ToString());
                        DateTime dob = DateTime.FromOADate(d);
                        staticFramework.saveNVC(Fields, "dob", dob);

                        decimal ktp = Decimal.Parse(data[counter++].ToString(), System.Globalization.NumberStyles.Any);
                        staticFramework.saveNVC(Fields, "ktp", ktp);
                        staticFramework.saveNVC(Fields, "cust_type", data[counter++]);

                        decimal npwp = Decimal.Parse(data[counter++].ToString(), System.Globalization.NumberStyles.Any);
                        staticFramework.saveNVC(Fields, "npwp", npwp);
                        staticFramework.saveNVC(Fields, "status_bpkb", data[counter++]);
                        staticFramework.saveNVC(Fields, "nama_bpkb", data[counter++]);
                        staticFramework.saveNVC(Fields, "pob", data[counter++]);
                        staticFramework.saveNVC(Fields, "gender", (data[counter++]).ToString() == "Perempuan" ? "F" : "M");
                        staticFramework.saveNVC(Fields, "mother_name", data[counter++]);
                        staticFramework.saveNVC(Fields, "homeaddress", data[counter++]);
                        staticFramework.saveNVC(Fields, "phonenumber", data[counter++]);

                        staticFramework.save(Fields, Keys, "apprequest", conn);
                    }
                }

                MyPage.popMessage(this.Page, "Upload Sukses!");
            }
            catch (Exception e)
            {
                MyPage.popMessage(this.Page, "Upload Gagal, Mohon Periksa Kembali Dokumen Anda");
            }
            finally
            {
                range = null;
                if (book != null)
                    book.Close(false, Missing.Value, Missing.Value);
                book = null;
                if (app != null)
                    app.Quit();
                File.Delete(path);
                app = null;
            }
        }

        private string genreqid(string cust_type)
        {
            string reqid = "";
            object[] param = new object[] { cust_type };
            conn.ExecReader("exec sp_gen_requestid @1", param, dbtimeout);
            if (conn.hasRow()) reqid = conn.GetFieldValue(0);
            return reqid;
        }

        protected void btn_upload_Click(object sender, EventArgs e)
        {
            if (fileUploadExcel.PostedFile != null)
            {
                string targetFolder = HttpContext.Current.Server.MapPath("~/Upload/RequestSLIK");
                string targetPath = Path.Combine(targetFolder, new Guid() + ".xlsx");
                fileUploadExcel.PostedFile.SaveAs(targetPath);

                ProcessExcel(targetPath);
            }
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
    }
}