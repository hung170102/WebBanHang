
<%
    Dim email, password
    email = Request.Form("email")
    password = Request.Form("password")
   
If email <> "" And password <> "" Then
    ' Kiểm tra tên đăng nhập và mật khẩu của người dùng trong cơ sở dữ liệu
    Dim connDB
	Set connDB = Server.CreateObject("ADODB.Connection")
    connDB.ConnectionString="Provider=SQLOLEDB.1;Data Source=DESKTOP-ETE275G\HUNGTV;Database=webbandienthoai;User Id=sa;Password=hung2002"
    connDB.Open
    Dim strSQL
	strSQL = "SELECT * FROM Taikhoan WHERE [email]='" & email & "' AND [password]='" & password & "'"
    Dim rs
	Set rs = connDB.Execute(strSQL)
    If Not rs.EOF Then
    '     ' Nếu tên đăng nhập và mật khẩu hợp lệ, tạo một phiên làm việc (session) cho người dùng
         Session("email") = email
        If email = "hung" Then
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
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
        integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</head>
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        height: 100vh;
        width: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
        background: rgba(47, 13, 13, 0.422);
    }

    .form_login {
        width: 450px;
        height: auto;
        border-radius: 4px;
        background-color: #fff;
        padding: 10px;
    }

    .title {
        text-align: center;
        font-size: 20px;
        font-weight: 600;
        text-transform: uppercase;
        color: rgba(0, 0, 0, 0.47);
    }

    .heading {
        margin: 5px;
        font-size: 17px;
        color: black;
        font-weight: 500;
    }

    input[type="password"],
    input#email {
        width: 100%;
        border: none;
        background: transparent;
        outline: none;
        font-size: 15px;
        font-weight: 500;
        background-color: #12c986;
        border-radius: 5px;
        color: #fff;
        padding: 10px;
    }

    input[type="submit"] {
        margin-top: 10px;
        padding: 5px;
    }

    .Login {
        display: flex;
        align-items: center;
        justify-content: center;
    }
</style>

<body>
    <form action="login.asp" method="post" class="form_login">
        <div class="title">
            <span>Đăng nhập</span>
        </div>
        <div class="heading">
            <label for="email">Nhập Username : </label>
        </div>
        <div><input type="text" placeholder="Username...." name="email" id="email"></div>
        <div class="heading">
            <label for="password">Nhập Password : </label>
        </div>
        <div><input type="password" placeholder="Password...." name="password" id="password"></div>
        <div class="Login"><input type="submit" value="Đăng nhập"></div>


    </form>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
        integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
        crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
        crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"></script>
</body>

</html>