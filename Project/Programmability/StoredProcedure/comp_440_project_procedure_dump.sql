USE [s16guest06]
GO
/****** Object:  StoredProcedure [dbo].[GenerateMonthlyReport]    Script Date: 5/5/2016 5:33:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Duckworth, Ryan>
-- Create date: <5/4/16>
-- Description:	<Returns a report that gives the product_id, product_description, version_number, reporting_month, and download_count>
-- Prerequisites: All dependency tables must be filled out in order for the downloads table to be populated and used to generate the report.
-- Sample Run: EXEC GenerateMonthlyReport;
-- =============================================
CREATE PROCEDURE [dbo].[GenerateMonthlyReport]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT dbo.Product.product_id AS ProductID, dbo.Product.product_description AS ProductDescription, dbo.Version.version_number AS Version, MONTH(dbo.download.download_date) AS ReportingMonth, COUNT(dbo.download.download_date) AS DownloadCount
FROM dbo.Download
JOIN dbo.Product ON dbo.Download.product_id = dbo.Product.product_id
JOIN dbo.CustomerRelease ON dbo.CustomerRelease.customer_release_id = dbo.Download.customer_release_id
JOIN dbo.DevelopmentRelease ON dbo.DevelopmentRelease.development_release_id = dbo.CustomerRelease.development_release_id
JOIN dbo.Version ON dbo.Version.version_id = dbo.DevelopmentRelease.version_id
GROUP BY MONTH(dbo.download.download_date), dbo.Product.product_id, dbo.Product.product_description, dbo.Version.version_number

END

GO
/****** Object:  StoredProcedure [dbo].[GetNewFeatures]    Script Date: 5/5/2016 5:33:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Duckworth, Ryan>
-- Create date: <5/4/16>
-- Description:	<Gets the number of new features for any given version since the previous release>
-- Prerequisites: All dependency tables must be filled in order to utilize this function.

-- Notes: If no previous version number is supplied, then the function will use the last version major release
--		  as the basis for calculating the number of new features. This function does not work on version number
--		  1.0 because the basis of the function is to compare between two major versions and print a message that
--		  could be used on the website to announce new features. If it's the first release, then all the features
--		  would be new by default, and this function wouldn't be needed.

-- Parameters: @product_id: The product id to be used to determing the new features for the release. Must be supplied.
--			   @v_id: The version id to be used as the current version
--			   @v_id_previous: version id which is used to compare with the new version. All version releases in between
--							   determining what new features, if any, are in the new @v_id release
-- Sample Run: EXEC GetNewFeatures @v_id = 7;
-- =============================================
CREATE PROCEDURE [dbo].[GetNewFeatures] 
	-- Add the parameters for the stored procedure here
	@product_id int = -1,
	@v_id int = -1,
	@v_id_previous float = -1

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

DECLARE @v_num AS float;
DECLARE @v_num_previous AS float;

IF @v_id = -1
BEGIN
RAISERROR('Version id not set to appropriate value', 18, 1);
RETURN ;
END

IF @product_id = -1
BEGIN
RAISERROR('Product id not set to appropriate value', 18, 1);
RETURN ;
END

SET @v_num = (SELECT version_number FROM Version
WHERE version_id = @v_id)

IF @v_id_previous = -1
BEGIN

SET @v_num_previous = (CEILING(@v_num) -1)

END

ELSE
BEGIN
SET @v_num_previous = (SELECT version_number FROM Version
WHERE version_id = @v_id_previous)
END

DECLARE @new_features AS int
SELECT @new_features =
(SELECT COUNT(*)
FROM dbo.FeatureVersion
JOIN dbo.Version ON FeatureVersion.version_id = dbo.Version.version_id
JOIN dbo.Feature ON FeatureVersion.feature_id = dbo.Feature.feature_id
WHERE dbo.Version.product_id = @product_id AND dbo.Version.version_number <= @v_num AND dbo.Version.version_number > @v_num_previous AND dbo.Feature.bugfix = 0)

IF @new_features > 0
PRINT ('There are ' + CAST(@new_features AS VARCHAR(20)) + ' new features in the ' + CAST(@v_num AS VARCHAR(20)) +
 ' release since the previous release ' + CAST(@v_num_previous AS VARCHAR(20)) + '!') 
ELSE
PRINT ('This is a bug fix release, there are no new features in release ' + CAST(@v_num AS VARCHAR(20)));

END

GO
/****** Object:  StoredProcedure [dbo].[StateInsert]    Script Date: 5/5/2016 5:33:52 AM ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateVersion]    Script Date: 5/5/2016 5:33:52 AM ******/
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
