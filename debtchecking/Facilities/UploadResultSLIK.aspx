<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="UploadResultSLIK.aspx.cs"
    Inherits="DebtChecking.Facilities.UploadResultSLIK" %>

<%@ Register TagPrefix="dx" Namespace="DevExpress.Web" Assembly="DevExpress.Web.v20.2, Version=20.2, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <Template:Admin ID="templ" runat="server" />
    <title></title>
    <script>
        function cekUploadFile(e) {
            Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(BeginRequestHandler);
            function BeginRequestHandler(sender, args) { var oControl = args.get_postBackElement(); oControl.disabled = true; }
        }
    </script>
</head>
<body onload="$('#<%=btn_upload.ClientID %>').removeAttr('disabled');" class="text-sm">
    <div class="container-fluid">
        <form id="form1" runat="server">
            <div class="card card-primary card-outline">
                <div class="card-header">
                    <div class="row">
                        <div class="col-sm-6">
                            <h4 class="card-title">Request SLIK Via Upload Excel File</h4>
                        </div>
                        <div class="col-sm-6 text-right">
                            <asp:LinkButton ID="linkDownloadTemplate" runat="server" OnClick="linkDownloadTemplate_Click">Download Template</asp:LinkButton>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="form-group">
                        <label for="exampleFormControlFile1">File Upload</label>
                        <input type="file" class="form-control-file" id="fileUploadExcel" runat="server" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" />
                    </div>
                </div>
                <div class="card-footer">
                    <asp:Button class="btn btn-sm btn-primary" Text="Upload" ID="btn_upload" runat="server" OnClick="btn_upload_Click" OnClientClick="javascript: return cekUploadFile();" />
                </div>
            </div>
        </form>
    </div>
</body>
</html>