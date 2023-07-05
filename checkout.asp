

<!--#include file="database/connect.asp"-->
<%

	connDB.Open()
Dim ten, masp, tensp, price, mota
If Session("TENDN") <> "" Then
    ten = Session("TENDN")
End If

Dim sqlkk
sqlkk = "SELECT * FROM Khachhang1 WHERE TENDN='" & ten & "'"
Set res = connDB.Execute(sqlkk)

If Not res.EOF Then
    HOTENKH = res("HOTENKH")
    SDT = res("SDT")
   
End If
'lay ve danh sach product theo id trong my cart
Dim idList, mycarts, totalProduct, subtotal, statusViews, statusButtons, rs
If (NOT IsEmpty(Session("mycarts"))) Then
' true
	Set mycarts = Session("mycarts")
	idList = ""
	totalProduct=mycarts.Count    
    
	For Each List In mycarts.Keys
		If (idList="") Then
' true
			idList = List
		Else
			idList = idList & "," & List
		End if                               
	Next
	Dim sqlString
	sqlString = "Select * from sanpham5 where MASP IN  ("& (idList) &")"
	
	set rs = connDB.execute(sqlString)
	calSubtotal(rs)
  Else
    'Session empty
    totalProduct=0
  End If
  Sub calSubtotal(rs)
' Do Something...
		subtotal = 0
		do while not rs.EOF
			subtotal = subtotal + Clng(mycarts.Item(CStr(rs("MASP")))) * CDbl(CStr(rs("GIABANSP")))
			rs.MoveNext
		loop
		rs.MoveFirst
	End Sub
  Sub defineItems(v)
    If (v>1) Then
      Response.Write(" Items")
    Else
      Response.Write(" Item")
    End If
  End Sub
%>
<!-- #include file="inc/header.asp" -->
<style>
    .pricer{
        display: flex;
        align-items: center;
        justify-content: space-between;
    }
