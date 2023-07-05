
<!--#include file="connect.asp"-->

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
        cmdPrep.CommandText = "SELECT * FROM Khachhang1 WHERE MAKH=?"
        cmdPrep.Parameters(0) = id
        Set Result = cmdPrep.execute 

        If not Result.EOF then
           name=Result("HOTENKH")
           tendn=Result("TENDN")
           mk=Result("MATKHAU")
           sdt=Result("SDT")
        End If

        ' Set Result = Nothing
        Result.Close()
    End If
Else
    id = Request.QueryString("id")
    name=Request.Form("name")
    sdt=Request.Form("sdt")
    mk=Request.Form("mk")
    tendn=Request.Form("tendn")
    Response.Write(mk)
    if (isnull(id) OR trim(id) = "") then id = 0 end if

    if (cint(id) = 0) then
        if (NOT isnull(name) and name <> "") then
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.Prepared = True
            cmdPrep.CommandText = "insert into Khachhang1(HOTENKH,TENDN,MATKHAU,SDT) values(?,?,?,?)"
            cmdPrep.parameters.Append cmdPrep.createParameter("name",202,1,255,name)
            cmdPrep.parameters.Append cmdPrep.createParameter("tendn",202,1,30,tendn)
            cmdPrep.parameters.Append cmdPrep.createParameter("mk",202,1,30,mk)
            cmdPrep.parameters.Append cmdPrep.createParameter("sdt",202,1,15,sdt)
            cmdPrep.execute()
            Session("Success") = "Thêm người dùng thành công!"
            Response.redirect("user.asp") 
        else
            Session("Error") = "You have to input enough info"
        end if
    else
        if (NOT isnull(name) and name <> "" and NOT isnull(tendn) and tendn <> "") then
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.Prepared = True
            cmdPrep.CommandText = "UPDATE Khachhang1 SET HOTENKH=?,TENDN=?,MATKHAU=?,SDT=? WHERE MAKH=?"
            cmdPrep.parameters.Append cmdPrep.createParameter("name",202,1,255,name)
            cmdPrep.parameters.Append cmdPrep.createParameter("tendn",202,1,30,tendn)
            cmdPrep.parameters.Append cmdPrep.createParameter("mk",202,1,30,mk)
            cmdPrep.parameters.Append cmdPrep.createParameter("sdt",202,1,15,sdt)
            cmdPrep.parameters.Append cmdPrep.createParameter("id",3,1, ,id)
            cmdPrep.execute
            Session("Success") = "Sửa người dùng thành công!"
            Response.redirect("user.asp")
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
<body>
      
    <div class="container">
        <form method="post" action="#">
            <div class="mb-3">
                <label for="name" class="form-label">MÃ KHÁCH HÀNG</label>
                <input type="text" class="form-control" id="id" name="id" value="<%=id%>">
            </div>
            <div class="mb-3">
                <label for="name" class="form-label">HỌ TÊN</label>
                <input type="text" class="form-control" id="name" name="name" value="<%=name%>">
            </div>
            <div class="mb-3">
                <label for="made" class="form-label"> TÊN ĐĂNG NHẬP</label>
                <input type="text" class="form-control"  name="tendn" value="<%=tendn%>">
            </div> 
            <div class="mb-3">
                <label for="made" class="form-label">MẬT KHẨU</label>
                <input type="password" class="form-control"  name="mk" value="<%=mk%>">
            </div> 
            <div class="mb-3">
                <label for="price" class="form-label">SỐ ĐIỆN THOẠI</label>
                <input type="text" class="form-control"  name="sdt" value="<%=sdt%>">
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
            <a href="user.asp" class="btn btn-info">Cancel</a>           
        </form>
   
       </div>
        </div>
      </div>
    </div>
  </div>
</div>
<script>
function getData() {
  var inputValue = document.getElementById("").value;
  var erro_masp=document.getElementById("masp_erro");
  erro_masp.textContent ="";
  if(inputValue==""){
      erro_masp.textContent ="Bạn chưa nhập mã sản phẩm !"
      return false;
    }
  return true;
}
</script>
<!--#include file="footer.asp"-->