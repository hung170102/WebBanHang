<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001" %>
<% 
    Dim connDB 
    set connDB=Server.CreateObject("ADODB.Connection") 
    Dim strConnection
    strConnection="Provider=SQLOLEDB.1;Data Source=DESKTOP-ETE275G\HUNGTV;Database=webbandienthoai;User Id=sa;Password=hung2002"
    connDB.ConnectionString=strConnection 
%>