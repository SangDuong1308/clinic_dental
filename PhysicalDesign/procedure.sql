USE PHONGKHAM

-- QTV3

--Xem--
DROP PROCEDURE dbo.viewAcc;  
GO  
CREATE PROCEDURE viewAcc
@ID_USER [nchar](20)
AS
BEGIN
		BEGIN TRY
			BEGIN TRAN
			BEGIN
				SELECT * FROM [dbo].[NHANVIEN] WHERE [dbo].[NHANVIEN].ID_USER = @ID_USER
			END
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
END
GO

--EXEC dbo.viewAcc 'NV07'

--SELECT * FROM dbo.NHANVIEN
--EXEC dbo.updateAccDetail @Username = N'Jeannie',  -- nchar(50)
--                         @oldPass = 'OQ0KNZH',    -- char(50)
--                         @newPass = '123456',    -- char(50)
--                         @newName = N'malo gusto',   -- nchar(50)
--                         @newGender = N'Nam', -- nchar(50)
--                         @newAddr = N'tk 12/22 nvc',   -- nchar(50)
--                         @newSalary = 10000    -- int

--Cap nhat--
DROP PROCEDURE dbo.updateAccDetail;  
GO 
CREATE PROCEDURE dbo.updateAccDetail
@Username [nchar](50),
@oldPass [char](50),
@newPass [char](50),
@newName [nchar](50),
@newGender [nchar](50),
@newAddr [nchar](50),
@newSalary [int]
AS
BEGIN
		BEGIN TRY
		BEGIN TRAN
			IF EXISTS (SELECT A.Username FROM [dbo].[NHANVIEN] A WHERE A.Username = @Username 
															AND A.Password = @oldPass)
			BEGIN
				UPDATE [dbo].[NHANVIEN]
				SET [Password] = @newPass, [SysUserName] = @newName, [SysUserGender] = @newGender,
					[DiaChiNV] = @newAddr, [Luong] = @newSalary
				WHERE [dbo].[NHANVIEN].Username = @Username 
			END
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
END
GO

--Them--
DROP PROCEDURE dbo.addAcc;  
GO 
CREATE PROCEDURE dbo.addAcc
    @ID_USER [nchar](20),
    @Username [nchar](50),
    @Password [char](50),
    @SysUserName [nchar](50),
    @SysUserGender [nchar](50),
    @DiaChiNV [nchar](50),
    @Luong [int],
    @LoaiTK [nchar](10),
    @ID_PK [nchar](20)
AS
BEGIN
    BEGIN TRY
        BEGIN TRAN
        IF NOT EXISTS (SELECT NV.ID_USER FROM [dbo].[NHANVIEN] NV WHERE ID_USER = @ID_USER)
        BEGIN
            -- If it doesn't exist, insert a new row
            INSERT INTO [dbo].[NHANVIEN] (ID_USER, Username, Password, SysUserName, SysUserGender, DiaChiNV, Luong, LoaiTK, ID_PK)
            VALUES (@ID_USER, @Username, @Password, @SysUserName, @SysUserGender, @DiaChiNV, @Luong, @LoaiTK, @ID_PK);

            COMMIT TRAN
            PRINT 'Nhân viên đã được thêm thành công.';
        END
        ELSE
        BEGIN
            ROLLBACK TRAN
            PRINT N'Lỗi: Mã nhân viên đã tồn tại.';
        END
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN
        PRINT N'Lỗi: ' + ERROR_MESSAGE();
    END CATCH
END;
GO

--EXEC dbo.addAcc @ID_USER = N'NV04',       -- nchar(20)
--                @Username = N'sang',      -- nchar(50)
--                @Password = '123',       -- char(50)
--                @SysUserName = N'sang duong',   -- nchar(50)
--                @SysUserGender = N'Nam', -- nchar(50)
--                @DiaChiNV = N'127 NVC',      -- nchar(50)
--                @Luong = 100000,           -- int
--                @LoaiTK = N'Nha sĩ',        -- nchar(10)
--                @ID_PK = N'PK8'          -- nchar(20)
--GO

--EXEC dbo.addAcc @ID_USER = N'NV100',       -- nchar(20)
--                @Username = N'sangduong',      -- nchar(50)
--                @Password = '123456',       -- char(50)
--                @SysUserName = N'Dương Phước Sang',   -- nchar(50)
--                @SysUserGender = N'Nam', -- nchar(50)
--                @DiaChiNV = N'tk 12/22',      -- nchar(50)
--                @Luong = 50000000,           -- int
--                @LoaiTK = N'Nha sĩ',        -- nchar(10)
--                @ID_PK = N'PK4'          -- nchar(20)


--SELECT * from nhanvien nv WHERE nv.Username ='sangduong'
--SELECT * FROM dbo.NHANVIEN


--Xoá--
DROP PROCEDURE dbo.delAcc;  
GO 
CREATE PROCEDURE dbo.delAcc
    @ID_USER [nchar](20)
AS
BEGIN
    BEGIN TRY
        BEGIN TRAN
        IF EXISTS (SELECT NV.ID_USER  FROM [dbo].[NHANVIEN] NV WHERE ID_USER = @ID_USER)
        BEGIN
            DELETE FROM [dbo].[NHANVIEN] WHERE ID_USER = @ID_USER;
            COMMIT TRAN
            PRINT N'Xoá thành công';
        END
        ELSE
        BEGIN   
            ROLLBACK TRAN
            PRINT N'Lỗi: Mã nhân viên không tồn tại.';
        END
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN
        PRINT N'Lỗi: ' + ERROR_MESSAGE();
    END CATCH
END;
GO

EXEC dbo.delAcc @ID_USER = N'NV06' -- nchar(20)

USE phongkham
SELECT * FROM dbo.HOSOBENHNHAN

--NS1

DROP PROCEDURE dbo.xemHosoBenhNhan;  
GO  
CREATE PROCEDURE xemHosoBenhNhan
@ID_HS [nchar](20)
AS
BEGIN
		BEGIN TRY
			BEGIN TRAN
			BEGIN
				SELECT * FROM [dbo].[HOSOBENHNHAN] WHERE [dbo].[HOSOBENHNHAN].ID_HS = @ID_HS
			END
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
END
GO

EXEC dbo.xemHosoBenhNhan @ID_HS = 'HS00316' -- nchar(20)


--NS2

DROP PROCEDURE dbo.updateToothHealth;  
GO 
CREATE PROCEDURE dbo.updateToothHealth
@ID_HS [nchar](20),
@TongQuan [NCHAR](50),
@ChongChiDinhThuoc [NCHAR](50),
@TinhTrangDiUng [NCHAR](50)
AS
BEGIN
		BEGIN TRY
		BEGIN TRAN
			IF EXISTS (SELECT HS.TenBenhNhan FROM [dbo].[HOSOBENHNHAN] HS WHERE HS.ID_HS = @ID_HS)
			BEGIN
				UPDATE [dbo].[HOSOBENHNHAN]
				SET [TongQuan] = @TongQuan, [ChongChiDinhThuoc] = @ChongChiDinhThuoc,
					[TinhTrangDiUng] = @TinhTrangDiUng
				WHERE [dbo].[HOSOBENHNHAN].ID_HS = @ID_HS
			END
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
END
go
EXEC dbo.updateToothHealth @ID_HS = N'HS00022',             -- nchar(20)
                           @TongQuan = N'Răng sún, sâu răng, răng vaàng',          -- nchar(50)
                           @ChongChiDinhThuoc = N'paracetamol, xổ giun', -- nchar(50)
                           @TinhTrangDiUng = N'không'     -- nchar(50)


--NS3



