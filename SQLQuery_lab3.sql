/* 1.	Tạo CSDL tên MarksMS*/
CREATE DATABASE MarkMS;
USE MarkMS;

/*2.	Tạo bảng có tên SINH_VIEN, chi tiết theo bảng sau:
Bảng: SINH_VIEN
Tên  trường	Kiểu dữ liệu	Mô tả
MaSV	Char(10)	Khóa chính
HoLot	Nvarchar(20)	NOT NULL
Ten	Nvarchar(10)	NOT NULL
CMND	Varchar(12)	Chỉ cho phép nhập kiểu số, số CMND không được trùng nhau
Ngaysinh	Datetime	Ngày sinh phải lớn hơn ngày hiện tại
Id_qquan	Int	Khóa ngoại, tham chiếu đến bảng QUE_QUAN
Sodienthoai	Varchar(12)	Chỉ cho phép nhập kiểu số, NOT NULL, Sodienthoai không được trùng nhau
Malop	Char(10)	Khóa ngoại, tham chiếu đến bảng LOP_HOC*/

CREATE TABLE SINH_VIEN 
( 
 MaSV Char(10) NOT NULL PRIMARY KEY,
 HoLot Nvarchar(20) NOT NULL,
 Ten Nvarchar(10) NOT NULL,
 CMND Varchar(12) UNIQUE CHECK(CMND LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
 Ngaysinh Datetime CHECK( Ngaysinh > GETDATE()),
 Id_qquan Int REFERENCES QUE_QUAN (Id_qquan),
 Sodienthoai Varchar(12) NOT NULL UNIQUE CHECK(Sodienthoai LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),           
 Malop Char(10) REFERENCES LOP_HOC(Malop)
);

/*3.	Tạo bảng QUE_QUAN, chi tiết theo bảng sau:
Bảng: QUE_QUAN
Tên  trường	Kiểu dữ liệu	Mô tả
Id_qquan	Int	Khóa chính, phát sinh tự động
Quequan	Varchar(30)	NOT NULL, lưu trữ quê quán (ví dụ: Quang Nam)
Ghichu	Nvarchar(20)	NULL
*/
CREATE TABLE QUE_QUAN
(
 Id_qquan Int NOT NULL IDENTITY PRIMARY KEY,
 Quequan Varchar(30) NOT NULL,
 Ghichu Nvarchar(20) NULL
);
/*4.	Tạo bảng MON_HOC, theo chi tiết sau
Bảng: MON_HOC
Tên  trường	Kiểu dữ liệu	Mô tả
MaMH	Char(10)	Khóa chính, lưu trữ mã môn học
TenMH	varchar(20)	NOT NULL, lưu trữ tên môn học
Ghichu	varchar(30)	NULL
*/
CREATE TABLE MON_HOC
(
MaMH Char(10) NOT NULL PRIMARY KEY,
TenMH Varchar(20) NOT NULL,
Ghichu Varchar(30) NULL
);
/*5.	Bảng LOP_HOC, theo chi tiết sau
Bảng: LOP_HOC
Tên  trường	Kiểu dữ liệu	Mô tả
Malop	Char(10)	Khóa chính, lưu trữ mã lớp học
Tenlop	Varchar(30)	NOT NULL, lưu trữ tên lớp học
Suathoc	Varchar(20)	NOT NULL, lưu trữ suất học
*/
CREATE TABLE LOP_HOC
(
  Malop Char(10) NOT NULL PRIMARY KEY,
  Tenlop Varchar(30) NOT NULL,
  Suathoc Varchar(20) NOT NULL
);

/*6.	Tạo bảng DIEM, theo chi tiết bảng sau
Bảng: DIEM
Tên  trường	Kiểu dữ liệu	Mô tả
MaMH	Char(10)	Khóa ngoại, tham chiếu đến bảng MON_HOC
MaSV	Char(10)	Khóa ngoại, tham chiếu đến bảng SINH_VIEN
Diem	Float	Có giá trị mặc định là 10
Ghichu	Varchar(20)	NULL
*/
CREATE TABLE DIEM
(
 MaMH Char(10) REFERENCES MON_HOC(MaMH),
 MaSV Char(10) REFERENCES SINH_VIEN(MaSV),
 Diem Float DEFAULT 10,
 Ghichu Varchar(20) NULL
);
/*7.	Chèn dữ liệu vào các bảng
Bảng SINH_VIEN
MaSV	Holot	Ten	CMND	Ngaysinh	Id_qquan	Sodienthoai	Malop
CP001	Tran Quang	Minh	2011387436	23/12/1987	1	0905123321	KTV14
CP002	Nguyen Vinh	Giang	2343433344	24/12/1986	1	0905122222	KTV14
CP003	Le Quy	Binh	2342233322	11/1/1986	1	0905122222	B14
CP004	Nguyen Van	Vinh	2343432233	24/2/1986	2	0905122222	B14
CP005	Ly Thanh	Hoa	2343435544	22/12/1986	2	0905122222	B09
CP006	Mai Chau	Quynh	2343435544	21/12/1986	2	0905122222	B09
CP007	Le Van	Hai	2377333447	20/12/1986	3	0905122222	KTV14
CP008	Nguyen Cong	Dinh	2377333447	18/12/1986	3	0905122222	KTV14
CP009	Tran Vinh	Trinh	2343434439	24/12/1986	3	0905122222	KTV14
CP010	Nguyen Vinh	Giang	2343433344	24/12/1986	1	0905122222	KTV14
*/
INSERT INTO SINH_VIEN VALUES 
('CP001','Tran Quang Minh','2011387436','23/12/1987',1,'0905123321','KTV14'),
('CP002','Nguyen Vinh Giang','2343433344','24/12/1986',1,'0905122222','KTV14'),
('CP003','Le Quy Binh','2342233322','11/1/1986',1,'0905122222','B14'),
CP004	Nguyen Van	Vinh	2343432233	24/2/1986	2	0905122222	B14
CP005	Ly Thanh	Hoa	2343435544	22/12/1986	2	0905122222	B09
CP006	Mai Chau	Quynh	2343435544	21/12/1986	2	0905122222	B09
CP007	Le Van	Hai	2377333447	20/12/1986	3	0905122222	KTV14
CP008	Nguyen Cong	Dinh	2377333447	18/12/1986	3	0905122222	KTV14
CP009	Tran Vinh	Trinh	2343434439	24/12/1986	3	0905122222	KTV14
CP010	Nguyen Vinh	Giang	2343433344	24/12/1986	1	0905122222	KTV14)
Bảng: QUE_QUAN
Quequan	Ghichu
Quang Nam	
Da Nang	Thanh pho thuoc TW
Quang Ngai	

