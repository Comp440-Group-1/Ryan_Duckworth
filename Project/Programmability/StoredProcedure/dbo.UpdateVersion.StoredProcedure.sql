USE [s16guest06]
GO
/****** Object:  StoredProcedure [dbo].[UpdateVersion]    Script Date: 5/5/2016 6:16:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Duckworth, Ryan>
-- Create date: <5/4/16>
-- Description:	<Updates the latest version number of particular version when given a product ID.>
-- Prerequisites: Given product_id MUST be valid and in the Product table.
-- Error Checking: It checks if the prerequisite product_id exists in the Product table first
-- Sample Run: EXEC UpdateVersion @product_id = 1, @new_version_number = 25;
-- =============================================
CREATE PROCEDURE [dbo].[UpdateVersion]

	@product_id int = -1,
	@new_version_number float = 1
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

IF (SELECT COUNT(*) FROM dbo.Product WHERE product_id = @product_id) = 0

BEGIN
RAISERROR('No matching product_id in the Product table!', 18, 1);
RETURN ;
END

ELSE

BEGIN TRANSACTION
BEGIN TRY

UPDATE dbo.Version
SET version_number = @new_version_number
WHERE version_number=
(SELECT MAX(version_number)
FROM dbo.Version
WHERE product_id = @product_id);


PRINT 'Updated Version Number!'
SELECT * FROM Version
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

END


GO
