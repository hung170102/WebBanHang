<!--#include file="./connect.asp"-->
<!--#include file="./pure/upload.lib.asp"-->
<% 
Dim Form : Set Form = New ASPForm
Server.ScriptTimeout = 1440 ' Limite de 24 minutos de execu��o de c�digo, o upload deve acontecer dentro deste tempo ou ent�o ocorre erro de limite de tempo.
Const MaxFileSize = 10240000 ' Bytes. Aqui est� configurado o limite de 100 MB por upload (inclui todos os tamanhos de arquivos e conte�dos dos formul�rios).
If Form.State = 0 Then

	For each Key in Form.Texts.Keys
		Response.Write "Elemento: " & Key & " = " & Form.Texts.Item(Key) & "<br />"
	Next

	For each Field in Form.Files.Items
		' # Field.Filename : Nome do Arquivo que chegou.
		' # Field.ByteArray : Dados bin�rios do arquivo, �til para subir em blobstore (MySQL).
		Field.SaveAs Server.MapPath(".") & "\upload\" & Field.FileName
        Dim filename
        filename =Field.FileName
       
		Response.Write "File name: " & Field.FileName & " uploaded. <br />"
	Next
End If
%>
<%
  
    If (Request.ServerVariables("REQUEST_METHOD") = "GET") THEN        
        id = Request.QueryString("id")
        If (isnull(id) OR trim(id) = "") then 
            id=0 
        End if
        If (cint(id)<>0) Then
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            connDB.Open()
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.CommandText = "SELECT * FROM sanpham5 WHERE MASP=?"
            ' cmdPrep.parameters.Append cmdPrep.createParameter("MASP",3,1, ,id)
            cmdPrep.Parameters(0)=id
            Set Result = cmdPrep.execute 

            If not Result.EOF then
                name = Result("TENSP")
                made = Result("PHIENBAN")
                price = Result("GIABANSP")
                mota = Result("MOTASP")
                soluong = Result("SOLUONGSP")
            End If

            ' Set Result = Nothing
            Result.Close()
        End If
    Else
    dim id,name,soluong,made,price,mota
        id = Request.QueryString("id")
        name = Form.Texts.Item("fullname")
        soluong = Form.Texts.Item("soluong")
        made = Form.Texts.Item("pb")
        price = Form.Texts.Item("gia")
        mota = Form.Texts.Item("mota")
        dim imagesrc
    imagesrc = "/upload/"&filename
    Response.write(imagesrc)
        if (isnull (id) OR trim(id) = "") then id=0 end if

        if (cint(id)=0) then
            if (NOT isnull(name) and name<>"" and NOT isnull(made) and made<>"") then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                connDB.Open()
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "INSERT INTO sanpham5(TENSP,PHIENBAN,GIABANSP,MOTASP,img,SOLUONGSP) VALUES(?,?,?,?,?,?)"
                cmdPrep.parameters.Append cmdPrep.createParameter("name",202,1,255,name)
                cmdPrep.parameters.Append cmdPrep.createParameter("made",202,1,255,made)
                cmdPrep.parameters.Append cmdPrep.createParameter("price",202,1,15,price)
                cmdPrep.parameters.Append cmdPrep.createParameter("mota",202,1,255,mota)
                cmdPrep.parameters.Append cmdPrep.createParameter("img",202,1,200,imagesrc)
                cmdPrep.parameters.Append cmdPrep.createParameter("soluong",3,1, ,soluong)
                cmdPrep.execute
                Session("Success") = "Thêm sản phẩm thành công!"
                Response.redirect("cartegorylist.asp")
            else
                Session("Error") = "You have to input enough info"                
            end if
        else
            if (NOT isnull(name) and name<>"" and NOT isnull(made) and made<>"") then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                connDB.Open()
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "UPDATE sanpham5 SET TENSP=?,PHIENBAN=?,GIABANSP=?,MOTASP=?,img=?,SOLUONGSP=? WHERE MASP=?"
                cmdPrep.parameters.Append cmdPrep.createParameter("name",202,1,255,name)
                cmdPrep.parameters.Append cmdPrep.createParameter("made",202,1,255,made)
                cmdPrep.parameters.Append cmdPrep.createParameter("price",202,1,15,price)
                cmdPrep.parameters.Append cmdPrep.createParameter("mota",202,1,255,mota)
                cmdPrep.parameters.Append cmdPrep.createParameter("img",202,1,200,imagesrc)
                cmdPrep.parameters.Append cmdPrep.createParameter("soluong",3,1, ,soluong)
                cmdPrep.parameters.Append cmdPrep.createParameter("MASP",3,1, ,id)

                cmdPrep.execute
                Session("Success") = "Sửa sản phẩm thành công !"
                Response.redirect("cartegorylist.asp") 
            else
                Session("Error") = "You have to input enough info"
            end if
        end if
    End If    
%>

<!--#include file="./header.asp"-->
<!--#include file="./slider.asp"-->
    <body>
      
        <div class="container">
            <form method="post" enctype="multipart/form-data">
                <div class="mb-3">
                    <label for="name" class="form-label">Tên</label>
                    <input type="text" class="form-control" id="name" name="fullname" value="<%=name%>">
                </div>
                <div class="mb-3">
                    <label for="made" class="form-label">PHIÊN BẢN</label>
                    <input type="text" class="form-control" id="made" name="pb" value="<%=made%>">
                </div> 
                <div class="mb-3">
                    <label for="made" class="form-label">SỐ LƯỢNG</label>
                    <input type="text" class="form-control" id="soluong" name="soluong" value="<%=soluong%>">
                </div> 
                <div class="mb-3">
                    <label for="price" class="form-label">GIÁ BÁN</label>
                    <input type="text" class="form-control" id="price" name="gia" value="<%=price%>">
                </div> 
                <div class="mb-3">
                    <label for="mota" class="form-label">MÔ TẢ</label>
                    <input type="text" class="form-control" id="mota" name="mota" value="<%=mota%>">
                </div> 
                <div class="my-2">
                    <label for="brand" class="form-label">Image</label>
                      <div style="display:flex">
                          <input type="file" name="arquivo" multiple />
                      </div>
                </div>
                <button type="submit" class="btn btn-primary">
                    <%
                        if (id=0) then
                            Response.write("Add")
                        else
                            Response.write("Edit")
                        end if
                    %>
                </button>
                <a href="./cartegorylist.asp" class="btn btn-info">Cancel</a>           
            </form>
        </div>
            
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
   