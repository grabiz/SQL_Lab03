/* LAB 03- NGUYEN BA ANH NGUYEN
LTVCN-iViettech*/
DROP DATABASE MarkMS;

/* 1.Tạo CSDL tên MarksMS*/
CREATE DATABASE MarkMS;
GO

USE MarkMS;

/*2.Tạo bảng có tên SINH_VIEN */

CREATE TABLE SINH_VIEN 
( 
 MaSV Char(10) NOT NULL PRIMARY KEY,
 HoLot Nvarchar(20) NOT NULL,
 Ten Nvarchar(10) NOT NULL,
 CMND Varchar(12) UNIQUE CHECK(CMND LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]%'),
 Ngaysinh Datetime CHECK( Ngaysinh < GETDATE()),
 Id_qquan Int REFERENCES QUE_QUAN (Id_qquan),
 Sodienthoai Varchar(12) NOT NULL UNIQUE CHECK(Sodienthoai LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]%'),           
 Malop Char(10) REFERENCES LOP_HOC(Malop)
);

/*3. Tạo bảng QUE_QUAN */

CREATE TABLE QUE_QUAN
(
 Id_qquan Int NOT NULL IDENTITY PRIMARY KEY,
 Quequan Varchar(30) NOT NULL,
 Ghichu Nvarchar(20) NULL
);

/*4. Tạo bảng MON_HOC  */

CREATE TABLE MON_HOC
(
MaMH Char(10) NOT NULL PRIMARY KEY,
TenMH Varchar(20) NOT NULL,
Ghichu Varchar(30) NULL
);

/*5. Bảng LOP_HOC */

CREATE TABLE LOP_HOC
(
  Malop Char(10) NOT NULL PRIMARY KEY,
  Tenlop Varchar(30) NOT NULL,
  Suathoc Varchar(20) NOT NULL
);

/*6. Tạo bảng DIEM */

CREATE TABLE DIEM
(
 MaMH Char(10) REFERENCES MON_HOC(MaMH),
 MaSV Char(10) REFERENCES SINH_VIEN(MaSV),
 Diem Float DEFAULT 10,
 Ghichu Varchar(20) NULL
);

/*7.	Chèn dữ liệu vào bảng SINH_VIEN */

INSERT INTO SINH_VIEN VALUES 
('CP001','Tran Quang','Minh','2011387436','1987-12-23',1,'0905123321','KTV14'),
('CP002','Nguyen Vinh','Giang','2343433344','1986-12-24',1,'0905122222','KTV14'),
('CP003','Le Quy','Binh','2342233322','1986-11-01',1,'0905122232','B14'),
('CP004','Nguyen Van','Vinh','2343432233','1986-02-24',2,'0905142222','B14'),
('CP005','Ly Thanh','Hoa','2343430544','1986-12-22',2,'0905122252','B09'),
('CP006','Mai Chau','Quynh','2303475544','1986-12-21',2,'0905123222','B09'),
('CP007','Le Van','Hai','2377333447','1986-12-20',3,'0905122282','KTV14'),
('CP008','Nguyen Cong','Dinh','2077333447','1986-12-18',3,'0905182222','KTV14'),
('CP009','Tran Vinh','Trinh','2343034439','1986-12-24',3,'0905129222','KTV14'),
('CP010','Nguyen Vinh','Giang','2343403344','1986-12-24',1,'0905120222','KTV14');

--Bang Que Quan--

INSERT INTO QUE_QUAN VALUES
('Quang Nam',NULL),
('Da Nang','Thanh pho thuoc TW'),
('Quang Ngai',NULL);

--Bảng: MON_HOC--

INSERT INTO MON_HOC VALUES
('RDBMS','SQL Server 2005','He quan tri CSDL quan he'),
('XML','XML by Example',NULL),	
('EPC','Programming with C','Lap trinh co ban C'),
('ENG','English in computer','Anh van');

--Bảng: LOP_HOC--

INSERT INTO LOP_HOC VALUES
('KTV14','Ky thuat vien 14','17h30-21h30, 2-4-6'),
('B14','Lap trinh vien 14','17h30-21h30, 3-5-7'),
('B09','Lap trinh vien 09','7h30-11h30, 2-4-6');

--Bảng: DIEM--

INSERT INTO DIEM VALUES
('RDBMS','CP001',12,NULL),	
('RDBMS','CP002',10,NULL),	
('RDBMS','CP003',8,NULL),	
('XML','CP001',10,NULL),	
('XML','CP002',12,NULL),	
('RDBMS','CP004',8,NULL),	
('RDBMS','CP006',24,NULL),	
('RDBMS','CP005',10,NULL),	
('RDBMS','CP008',10,NULL),	
('XML','CP009',20,NULL),	
('XML','CP010',19,NULL);	

/*8. a Viết câu lệnh truy vấn liệt kê tất cả tên của các lớp học có trong bảng lớp học.*/

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

/*e. Hiển thị bảng điểm RDBMS của lớp KTV14 gồm các trường: MaSV, Holot va Ten, Ngaysinh,
 Tenlop, TenMH, Diem và sắp xếp theo thứ tự tăng và giảm dần*/

