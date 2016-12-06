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


/*3.	Tạo bảng QUE_QUAN, chi tiết theo bảng sau:
Bảng: QUE_QUAN
Tên  trường	Kiểu dữ liệu	Mô tả
Id_qquan	Int	Khóa chính, phát sinh tự động
Quequan	Varchar(30)	NOT NULL, lưu trữ quê quán (ví dụ: Quang Nam)
Ghichu	Nvarchar(20)	NULL
*/

/*4.	Tạo bảng MON_HOC, theo chi tiết sau
Bảng: MON_HOC
Tên  trường	Kiểu dữ liệu	Mô tả
MaMH	Char(10)	Khóa chính, lưu trữ mã môn học
TenMH	varchar(20)	NOT NULL, lưu trữ tên môn học
Ghichu	varchar(30)	NULL
*/

/*5.	Bảng LOP_HOC, theo chi tiết sau
Bảng: LOP_HOC
Tên  trường	Kiểu dữ liệu	Mô tả
Malop	Char(10)	Khóa chính, lưu trữ mã lớp học
Tenlop	Varchar(30)	NOT NULL, lưu trữ tên lớp học
Suathoc	Varchar(20)	NOT NULL, lưu trữ suất học
*/


/*6.	Tạo bảng DIEM, theo chi tiết bảng sau
Bảng: DIEM
Tên  trường	Kiểu dữ liệu	Mô tả
MaMH	Char(10)	Khóa ngoại, tham chiếu đến bảng MON_HOC
MaSV	Char(10)	Khóa ngoại, tham chiếu đến bảng SINH_VIEN
Diem	Float	Có giá trị mặc định là 10
Ghichu	Varchar(20)	NULL
*/
/*e.	Hiển thị bảng điểm RDBMS của lớp KTV14 gồm các trường: MaSV, Holot va Ten, Ngaysinh,
 Tenlop, TenMH, Diem và sắp xếp theo thứ tự tăng và giảm dần*/
SELECT MaSV,Holot +Ten AS [Ho va ten],Ngaysinh,Tenlop,TenMH,Diem
FROM LOP_HOC JOIN SINH_VIEN
     ON LOP_HOC.Malop = SINH_VIEN.Malop
	 JOIN DIEM
	 ON SINH_VIEN.MaSV= DIEM.MaSV
	 JOIN MON_HOC
	 ON DIEM.MaMH = MON_HOC.MaMH
WHERE TenMH='RDBMS' AND Tenlop='KTV14'
ORDER BY DIEM DESC;
f.	Thêm ràng buộc kiểm tra NOT NULL vào trường CMND của bảng SINH_VIEN
ALTER TABLE SINH_VIEN 
ALTER COLUMN CMND VARCHAR(12) UNIQUE NOT NULL;
ADD CMND NOT NULL; 
g.	Thêm ràng buộc kiểm tra vào trường DIEM của bảng DIEM để dữ liệu chèn vào chỉ nhận giá trị >0
ALTER TABLE DIEM
ADD CHECK (Diem>0);
h.	Tự nhập 5 bảng ghi vào bảng DIEM có cột điểm nhận giá trị mặc định
INSERT INTO DIEM VALUES ('DSC1000000','ABBBBBBBBB');
INSERT INTO DIEM VALUES ('DSC1000000','ABBBBBBBBB');
INSERT INTO DIEM VALUES ('DSC1000000','ABBBBBBBBB');
INSERT INTO DIEM VALUES ('DSC1000000','ABBBBBBBBB');
INSERT INTO DIEM VALUES ('DSC1000000','ABBBBBBBBB');
i.	Xóa trường Ghichu của bảng DIEM
ALTER TABLE DIEM
DROP COLUMN Ghichu;
j.	Thêm trường Ghichu có kiểu dữ liệu varchar(30) vào bảng LOP_HOC
ALTER TABLE LOP_HOC
ADD Ghichu VARCHAR(30);
k.	Mở rộng trường Suathoc của LOP_HOC từ varchar(20) lên varchar(40)
ALTER TABLE LOP_HOC
ALTER COLUMN Suathoc VARCHAR(40);
9.	Tạo các đối tượng view với yêu cầu dưới đây
a.	Hiển thị danh sách sinh viên có quê ở Quang Nam
CREATE VIEW vDisplayQuangNamHometown
AS
  SELECT MaSV,Holot,Ten,CMND,Ngaysinh,Sodienthoai,Malop
  FROM SINH_VIEN 
  WHERE Id_qquan IN (SELECT Id_qquan FROM QUE_QUAN WHERE Quequan='Quang Nam');
