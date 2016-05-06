USE [s16guest06]
GO
/****** Object:  StoredProcedure [dbo].[GenerateMonthlyReport]    Script Date: 5/5/2016 6:16:00 PM ******/
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

SELECT dbo.Product.product_name AS ProductName, dbo.Version.version_number AS Version, MONTH(dbo.download.download_date) AS ReportingMonth, COUNT(dbo.download.download_date) AS DownloadCount
FROM dbo.Download
JOIN dbo.Product ON dbo.Download.product_id = dbo.Product.product_id
JOIN dbo.CustomerRelease ON dbo.CustomerRelease.customer_release_id = dbo.Download.customer_release_id
JOIN dbo.DevelopmentRelease ON dbo.DevelopmentRelease.development_release_id = dbo.CustomerRelease.development_release_id
JOIN dbo.Version ON dbo.Version.version_id = dbo.DevelopmentRelease.version_id
GROUP BY MONTH(dbo.download.download_date), dbo.Product.product_name, dbo.Version.version_number
ORDER BY ReportingMonth
END

GO