Bảng: MON_HOC
MaMH	TenMH	Ghichu
RDBMS	SQL Server 2005	He quan tri CSDL quan he
XML	XML by Example	
EPC	Programming with C	Lap trinh co ban C
ENG	English in computer	Anh van

Bảng: LOP_HOC
Malop	Tenlop	Suathoc
KTV14	Ky thuat vien 14	17h30-21h30, 2-4-6
B14	Lap trinh vien 14	17h30-21h30, 3-5-7
B09	Lap trinh vien 09	7h30-11h30, 2-4-6

Bảng: DIEM
MaMH	MaSV	Diem	Ghichu
RDBMS	CP001	12	
RDBMS	CP002	10	
RDBMS	CP003	8	
XML	CP001	10	
XML	CP002	12	
RDBMS	CP004	8	
RDBMS	CP005	24	
RDBMS	CP005	10	
RDBMS	CP008	10	
XML	CP009	20	
XML	CP010	19	
*/
/*8.	Viết câu lệnh TSQL thực hiện các công việc sau:*/
/*a.	Viết câu lệnh truy vấn liệt kê tất cả tên của các lớp học có trong bảng lớp học.*/
SELECT Tenlop
FROM LOP_HOC;
/*b.	Viết câu lệnh truy vấn liệt kê tất cả tên của tên của các môn học 
và sắp xếp theo thứ tự giảm dần theo tên môn học. (sử dụng mệnh Đề ORDER BY)*/
SELECT TenMH
FROM MON_HOC
ORDER BY TenMH DESC;
/*c.	Liệt kê chi tiết thông tin của 5 học sinh có độ tuổi cao nhất . (sử dụng mệnh Đề ORDER BY với Mệnh đề TOP)*/
SELECT TOP 5 *
FROM SINH_VIEN
ORDER BY Ngaysinh;

/*d.	Hiển thị danh sách sinh viên KTV14*/
SELECT *
FROM SINH_VIEN
WHERE Malop='KTV14';
/*e.	Hiển thị bảng điểm RDBMS của lớp KTV14 gồm các trường: MaSV, Holot va Ten, Ngaysinh,
 Tenlop, TenMH, Diem và sắp xếp theo thứ tự tăng và giảm dần*/
 SELECT MaSV,HoLot+Ten,Ngaysinh,Tenlop,TenMH,Diem
 FROM SINH_VIEN JOIN DIEM
      ON SINH_VIEN.MaSV=LOP_HOC.MaSV
	  JOIN MON_HOC ON 
 WHERE 

f.	Thêm ràng buộc kiểm tra NOT NULL vào trường CMND của bảng SINH_VIEN
g.	Thêm ràng buộc kiểm tra vào trường DIEM của bảng DIEM để dữ liệu chèn vào chỉ nhận giá trị >0
h.	Tự nhập 5 bảng ghi vào bảng DIEM có cột điểm nhận giá trị mặc định
i.	Xóa trường Ghichu của bảng DIEM
j.	Thêm trường Ghichu có kiểu dữ liệu varchar(30) vào bảng LOP_HOC
k.	Mở rộng trường Suathoc của LOP_HOC từ varchar(20) lên varchar(40)

9.	Tạo các đối tượng view với yêu cầu dưới đây
a.	Hiển thị danh sách sinh viên có quê ở Quang Nam
b.	Hiển thị danh sách những sinh viên ở tại Da Nang và có điểm RDBMS >= 10, và sắp xếp theo thứ tự tăng và giảm dần theo cột diem.
10.	Tạo các thủ tục lưu trữ (Stored Procedure) thực hiện: Thêm, Xoá, Sửa đổi, và tìm kiếm dựa trên mã số sinh viên trên bảng Sinh Viên. Sử dụng cấu trúc lập trình điều khiển (If), Cấu trúc bẫy lổi trong SQL ( Try –catch), hàm quản lý lỗi để để lập trình nâng cao trên thủ tục lưu trữ.
11.	Tạo Trigger cấm xoá nhiều hơn 1 dòng trong bảng sinh viên.
12.	Tạo Trigger hiển thị số dòng có trong bảng sinh viên mỗi khi Insert hoặc Update dữ liệu trên bảng SV.
*/