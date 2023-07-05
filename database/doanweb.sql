
use webbandienthoai
go

create table sanpham5(

	MASP INT PRIMARY KEY identity(1,1),

	TENSP NVARCHAR(255),

	MOTASP NVARCHAR(255),

	SOLUONGSP INT,

	GIABANSP nvarchar(15),

	PHIENBAN  NVARCHAR(255),
	img nvarchar(200)
)
drop table sanpham5
select * from sanpham5
ALTER TABLE sanpham5
ADD img nvarchar(200) ;


inser into sanpham1 values
select* from sanpham5
INSERT INTO sanpham5(TENSP,PHIENBAN,GIABANSP,MOTASP) VALUES(N'Iphone 14 promax',N'128gb',14.85,N'Khá là ok')

create table Khachhang1(

	MAKH INT PRIMARY KEY identity(1,1),

	HOTENKH NVARCHAR(255),

	TENDN NVARCHAR(30),

	MATKHAU NVARCHAR(30),

	SDT NVARCHAR(15)

) 
insert into Khachhang1(HOTENKH,TENDN,MATKHAU,SDT) values
INSERT INTO Khachhang1 VALUES (N'Trần Việt Hùng','hung','hungmk',0336546403)
select * from sanpham5
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY identity(1,1),
    Name nVARCHAR(100) NOT NULL,
    Email nVARCHAR(100) NOT NULL,
    Address nVARCHAR(200) NOT NULL,
    Note TEXT
)
SELECT * FROM sanpham5 WHERE MAKH=9
ALTER TABLE Customers	
ADD SDT nvarchar(100) ;

select * from Khachhang1
select * from ChiTietHoaDon
CREATE TABLE Orders1 (
    OrderID INT PRIMARY KEY identity(1,1),
    CustomerID INT,
    MASP INT,
    Quantity INT,
    ProductName nVARCHAR(100),
    Price float,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
)
create table ChiTietHoaDon(
MaSp int,
MaHD int,
Primary key(MaSp,MaHD),
SoLuong int,
 FOREIGN KEY (MaSp) REFERENCES sanpham5(MASP),
 FOREIGN KEY (MaHD) REFERENCES Orders(OrderID)
)