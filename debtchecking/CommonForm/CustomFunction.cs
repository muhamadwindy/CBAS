using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DMS.Tools;
using System.Configuration;
using System.Data;
using System.IO;
using OfficeOpenXml;
using Newtonsoft.Json;

namespace DebtChecking.CommonForm
{
    public static class CustomFunction
    {
        public static string GetDictionaryValueObject(Dictionary<string, object> data, string val)
        {
            string result = "";
            if (data != null && data.ContainsKey(val) && data[val] != null)
            {
                result = data[val].ToString().Trim();
            }

            return result;
        }

        public static DataTable ReadFromExcel(string path, System.IO.Stream streamFile, int sheet, bool hasHeader = true)
        {
            DataTable excelasTable = new DataTable();
            ExcelPackage.LicenseContext = LicenseContext.NonCommercial;
            using (var excelPack = new ExcelPackage())
            {
                //Load excel stream
                if (!string.IsNullOrEmpty(path))
                {
                    using (var stream = File.OpenRead(path))
                    {
                        excelPack.Load(stream);
                    }
                }
                else
                {
                    excelPack.Load(streamFile);
                }

                //Lets Deal with first worksheet.(You may iterate here if dealing with multiple sheets)
                var ws = excelPack.Workbook.Worksheets[sheet];

                //Get all details as DataTable -because Datatable make life easy :)

                foreach (var firstRowCell in ws.Cells[1, 1, 1, ws.Dimension.End.Column])
                {
                    //Get colummn details
                    if (!string.IsNullOrEmpty(firstRowCell.Text))
                    {
                        string firstColumn = string.Format("Column {0}", firstRowCell.Start.Column);
                        excelasTable.Columns.Add(hasHeader ? firstRowCell.Text : firstColumn);
                    }
                }
                var startRow = hasHeader ? 2 : 1;
                //Get row details
                for (int rowNum = startRow; rowNum <= ws.Dimension.End.Row; rowNum++)
                {
                    var wsRow = ws.Cells[rowNum, 1, rowNum, excelasTable.Columns.Count];
                    DataRow row = excelasTable.Rows.Add();
                    foreach (var cell in wsRow)
                    {
                        row[cell.Start.Column - 1] = cell.Text;
                    }
                }
                return excelasTable;
            }
        }

        public static T ReadFromExcel<T>(string path, System.IO.Stream streamFile, int sheet, bool hasHeader = true)
        {
            using (var excelPack = new ExcelPackage())
            {
                //Load excel stream
                if (!string.IsNullOrEmpty(path))
                {
                    using (var stream = File.OpenRead(path))
                    {
                        excelPack.Load(stream);
                    }
                }
                else
                {
                    excelPack.Load(streamFile);
                }

                //Lets Deal with first worksheet.(You may iterate here if dealing with multiple sheets)
                var ws = excelPack.Workbook.Worksheets[sheet];

                //Get all details as DataTable -because Datatable make life easy :)
                DataTable excelasTable = new DataTable();
                foreach (var firstRowCell in ws.Cells[1, 1, 1, ws.Dimension.End.Column])
                {
                    //Get colummn details
                    if (!string.IsNullOrEmpty(firstRowCell.Text))
                    {
                        string firstColumn = string.Format("Column {0}", firstRowCell.Start.Column);
                        excelasTable.Columns.Add(hasHeader ? firstRowCell.Text : firstColumn);
                    }
                }
                var startRow = hasHeader ? 2 : 1;
                //Get row details
                for (int rowNum = startRow; rowNum <= ws.Dimension.End.Row; rowNum++)
                {
                    var wsRow = ws.Cells[rowNum, 1, rowNum, excelasTable.Columns.Count];
                    DataRow row = excelasTable.Rows.Add();
                    foreach (var cell in wsRow)
                    {
                        row[cell.Start.Column - 1] = cell.Text;
                    }
                }
                //Get everything as generics and let end user decides on casting to required type
                var generatedType = JsonConvert.DeserializeObject<T>(JsonConvert.SerializeObject(excelasTable));
                return (T)Convert.ChangeType(generatedType, typeof(T));
            }
        }

        public static string CheckSession()
        {
            string userId = Convert.ToString(HttpContext.Current.Session["UserID"]);
            string result = string.Empty;
            if (string.IsNullOrEmpty(userId))
            {
                int dbtimeout = int.Parse(ConfigurationSettings.AppSettings["dbTimeOut"]);
                string connstring = decryptConnStr(ConfigurationSettings.AppSettings["connString"]);
                DbConnection connESecurity = new DbConnection(connstring);
                connESecurity.ExecReader("select top 1 LOGIN_SCR from dbo.RFMODULE", null, 600);
                if (connESecurity.hasRow())
                {
                    result = connESecurity.GetFieldValue(0);
                }
            }
            return result;
        }

        public static string decryptConnStr(string encryptedConnStr)
        {
            string newValue = "";
            int num1 = encryptedConnStr.IndexOf("pwd=");
            int num2 = encryptedConnStr.IndexOf(";", num1 + 4);
            string oldValue = encryptedConnStr.Substring(num1 + 4, num2 - num1 - 4);
            for (int index = 2; index < oldValue.Length; ++index)
            {
                char c = (char)((uint)oldValue[index] - 2U);
                newValue += new string(c, 1);
            }
            return encryptedConnStr.Replace(oldValue, newValue);
        }

        public static string GetFieldValueDatatable(DataTable dt, int field, int row)
        {
            string result = null;
            if (dt.Rows.Count >= row + 1 && dt.Columns.Count >= field)
            {
                result = dt.Rows[row][field].ToString().Trim();
            }

            return result;
        }

        public static string GetFieldValueDatatable(DataTable dt, string field, int row)
        {
            string result = null;
            if (dt.Rows.Count >= row + 1 && dt.Columns.Contains(field))
            {
                result = dt.Rows[row][field].ToString().Trim();
            }

            return result;
        }
    }
}