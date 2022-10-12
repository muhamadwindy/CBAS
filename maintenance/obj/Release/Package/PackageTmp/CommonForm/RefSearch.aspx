<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RefSearch.aspx.cs" Inherits="MikroMnt.CommonForm.RefSearch" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Refference Search Page</title>
	<link href="../include/style.css" type="text/css" rel="stylesheet" />
	<script language="javascript" type="text/javascript">
	    var picked = false;
		function pilih(ctrlID,ctrlDesc,mypreendcallback)
		{
		    if (mypreendcallback != null)
		        eval(mypreendcallback);
		    
		    picked = true;
			if (document.form1.LST_RESULT.value != '')
			{
				eval('opener.document.form1.' + ctrlID + '.value = document.form1.LST_RESULT.value');
				eval('opener.document.form1.' + ctrlDesc + '.value = document.form1.LST_RESULT.options[document.form1.LST_RESULT.selectedIndex].text.replace(document.form1.LST_RESULT.value + " - ", "")');
			}
			else
			{
				eval('opener.document.form1.' + ctrlID + '.value = ""');
				eval('opener.document.form1.' + ctrlDesc + '.value = ""');
			}
		    
			window.close();
		}
	</script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
		<table class="Box1" width="450">
			<tr>
				<td valign="top">
					<table class="table table-sm table-responsive">
						<tr>
							<td id="tdcode" width="70" runat="server">Kode</td>
							<td>:</td>
							<td><asp:textbox id="TXT_CODE" runat="server"></asp:textbox></td>
						</tr>
						<tr>
							<td id="tddesc" runat="server">Deskripsi</td>
							<td>:</td>
							<td><asp:textbox id="TXT_DESC" runat="server" Width="100%"></asp:textbox></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td>
							    <asp:button id="BTN_SEARCH" runat="server" Text="Cari" Width="80px" onclick="BTN_SEARCH_Click"></asp:button>
							</td>
						</tr>
						<tr>
							<td>Hasil Pencarian</td>
							<td></td>
							<td><asp:listbox id="LST_RESULT" runat="server" Width="100%" EnableViewState="False" Rows="10"></asp:listbox></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr class="F1">
							<td colspan="3">
								<input class="Bt1" id="ok" type="button" value="OK" name="ok" runat="server" style="WIDTH: 80px" />
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	
    </div>
    </form>
</body>
</html>