SELECT SINH_VIEN.MaSV,Holot +Ten AS [Ho va ten],Ngaysinh,Tenlop,TenMH,Diem
FROM LOP_HOC JOIN SINH_VIEN
     ON LOP_HOC.Malop = SINH_VIEN.Malop
	 JOIN DIEM
	 ON SINH_VIEN.MaSV= DIEM.MaSV
	 JOIN MON_HOC
	 ON DIEM.MaMH = MON_HOC.MaMH
WHERE (MON_HOC.MaMH='RDBMS') AND (LOP_HOC.Malop='KTV14')
ORDER BY DIEM DESC;

--f. Thêm ràng buộc kiểm tra NOT NULL vào trường CMND của bảng SINH_VIEN--

ALTER TABLE SINH_VIEN 
ALTER COLUMN CMND VARCHAR(12) NOT NULL;

/*Loi luon xay ra vi co rang buoc UNIQUE UQ__SINH_VIE__F67C8D0B45B7D3E2 */

--g.	Thêm ràng buộc kiểm tra vào trường DIEM của bảng DIEM để dữ liệu chèn vào chỉ nhận giá trị >0--

ALTER TABLE DIEM
ADD CHECK (Diem>0);

--h. Tự nhập 5 bảng ghi vào bảng DIEM có cột điểm nhận giá trị mặc định

INSERT INTO DIEM VALUES ('RDBMS','CP010',DEFAULT,NULL);
INSERT INTO DIEM VALUES ('XML','CP001',DEFAULT,NULL);
INSERT INTO DIEM VALUES ('XML','CP009',DEFAULT,NULL);
INSERT INTO DIEM VALUES ('EPC','CP001',DEFAULT,NULL);
INSERT INTO DIEM VALUES ('ENG','CP002',DEFAULT,NULL);

--i. Xóa trường Ghichu của bảng DIEM --

ALTER TABLE DIEM
DROP COLUMN Ghichu;

--j. Thêm trường Ghichu có kiểu dữ liệu varchar(30) vào bảng LOP_HOC --

ALTER TABLE LOP_HOC
ADD Ghichu VARCHAR(30);

--k. Mở rộng trường Suathoc của LOP_HOC từ varchar(20) lên varchar(40)--

ALTER TABLE LOP_HOC
ALTER COLUMN Suathoc VARCHAR(40);

GO
/* 9.	Tạo các đối tượng view với yêu cầu dưới đây */
--a. Hiển thị danh sách sinh viên có quê ở Quang Nam --

CREATE VIEW vDisplayQuangNamHometown
AS
  SELECT MaSV,Holot,Ten,CMND,Ngaysinh,Sodienthoai,Malop
  FROM SINH_VIEN 
  WHERE Id_qquan IN (SELECT Id_qquan FROM QUE_QUAN WHERE Quequan='Quang Nam');
GO

--b. Hiển thị danh sách những sinh viên ở tại Da Nang và có điểm RDBMS >= 10, và sắp xếp theo thứ tự tăng và giảm dần theo cột diem.--

CREATE VIEW vDisplayDanangStudentRDBMS_DESC
AS 
    SELECT TOP 100 SINH_VIEN.MaSV,Holot,Ten,CMND,Ngaysinh,Sodienthoai,Malop
    FROM SINH_VIEN JOIN DIEM
	     ON SINH_VIEN.MaSV= DIEM.MaSV
		 JOIN MON_HOC
		 ON DIEM.MaMH = MON_HOC.MaMH
    WHERE Id_qquan IN (SELECT Id_qquan FROM QUE_QUAN WHERE Quequan='Da Nang')
	      AND (Diem >=10) AND MON_HOC.MaMH='RDBMS';
GO

/*10. Tạo các thủ tục lưu trữ (Stored Procedure) thực hiện: Thêm, Xoá, Sửa đổi, và tìm kiếm dựa trên mã số sinh viên trên bảng Sinh Viên. 
Sử dụng cấu trúc lập trình điều khiển (If), Cấu trúc bẫy lổi trong SQL ( Try –catch), hàm quản lý lỗi để để lập trình nâng cao trên thủ tục lưu trữ.*/

--ADD--

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
       ELSE IF (@Holot IS NULL) OR (LEN(@Holot)>10)
       THROW 50001,'Holot is not null and has maximum 10 characters.',1;
       ELSE IF (@Ten IS NULL) OR (LEN(@Ten)>10)
	   THROW 50001,'Ten is not null and has maximum 10 characters.',1;
       ELSE IF (@CMND IS NULL) OR (LEN(@CMND)>12) OR (@CMND IN (SELECT CMND FROM SINH_VIEN))
	   THROW 50001,'CMND is not null and has maximum 12 characters and must be unique.',1;
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

 BEGIN TRY
     EXEC spAddRowStudentTable @MaSV='CP011',@Holot='Tran Van',@Ten='Anh',@CMND='9000091294',@Ngaysinh='1980-04-30',@Id_qquan=1,@Sodienthoai='567A8909984',@Malop='KTV14';
	 PRINT 'Add student successfully.';
 END TRY	 
 BEGIN CATCH
     PRINT 'Error occured';
	 PRINT 'Error message :' + CONVERT(varchar(100),ERROR_MESSAGE());
 END CATCH;
