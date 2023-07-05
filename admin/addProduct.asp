
<!--#include file="connect.asp"-->
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
   connDB.Open()
  If (Request.ServerVariables("REQUEST_METHOD") = "GET") THEN        
    id = Request.QueryString("id")
    If (isnull(id) OR trim(id) = "") Then 
        id = 0 
    End if
    If (cint(id) <> 0) Then
        Set cmdPrep = Server.CreateObject("ADODB.Command")
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType = 1
        cmdPrep.CommandText = "SELECT * FROM sanpham5 WHERE MASP=?"
        cmdPrep.Parameters(0) = id
        Set Result = cmdPrep.execute 

        If not Result.EOF then
            
            tensp = Result("TENSP")
            price = Result("GIABANSP")
            mota = Result("MOTASP")
            soluong = Result("SOLUONGSP")
            phienban = Result("PHIENBAN")
        End If

        ' Set Result = Nothing
        Result.Close()
    End If
Else
    dim TSP,MT,PRICE,soluong,phienban
    id = Request.QueryString("id")
    MSP = Form.Texts.Item("masp")
    TSP = Form.Texts.Item("tensp")
    MT = Form.Texts.Item("mota")
    PRICE = Form.Texts.Item("price")
    brandK = Form.Texts.Item("mancc")
    soluong = Form.Texts.Item("soluong")
    dim imagesrc
    imagesrc = "/upload/" & filename
    Response.write(imagesrc)
   
    if (isnull(id) OR trim(id) = "") then id = 0 end if

    if (cint(id) = 0) then
        if (NOT isnull(MSP) and MSP <> "") then
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.Prepared = True
            cmdPrep.CommandText = "insert into [tbl_SanPham](MaSp,TenSp,Mota,Price,Brand,soluong,Img) values(?,?,?,?,?,?,?)"
            cmdPrep.parameters.Append cmdPrep.createParameter("masp",3,1,,MSP)
                cmdPrep.parameters.Append cmdPrep.createParameter("TenSp",202,1,100,TSP)
                cmdPrep.parameters.Append cmdPrep.createParameter("mota",202,1,255,MT)
cmdPrep.parameters.Append cmdPrep.createParameter("price",5,1,,PRICE)
                cmdPrep.parameters.Append cmdPrep.createParameter("bandk",202,1,10,brandK)
                cmdPrep.parameters.Append cmdPrep.createParameter("soluong",3,1,,soluong)
                cmdPrep.parameters.Append cmdPrep.createParameter("img",202,1,100,imagesrc)
            cmdPrep.execute
            Session("Success") = "New product was added!"
            Response.redirect("index.asp") 
        else
            Session("Error") = "You have to input enough info"
        end if
    else
        if (NOT isnull(MSP) and MSP <> "" and NOT isnull(TSP) and TSP <> "") then
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.Prepared = True
            cmdPrep.CommandText = "UPDATE tbl_SanPham SET MaSp=?,TenSp=?,Mota=?,Price=?,Brand=?,soluong=?,Img=? WHERE id=?"
             cmdPrep.parameters.Append cmdPrep.createParameter("masp",3,1,,MSP)
                cmdPrep.parameters.Append cmdPrep.createParameter("TenSp",202,1,100,TSP)
                cmdPrep.parameters.Append cmdPrep.createParameter("mota",202,1,255,MT)
                cmdPrep.parameters.Append cmdPrep.createParameter("price",5,1,,PRICE)
                cmdPrep.parameters.Append cmdPrep.createParameter("bandk",202,1,10,brandK)
                cmdPrep.parameters.Append cmdPrep.createParameter("soluong",3,1,,soluong)
                cmdPrep.parameters.Append cmdPrep.createParameter("img",202,1,100,imagesrc)
            cmdPrep.parameters.Append cmdPrep.createParameter("id",3,1, ,id)
            cmdPrep.execute
            Session("Success") = "Sửa sản phẩm thành công!"
            Response.redirect("index.asp")
        end if
    end if
end if
 
%>
<style>
    button#myuploaderButton {
    border: navajowhite;
    padding: 10px 20px;
    border-radius: 10px;
    background: #ccc;
   
}
.algin{
    display: flex;
    align-items: center;
    justify-content: center;
}
.erro{
        font-size: 15px;
        color: red;
        text-align: center;
    }
</style>
<!--#include file="header.asp"-->
<!--#include file="slider.asp"-->
<div id="content" class="container-fluid">
    <div class="container">
    <div class="row my-5">
      <div class="col-lg-12">
        <div class="card shadow">
          <div class="card-header bg-danger d-flex justify-content-between align-items-center">
            <h3 class="text-light"><%
                If(cint(id)=0)then
                 Response.write("Thêm mới sản phẩm")
                  else
                  Response.write("Sửa sản phẩm")
                end if            
            %></h3>
          </div>
          <div class="card-body" id="show_all_employees">
          
      <form  method="post" enctype="multipart/form-data">
        <div class="modal-body p-4 bg-light">
          
            <div class="col-lg">
              <label for="lname">Tên sản phẩm</label>
              <input type="text" value="<%=tensp%>" name="tensp" class="form-control" placeholder="Tên sản phẩm" >
            </div>
          </div>
          <div class="my-2">
            <label for="email">Mô tả sản phẩm</label>
            <input type="text" value="<%=mota%>" name="mota" class="form-control" placeholder="Mô tả sản phẩm" >
          </div>
          <div class="my-2">
            <label for="phone">Giá tiền</label>
            <input type="text" value="<%=price%>" name="price" class="form-control" placeholder="Giá tiền" >
          </div>
          <div class="my-2">
            <label for="phone">Số lượng sản phẩm :</label>
            <input type="text" value="<%=soluong%>" name="soluong" class="form-control" placeholder="Số lượng sản phẩm" >
          </div>
          <div class="my-2">
                  <label for="brand" class="form-label">Image</label>
                    <div style="display:flex">
                        <input type="file" name="arquivo" multiple />
                    </div>
          </div>
        </div>
        <div class="modal-footer">
        <% 
             if(cint(id)<>0) then
             %>
               <a class="btn btn-primary" href="list-product.asp">Close</a>
             <%
             end if
          %>
          <button type="submit" onclick="return getData()" id="add_employee_btn" class="btn btn-primary">
                <%
                    If(cint(id)=0)then
                 Response.write("Thêm mới sản phẩm")
                  else
                  Response.write("Save")
                end if   
                %>
          </button>
          
        </div>
      </form>
       </div>
        </div>
      </div>
    </div>
  </div>
</div>
<script>

</script>
<!--#include file="footer.asp"-->