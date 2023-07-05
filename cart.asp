<!--#include file="database/connect.asp"-->
<%
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
	connDB.Open()
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

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>MultiShop - Online Shop Website Template</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="Free HTML Templates" name="keywords">
    <meta content="Free HTML Templates" name="description">

    <!-- Favicon -->
    <link href="img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">  

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="lib/animate/animate.min.css" rel="stylesheet">
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="css/style.css" rel="stylesheet">
</head>

<body>
    

    


    <!-- Breadcrumb Start -->
    <div class="container-fluid">
        <div class="row px-xl-5">
            <div class="col-12">
                <nav class="breadcrumb bg-light mb-30">
                    <a class="breadcrumb-item text-dark" href="#">Home</a>
                    <a class="breadcrumb-item text-dark" href="#">Shop</a>
                    <span class="breadcrumb-item active">Shopping Cart</span>
                </nav>
            </div>
        </div>
    </div>
    <!-- Breadcrumb End -->


    <!-- Cart Start -->
    <div class="container-fluid">
        <div class="row px-xl-5">
            <div class="col-lg-8 table-responsive mb-5">
                <table class="table table-light table-borderless table-hover text-center mb-0">
                    <thead class="thead-dark">
                        <tr>
                            <th>Products</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Total</th>
                            <th>Remove</th>
                        </tr>
                    </thead>
                    <tbody class="align-middle">
                        <%
                              If (totalProduct<>0) Then
                              do while not rs.EOF
                              %>
                        <tr>
                            <td class="align-middle"><img src="admin<%=rs("img")%>" alt="" style="width: 50px;"> <%=rs("TENSP")%></td>
                            <td class="align-middle"><%=rs("GIABANSP")%></td>
                            <td class="align-middle">
                                <div class="input-group quantity mx-auto" style="width: 100px;">
                                    
                                    <input type="text" class="form-control form-control-sm bg-secondary border-0 text-center" value="<%
                                    Dim masp
                                    masp  = CStr(rs("MASP"))
                                    Response.Write(mycarts.Item(masp))                                     
                                    %>">
                                    
                                </div>
                            </td>
                            <td class="align-middle"><%=(mycarts.Item(masp) * rs("GIABANSP"))%></td>
                            <td class="align-middle">
                                <a class="btn btn-sm btn-danger" href="removecart.asp?id=<%=rs("MASP")%>" ><i class="fa fa-times"></i></a>
                            </td>
                        </tr>
                        <%
                        rs.MoveNext
                        loop
          'phuc vu cho viec update subtotal
                        rs.MoveFirst
                        End If
                  %>
                    </tbody>
                </table>
            </div>
            <div class="col-lg-4">
                <form class="mb-30" action="">
                    <div class="input-group">
                        <input type="text" class="form-control border-0 p-4" placeholder="Coupon Code">
                        <div class="input-group-append">
                            <button class="btn btn-primary">Apply Coupon</button>
                        </div>
                    </div>
                </form>
                <h5 class="section-title position-relative text-uppercase mb-3"><span class="bg-secondary pr-3">Cart Summary</span></h5>
                <div class="bg-light p-30 mb-5">
                    <div class="pt-2">
                        <div class="d-flex justify-content-between mt-2">
                            <h5>Total</h5>
                            <h5>$<%=subtotal%></h5>
                        </div>
                        <a href="checkout.asp" class="btn btn-block btn-primary font-weight-bold my-3 py-3">Proceed To Checkout</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Cart End -->


 <!-- #include file="inc/footer.asp" -->


    <!-- Back to Top -->
    <a href="#" class="btn btn-primary back-to-top"><i class="fa fa-angle-double-up"></i></a>


    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
    <script src="lib/easing/easing.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Contact Javascript File -->
    <script src="mail/jqBootstrapValidation.min.js"></script>
    <script src="mail/contact.js"></script>

    <!-- Template Javascript -->
    <script src="js/main.js"></script>
</body>

</html>