GO
--DELETE--

CREATE PROC spDeleteRowStudentTable 
       @MaSV CHAR(10)=NULL   
AS
  BEGIN 
       IF (@MaSV NOT IN (SELECT MaSV FROM SINH_VIEN)) 
       THROW 50001,'MaSV is invalid.',1;
	   ELSE
          DELETE SINH_VIEN
          WHERE MaSV=@MaSV;          
		  
  END;
 GO

 BEGIN TRY
     EXEC spDeleteRowStudentTable @MaSV='CP010';
	 PRINT 'Deleted successfully.';
 END TRY	 
 BEGIN CATCH
     PRINT 'Error occured';
	 PRINT 'Error message :' + CONVERT(varchar(100),ERROR_MESSAGE());
 END CATCH;
 GO

 /*Chu y luon bao loi, muon DELETE phai DROP quan he giua SINH_VIEN va DIEM, vi DIEM chua khoa ngoai cua SINH_VIEN*/
 
--UPDATE--

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
       IF (@MaSV NOT IN (SELECT MaSV FROM SINH_VIEN)) 
       THROW 50001,'MaSV is invalid.',1;
       ELSE IF (@Holot=NULL) OR (LEN(@Holot)>10)
       THROW 50001,'Holot is not null and has maximum 10 characters.',1;
       ELSE IF (@Ten=NULL) OR (LEN(@Ten)>10)
	   THROW 50001,'Ten is not null and has maximum 10 characters.',1;
       ELSE IF (@CMND IS NULL) OR (LEN(@CMND)>12) OR (@CMND IN (SELECT CMND FROM SINH_VIEN))
	   THROW 50001,'CMND is not null and has maximum 12 characters and must be unique.',1;
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
          UPDATE SINH_VIEN
		  SET Holot=@Holot,Ten=@Ten,CMND=@CMND,Ngaysinh=@Ngaysinh,Id_qquan=@Id_qquan,Sodienthoai=@Sodienthoai,Malop=@Malop 
		  WHERE MaSV=@MaSV;	  
  END;
GO

BEGIN TRY
     EXEC spUpdateRowStudentTable @MaSV='CP010',@Holot='Tran Van',@Ten='Anh',@CMND='9000091294',@Ngaysinh='1980-04-30',@Id_qquan=1,@Sodienthoai='5678909984',@Malop='KTV14';
	 PRINT 'Updated student successfully.';
 END TRY	 
 BEGIN CATCH
     PRINT 'Error occured';
	 PRINT 'Error message :' + CONVERT(varchar(100),ERROR_MESSAGE());
 END CATCH;
GO

--SEARCH-- 

CREATE PROC spSearchStudentTable 
       @MaSV CHAR(10)=NULL 
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

 BEGIN TRY
     EXEC  spSearchStudentTable @MaSV='CP010';
	 PRINT 'Search successfully.';
 END TRY	 
 BEGIN CATCH
     PRINT 'Error occured';
	 PRINT 'Error message :' + CONVERT(varchar(100),ERROR_MESSAGE());
 END CATCH;
 GO

/*11.	Tạo Trigger cấm xoá nhiều hơn 1 dòng trong bảng sinh viên.*/

CREATE TRIGGER trgFORBIDDELETEMORETHAN1ROWS
ON SINH_VIEN
AFTER DELETE
AS
   IF (@@ROWCOUNT>1)
      BEGIN   
          ;THROW 50001,'Can''t delete more than one row',1;
          ROLLBACK TRAN;
      END;
GO

/*Chu y muon thuc hien trigger nay phai DROP quan he giua SINH_VIEN va DIEM, vi DIEM chua khoa ngoai cua SINH_VIEN*/

/*12.	Tạo Trigger hiển thị số dòng có trong bảng sinh viên mỗi khi Insert hoặc Update dữ liệu trên bảng SV.*/
CREATE TRIGGER trgCountRowsStudentTable
ON SINH_VIEN
AFTER INSERT,UPDATE
AS
  DECLARE @NumOfRows INT;
  DECLARE @NumOfRowsInsertedOrUpdated INT;
  SET @NumOfRows= (SELECT COUNT(*) FROM SINH_VIEN);
  SET @NumOfRowsInsertedOrUpdated = (SELECT COUNT(*) FROM Inserted);
  IF (SELECT MaSV FROM Inserted) IN (SELECT MaSV FROM SINH_VIEN) --Kiem tra xem la Update hay Insert, neu Update thi khong thay doi so dong trong bang
  PRINT 'Number of Rows :'+ CONVERT(char,@NumOfRows,1);
  ELSE 
  PRINT 'Number of Rows :'+ CONVERT(char,@NumOfRows+@NumOfRowsInsertedOrUpdated,1);
GO