</style>
<body>
   

    <!-- Breadcrumb Start -->
    <div class="container-fluid">
        <div class="row px-xl-5">
            <div class="col-12">
                <nav class="breadcrumb bg-light mb-30">
                    <a class="breadcrumb-item text-dark" href="#">Home</a>
                    <a class="breadcrumb-item text-dark" href="#">Shop</a>
                    <span class="breadcrumb-item active">Checkout</span>
                </nav>
            </div>
        </div>
    </div>
    <!-- Breadcrumb End -->


    <!-- Checkout Start -->
    <div class="container-fluid">
        <div class="row px-xl-5">
            <div class="col-lg-8">
                <h5 class="section-title position-relative text-uppercase mb-3"><span class="bg-secondary pr-3">Địa chỉ thanh toán</span></h5>
                <form action="order.asp" name="myForm" onsubmit="return validateForm()" method="post">
                    <div class="bg-light p-30 mb-5">
                        
                        <div class="row">
                            <div class="col-md-6 form-group">
                                <label>Họ và Tên</label>
                                <input class="form-control" value="<%=HOTENKH%>" name="ten" type="text"  >
                            </div>
                            
                            <div class="col-md-6 form-group">
                                <label>E-mail</label>
                                <input class="form-control" name="mail" type="text" placeholder="example@email.com">
                            </div>
                            <div class="col-md-6 form-group">
                                <label>Số điện thoại</label>
                                <input class="form-control" value="<%=SDT%>" name="sdt" type="text" placeholder="+123 456 789">
                            </div>                                                       
                            <div class="col-md-6 form-group">
                                <label>Địa chỉ</label>
                                <input class="form-control" name="diachi" type="text" placeholder="">
                            </div>
                            <div class="col-md-6 form-group">
                                <label>Ghi chú</label>
                                <input class="form-control" name="ghichu" type="text" >
                            </div>
                            
                        </div>
                    </div>
                    <button type="submit" class="btn btn-block btn-primary font-weight-bold py-3">Thanh toán</button>
                </form>
                <div class="collapse mb-5" id="shipping-address">
                    <h5 class="section-title position-relative text-uppercase mb-3"><span class="bg-secondary pr-3">Shipping Address</span></h5>
                    <div class="bg-light p-30">
                        <div class="row">
                            <div class="col-md-6 form-group">
                                <label>First Name</label>
                                <input class="form-control" type="text" placeholder="John">
                            </div> 
                            <div class="col-md-6 form-group">
                                <label>E-mail</label>
                                <input class="form-control" type="text" placeholder="example@email.com">
                            </div>
                            <div class="col-md-6 form-group">
                                <label>Mobile No</label>
                                <input class="form-control" type="text" placeholder="+123 456 789">
                            </div>
                            <div class="col-md-6 form-group">
                                <label>Address Line 1</label>
                                <input class="form-control" type="text" placeholder="123 Street">
                            </div>
                            <div class="col-md-6 form-group">
                                <label>Address Line 2</label>
                                <input class="form-control" type="text" placeholder="123 Street">
                            </div>
                            <div class="col-md-6 form-group">
                                <label>Country</label>
                                <select class="custom-select">
                                    <option selected>United States</option>
                                    <option>Afghanistan</option>
                                    <option>Albania</option>
                                    <option>Algeria</option>
                                </select>
                            </div>
                            <div class="col-md-6 form-group">
                                <label>City</label>
                                <input class="form-control" type="text" placeholder="New York">
                            </div>
                            <div class="col-md-6 form-group">
                                <label>State</label>
                                <input class="form-control" type="text" placeholder="New York">
                            </div>
                            <div class="col-md-6 form-group">
                                <label>ZIP Code</label>
                                <input class="form-control" type="text" placeholder="123">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <h5 class="section-title position-relative text-uppercase mb-3"><span class="bg-secondary pr-3">Order Total</span></h5>
                <div class="bg-light p-30 mb-5">
                    <div class="border-bottom">
                        <div class="pricer">
                            <h6 class="mb-3">Sản Phẩm</h6>
                            <h6 class="mb-3">Giá tiền</h6>
                        </div>
                       
                        <%
                        If (totalProduct<>0) Then
                        do while not rs.EOF
                        %>
                        <div class="d-flex justify-content-between">
                            <p><%=rs("TENSP")%><strong class="product-quantity">  x <%
                                Dim ik
                                ik  = CStr(rs("MASP"))
                                Response.Write(mycarts.Item(ik))  %></strong></p>
                            <p><%=rs("GIABANSP") * mycarts.Item(ik)%></p>
                        </div>
                        <%
                        rs.MoveNext
                        loop
          'phuc vu cho viec update subtotal
                        rs.MoveFirst
                        End If
                  %>
                        <!-- <div class="d-flex justify-content-between">
                            <p>Product Name 2</p>
                            <p>$150</p>
                        </div>
                        <div class="d-flex justify-content-between">
                            <p>Product Name 3</p>
                            <p>$150</p>
                        </div> -->
                    </div>
                    <div class="border-bottom pt-3 pb-2">
                        <div class="d-flex justify-content-between mb-3">
                            <h6>Subtotal</h6>
                            <h6>$150</h6>
                        </div>
                        <div class="d-flex justify-content-between">
                            <h6 class="font-weight-medium">Phí giao hàng</h6>
                            <h6 class="font-weight-medium">$10</h6>
                        </div>
                    </div>
                    <div class="pt-2">
                        <div class="d-flex justify-content-between mt-2">
                            <h5>Tông tiền</h5>
                            <h5><%=subtotal%></h5>
                        </div>
                    </div>
                </div>
                <div class="mb-5">
                    <h5 class="section-title position-relative text-uppercase mb-3"><span class="bg-secondary pr-3">Phương Thức Thanh Toán</span></h5>
                    <div class="bg-light p-30">
                        <div class="form-group">
                            <div class="custom-control custom-radio">
                                <input type="radio" class="custom-control-input" name="payment" id="paypal">
                                <label class="custom-control-label" for="paypal">Paypal</label>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="custom-control custom-radio">
                                <input type="radio" class="custom-control-input" name="payment" id="directcheck" checked>
                                <label class="custom-control-label" for="directcheck">Thanh toán trực tiếp</label>
                            </div>
                        </div>
                        <div class="form-group mb-4">
                            <div class="custom-control custom-radio">
                                <input type="radio" class="custom-control-input" name="payment" id="banktransfer">
                                <label class="custom-control-label" for="banktransfer">Thanh toán</label>
                            </div>
                        </div>
                       
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Checkout End -->
<script>
    function validateEmail(email) {
  var regex = /^[a-zA-Z]{1,4}\d{1,5}@gmail\.com$/;
  if (regex.test(email)) {
    return true; // Email hợp lệ
  } else {
    return false; // Email không hợp lệ
  }
}
function validatePhone(phone) {
  var regex = /^(08|03|09)\d{8}$/;
  if (regex.test(phone)) {
    return true; // Số điện thoại hợp lệ
  } else {
    return false; // Số điện thoại không hợp lệ
  }
}
function validateForm() {
  var name = document.forms["myForm"]["ten"].value;
  var address = document.forms["myForm"]["diachi"].value;
  var email = document.forms["myForm"]["mail"].value;
  var phone = document.forms["myForm"]["sdt"].value;
  if (name == "") {
    alert("Vui lòng nhập họ và tên.");
    return false;
  }
  
  if (address == "") {
    alert("Vui lòng nhập địa chỉ.");
    return false;
  }
  
  if (email == "") {
    alert("Vui lòng nhập email.");
    return false;
  }else if (!validateEmail(email)) {
    alert("Email không hợp lệ. Email phải bắt đầu bằng tên đến 4 chữ số và đuôi là @gmail.com");
    return false;
  }
  
  if (phone == "") {
    alert("Vui lòng nhập số điện thoại.");
    return false;
  }else if (!validatePhone(phone)) {
    alert("Số điện thoại không hợp lệ. Số điện thoại phải có 12 chữ số và bắt đầu bằng 08, 03 hoặc 09");
    return false;
  }
  
  return true;
}

</script>
<!-- #include file="inc/footer.asp" -->
    


    