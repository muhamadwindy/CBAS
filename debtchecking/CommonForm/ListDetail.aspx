<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ListDetail.aspx.cs" Inherits="DebtChecking.List.ListDetail" %>

<%@ Register Src="~/CommonForm/UC_ListDetail.ascx" TagName="UC_ListDetail" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ListDetail Page</title>
    <Template:Admin runat="server" ID="Template" />
</head>
<body class="text-sm">
    <div class="container-fluid">
        <form id="form1" runat="server" enctype="multipart/form-data">
            <uc1:UC_ListDetail ID="ld" runat="server" />
        </form>
    </div>
</body>
</html>