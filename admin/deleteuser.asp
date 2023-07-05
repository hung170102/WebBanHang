<!--#include file="./connect.asp"-->
<%
    id = Request.QueryString("id")

   
    Set cmdPrep = Server.CreateObject("ADODB.Command")
    connDB.Open()
    cmdPrep.ActiveConnection = connDB
    cmdPrep.CommandType = 1
    cmdPrep.CommandText = "DELETE FROM Khachhang1 WHERE MAKH=?"
    cmdPrep.parameters.Append cmdPrep.createParameter("MAKH",3,1, ,id)

    cmdPrep.execute
    connDB.Close()

    Session("Success") = "Deleted"

    Response.Redirect("user.asp")
%>