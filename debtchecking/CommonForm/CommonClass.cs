using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DMS.Tools;
using System.Configuration;
using System.Data;

namespace DebtChecking.CommonForm
{
    public class CommonClass
    {
        public DbConnection conn;
        public int dbtimeout;

        public CommonClass()
        {
            try
            {
                dbtimeout = int.Parse(ConfigurationSettings.AppSettings["DbTimeOut"].ToString());
                conn = new DbConnection(authenticate.decryptConnStr(ConfigurationSettings.AppSettings["connStringModule"]));
            }
            catch (Exception ex)
            {
                dbtimeout = 600;
            }
        }

        public void InsertAuditTrail(string tableName, string status, string userId, DataTable dtBefore, DataTable dtAfter)
        {
            if (string.IsNullOrEmpty(status))
            {
                int totalBefore = dtBefore.Rows.Count;
                int totalAfter = dtAfter.Rows.Count;
                if (totalBefore == 0)
                {
                    status = "Insert";
                }
                else if (totalBefore > 0 && totalAfter == 0)
                {
                    status = "Delete";
                }
                else
                {
                    status = "Update";
                }
            }
            //parent
            string auditID = Guid.NewGuid().ToString();
            string sql = "INSERT INTO AuditTrail(AuditTrailId,TableName,Status,CreatedDate,CreatedBy) " +
                         "VALUES (@1,@2,@3,GETDATE(),@4)";
            object[] par = new object[] { auditID, tableName, status, userId };
            conn.ExecNonQuery(sql, par, dbtimeout);

            //child
            int totalColumn = dtBefore.Columns.Count;
            string sqlChild = "";

            for (int i = 0; i < totalColumn; i++)
            {
                string columnName = dtBefore.Columns[i].ColumnName;
                string before = CustomFunction.GetFieldValueDatatable(dtBefore, i, 0);
                string after = CustomFunction.GetFieldValueDatatable(dtAfter, i, 0);
                sqlChild += " INSERT INTO AuditTrailDetail(AuditTrailDetailId,AuditTrailId,FieldName,FieldValue,FieldValueBefore) " +
                                 "VALUES (NEWID(),'" + auditID + "','" + columnName + "','" + before + "','" + after + "'); \n";

            }
            conn.ExecNonQuery(sqlChild, null, dbtimeout);

        }

    }
}