<!--#include file="database/connect.asp"-->

<%
    
       
        name = Request.form("fullname")
        made = Request.form("tendn")
        sodt = Request.form("sdt")
        mk = Request.form("mk")
      

       
       
            if (NOT isnull(name) and name<>"" and NOT isnull(made) and made<>"") then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                connDB.Open()
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "INSERT INTO Khachhang1(HOTENKH,TENDN,SDT,MATKHAU) VALUES(?,?,?,?)"
                cmdPrep.parameters.Append cmdPrep.createParameter("name",202,1,255,name)
                cmdPrep.parameters.Append cmdPrep.createParameter("made",202,1,30,made)
                cmdPrep.parameters.Append cmdPrep.createParameter("sodt",202,1,15,sodt)
                cmdPrep.parameters.Append cmdPrep.createParameter("MK",202,1,30,mk)

                cmdPrep.execute
                Session("Success") = "New employee added!"
                Response.redirect("dangnhap.asp")
            else
                Session("Error") = "You have to input enough info"                
            end if
       
%>
<style>
  .mx-1 mx-md-4{
    margin-top: 15px;
  }
</style>
<!-- #include file="./inclogin/header.asp" -->
                      <p class="text-center h1 fw-bold mb-5 mx-1 mx-md-4 mt-4">Đăng kí</p>
      
                      <form class="mx-1 mx-md-4" method="post">
      
                        <div class="d-flex flex-row align-items-center mb-4">
                          <i class="fas fa-user fa-lg me-3 fa-fw"></i>
                          <div class="form-outline flex-fill mb-0">
                            <label class="form-label" for="name">Họ tên</label>
                            <input type="text" class="form-control" id="name" name="fullname"  />
                            
                          </div>
                        </div>
      
                        <div class="d-flex flex-row align-items-center mb-4">
                          <i class="fas fa-envelope fa-lg me-3 fa-fw"></i>
                          <div class="form-outline flex-fill mb-0">
                            <label class="form-label" for="made">Tên đăng nhập</label>
                            <input type="text" class="form-control" id="made" name="tendn"/>
                           
                          </div>
                        </div>
                        <div class="d-flex flex-row align-items-center mb-4">
                          <i class="fas fa-envelope fa-lg me-3 fa-fw"></i>
                          <div class="form-outline flex-fill mb-0">
                            <label class="form-label" for="sodt">Số điện thoại</label>
                            <input type="text" class="form-control" id="sodt" name="sdt"  />
                           
                          </div>
                        </div>
      
                        <div class="d-flex flex-row align-items-center mb-4">
                          <i class="fas fa-lock fa-lg me-3 fa-fw"></i>
                          <div class="form-outline flex-fill mb-0">
                            <label class="form-label" for="MK">Mật khẩu</label>
                            <input type="password" class="form-control" id="MK" name="mk"/>
                          </div>
                          </div>
                          <div class="form-check d-flex justify-content-center mb-5">
                            <label class="form-check-label" for="form2Example3">
                              Bạn đã có tài khoản <a href="./dangnhap.asp">Đăng nhập</a>
                            </label>
                          
                          </div>  
                          <div class="form-check d-flex justify-content-center mb-5">
                            <button type="submit" class="btn btn-primary btn-lg">Đăng kí</button>
                          
                          </div>  
                          

                        
                      </form>
                    </div>
                
<!-- #include file="./inclogin/foot.asp" -->