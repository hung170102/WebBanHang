
<%
    Dim TENDN, MATKHAU
    TENDN = Request.Form("TENDN")
    MATKHAU = Request.Form("MATKHAU")
   
If TENDN <> "" And MATKHAU <> "" Then
    ' Kiểm tra tên đăng nhập và mật khẩu của người dùng trong cơ sở dữ liệu
    Dim connDB
	Set connDB = Server.CreateObject("ADODB.Connection")
    connDB.ConnectionString="Provider=SQLOLEDB.1;Data Source=DESKTOP-ETE275G\HUNGTV;Database=webbandienthoai;User Id=sa;Password=hung2002"
    connDB.Open
    Dim strSQL
	strSQL = "SELECT * FROM Khachhang1 WHERE [TENDN]='" & TENDN & "' AND [MATKHAU]='" & MATKHAU & "'"
    Dim rs
	Set rs = connDB.Execute(strSQL)
    If Not rs.EOF Then
    '     ' Nếu tên đăng nhập và mật khẩu hợp lệ, tạo một phiên làm việc (session) cho người dùng
         Session("TENDN") = TENDN
        If TENDN = "hungmk" Then
    ' Nếu là admin, chuyển hướng người dùng vào trang Admin
           Response.Redirect("../admin/cartegorylist.asp")
        Else
             Response.Redirect("../index.asp")
        End if
        
       
     Else
         ' Nếu tên đăng nhập và mật khẩu không hợp lệ, hiển thị thông báo lỗi
         Response.Write("Invalid username or password.")
     End If
 connDB.Close
	 Set connDB = Nothing
End If

 %>

<!-- #include file="./inclogin/header.asp" -->

 <p class="text-center h1 fw-bold mb-5 mx-1 mx-md-4 mt-4">Đăng nhập</p>
  
   <form action="dangnhap.asp" method="post" class="form_login">
  
    <div class="d-flex flex-row align-items-center mb-4">
          <i class="fas fa-envelope fa-lg me-3 fa-fw"></i>
      <div class="form-outline flex-fill mb-0">
          <label class="form-label" for="TENDN">Tên đăng nhập</label>
          <input type="text" name="TENDN" id="TENDN" class="form-control" />
                       
      </div>
    </div>
  
    <div class="d-flex flex-row align-items-center mb-4">
          <i class="fas fa-lock fa-lg me-3 fa-fw"></i>
         <div class="form-outline flex-fill mb-0">
         <label class="form-label" for="MATKHAU">Mật khẩu</label>
          <input type="password" name="MATKHAU" id="MATKHAU" class="form-control" />
                        
          </div>
    </div>
     <div class="form-check d-flex justify-content-center mb-5">                 
          <label class="form-check-label" >Bạn chưa có tài khoản <a href="dangki.asp">Đăng kí</a></label>
     </div>
  <link rel="stylesheet" href="">
   <div class="d-flex justify-content-center mx-4 mb-3 mb-lg-4">
     <button type="submit" class="btn btn-primary btn-lg">Đăng nhập</button>
   </div>
   </form>
  
<!-- #include file="./inclogin/foot.asp" -->