b.	Hiển thị danh sách những sinh viên ở tại Da Nang và có điểm RDBMS >= 10, và sắp xếp theo thứ tự tăng và giảm dần theo cột diem.
CREATE VIEW vDisplayDanangStudentRDBMS_DESC
AS 
    SELECT TOP 100 MaSV,Holot,Ten,CMND,Ngaysinh,Sodienthoai,Malop
    FROM SINH_VIEN JOIN DIEM
	     ON SINH_VIEN.MaSV= DIEM.MaSV
		 JOIN MON_HOC
		 ON DIEM.MaMH = MON_HOC.MaMH
    WHERE Id_qquan IN (SELECT Id_qquan FROM QUE_QUAN WHERE Quequan='Da Nang')
	      AND (Diem >=10) AND MaMH='RDBMS';
10.	Tạo các thủ tục lưu trữ (Stored Procedure) thực hiện: Thêm, Xoá, Sửa đổi, và tìm kiếm dựa trên mã số sinh viên trên bảng Sinh Viên. Sử dụng cấu trúc lập trình điều khiển (If), Cấu trúc bẫy lổi trong SQL ( Try –catch), hàm quản lý lỗi để để lập trình nâng cao trên thủ tục lưu trữ.
ADD

CREATE PROC spAddRowStudentTable 
       @MaSV CHAR(10)=NULL,
	   @Holot NVARCHAR(10)=NULL,
	   @Ten NVARCHAR(10) =NULL,
	   @CMND VARCHAR(12)= NULL,
	   @Ngaysinh DATETIME =NULL,
	   @Id_qquan INT =NULL,
	   @Sodienthoai VARCHAR(12)=NULL,
	   @Malop CHAR(10)=NULL
AS
  BEGIN 
       IF (@MaSV IS NULL) OR (LEN(@MaSV)>10) OR (@MaSV IN (SELECT MaSV FROM SINH_VIEN)) 
       THROW 50001,'MaSV is invalid.',1;
       ELSE IF (@Holot=NULL) OR (LEN(@Holot)>10)
       THROW 50001,'Holot is not null and has maximum 10 characters.',1;
       ELSE IF (@Ten=NULL) OR (LEN(@Ten)>10)
	   THROW 50001,'Ten is not null and has maximum 10 characters.',1;
       ELSE IF (LEN(@CMND)>12) OR (@CMND IN (SELECT CMND FROM SINH_VIEN))
	   THROW 50001,'CMND is not null and has maximum 12 characters.',1;
       ELSE IF (@Ngaysinh>GETDATE())
	   THROW 50001,'Ngaysinh is invalid.',1;
       ELSE IF @ID_qquan NOT IN (SELECT Id_qquan FROM QUE_QUAN)
	   THROW 50001,'ID_qquan is invalid.',1;
       ELSE IF (@Sodienthoai IS NULL) OR (LEN(@Sodienthoai)>12) 
	        OR (@Sodienthoai IN (SELECT Sodienthoai FROM SINH_VIEN)) 
			OR (@Sodienthoai LIKE '%[^0-9]%')
	   THROW 50001,'Sodienthoai is not null,must have 10 numbers and must be unique.',1;
       ELSE IF (@Malop NOT IN (SELECT Malop FROM LOP_HOC))
	   THROW 50001,'Malop is invalid.',1;
	   ELSE
          INSERT INTO SINH_VIEN VALUES (@MaSV,@Holot,@Ten,@CMND,@Ngaysinh,@Id_qquan,@Sodienthoai,@Malop);  
  END;
 GO
DELETE

CREATE PROC spDeleteRowStudentTable 
       @MaSV CHAR(10)=NULL,   
AS
  BEGIN 
       IF (@MaSV NOT IN (SELECT MaSV FROM SINH_VIEN)) 
       THROW 50001,'MaSV is invalid.',1;
	   ELSE
          DELETE SINH_VIEN
          WHERE MaSV=@MaSV;          
		  
  END;
 GO
 
