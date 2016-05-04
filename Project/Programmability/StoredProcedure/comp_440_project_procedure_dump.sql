USE [s16guest06]
GO
/****** Object:  StoredProcedure [dbo].[StateInsert]    Script Date: 5/4/2016 2:22:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Duckworth, Ryan>
-- Create date: <5/3/16>
-- Description:	<Inserts a state_name into the State table>
-- =============================================
CREATE PROCEDURE [dbo].[StateInsert] 
	   @state_name varchar(50)
AS
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO dbo.State (state_name)
	VALUES (@state_name);
END TRY
BEGIN CATCH
INSERT INTO dbo.State (state_name)
VALUES ('invalid');
THROW
END CATCH

GO
/****** Object:  StoredProcedure [dbo].[UpdateVersion]    Script Date: 5/4/2016 2:22:18 PM ******/
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
	@new_version_number int = 1
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

IF (SELECT COUNT(*) FROM dbo.Product WHERE product_id = @product_id) = 0

BEGIN
PRINT 'No matching product_id in the Product table!';
END

ELSE
BEGIN

UPDATE dbo.Version
SET version_number = @new_version_number
WHERE version_number=
(SELECT MAX(version_number)
FROM dbo.Version
WHERE product_id = @product_id);
PRINT 'Updated Version Number!'

END

END

GO
