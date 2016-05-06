USE [s16guest06]
GO
/****** Object:  StoredProcedure [dbo].[StateInsert]    Script Date: 5/5/2016 6:16:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Duckworth, Ryan>
-- Create date: <5/3/16>
-- Description:	<Inserts a state_name into the State table>
-- Prerequisites: None
-- Error Checking: It rolls back an unsuccessful insert
-- Sample Run: EXEC StateInsert @state_name = 'New Mexico'
-- =============================================
CREATE PROCEDURE [dbo].[StateInsert] 
	   @state_name varchar(50)
AS

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

BEGIN TRANSACTION
BEGIN TRY
    -- Insert statements for procedure here
	INSERT INTO dbo.State (state_name)
	VALUES (@state_name);
SELECT * FROM State
COMMIT TRANSACTION
END TRY
BEGIN CATCH
    SELECT

        ERROR_LINE() AS ErrorLine,
        ERROR_MESSAGE() AS ErrorMessage,
		ERROR_NUMBER() AS ErrorNumber,
        ERROR_SEVERITY() AS ErrorSeverity,
        ERROR_STATE() AS ErrorState,
        ERROR_PROCEDURE() AS ErrorProcedure;

	ROLLBACK TRANSACTION
END CATCH
GO