UPDATE

CREATE PROC spUpdateRowStudentTable 
       @MaSV CHAR(10)=NULL,
	   @Holot NVARCHAR(10)=NULL,
	   @Ten NVARCHAR(10) =NULL,
	   @CMND VARCHAR(12)= NULL,
	   @Ngaysinh DATETIME =NULL,
	   @Id_qquan INT =NULL,
	   @Sodienthoai VARCHAR(12)=NULL,
	   @Malop CHAR(10)=NULL
AS
  BEGIN 
       IF (@MaSV IS NULL) OR (LEN(@MaSV)>10) OR (@MaSV IN (SELECT MaSV FROM SINH_VIEN)) 
       THROW 50001,'MaSV is invalid.',1;
       ELSE IF (@Holot=NULL) OR (LEN(@Holot)>10)
       THROW 50001,'Holot is not null and has maximum 10 characters.',1;
       ELSE IF (@Ten=NULL) OR (LEN(@Ten)>10)
	   THROW 50001,'Ten is not null and has maximum 10 characters.',1;
       ELSE IF (LEN(@CMND)>12) OR (@CMND IN (SELECT CMND FROM SINH_VIEN))
	   THROW 50001,'CMND is not null and has maximum 12 characters.',1;
       ELSE IF (@Ngaysinh>GETDATE())
	   THROW 50001,'Ngaysinh is invalid.',1;
       ELSE IF @ID_qquan NOT IN (SELECT Id_qquan FROM QUE_QUAN)
	   THROW 50001,'ID_qquan is invalid.',1;
       ELSE IF (@Sodienthoai IS NULL) OR (LEN(@Sodienthoai)>12) 
	        OR (@Sodienthoai IN (SELECT Sodienthoai FROM SINH_VIEN)) 
			OR (@Sodienthoai LIKE '%[^0-9]%')
	   THROW 50001,'Sodienthoai is not null,must have 10 numbers and must be unique.',1;
       ELSE IF (@Malop NOT IN (SELECT Malop FROM LOP_HOC))
	   THROW 50001,'Malop is invalid.',1;
	   ELSE
          UPDATE
		  SET Holot=@Holot,Ten=@Ten,CMND=@CMND,Ngaysinh=@Ngaysinh,Id_qquan=@Id_qquan,Sodienthoai=@Sodienthoai,Malop=@Malop 
		  WHERE MaSV=@MaSV;	  
  END;
GO



SEARCH 


CREATE PROC spSearchStudentTable 
       @MaSV CHAR(10)=NULL,   
AS
  BEGIN 
       IF (@MaSV NOT IN (SELECT MaSV FROM SINH_VIEN)) 
       THROW 50001,'MaSV is invalid.',1;
	   ELSE
          SELECT *
          FROM	SINH_VIEN
          WHERE MaSV=@MaSV;          
		  
  END;
 GO





11.	Tạo Trigger cấm xoá nhiều hơn 1 dòng trong bảng sinh viên.
CREATE TRIGGER trgFORBIDDELETEMORETHAN1ROWS
ON SINH_VIEN
AFTER DELETE
AS
   IF (@@ROWCOUNT>1)
      BEGIN   
          THROW 50001,'Can''t delete more than one row',1;
          ROLLTRAN;
      END;
12.	Tạo Trigger hiển thị số dòng có trong bảng sinh viên mỗi khi Insert hoặc Update dữ liệu trên bảng SV.
CREATE TRIGGER trgCountRowsStudentTable
ON SINH_VIEN
AFTER INSERT,UPDATE
AS
  DECLARE @NumOfRows INT;
  DECLARE @NumOfRowsInsertedOrUpdated INT;
  @NumOfRows=SELECT COUNT(*) FROM SINH_VIEN;
  @NumOfRowsInsertedOrUpdated = SELECT COUNT(*) FROM Inserted;
  IF (SELECT MaSV FROM Inserted) IN (SELECT MaSV FROM SINH_VIEN)
  PRINT 'Number of Rows :'+ CONVERT(char,@NumOfRows,1);
  ELSE 
  PRINT 'Number of Rows :'+ CONVERT(char,@NumOfRows+@NumOfRowsInsertedOrUpdated,1);
GO
