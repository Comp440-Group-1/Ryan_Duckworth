USE [master]
GO
/****** Object:  Database [s16guest06]    Script Date: 5/5/2016 5:32:52 AM ******/
CREATE DATABASE [s16guest06]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N's16guest06', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.CSDB440\MSSQL\DATA\s16guest06.mdf' , SIZE = 4160KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N's16guest06_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.CSDB440\MSSQL\DATA\s16guest06_log.ldf' , SIZE = 784KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [s16guest06] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [s16guest06].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [s16guest06] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [s16guest06] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [s16guest06] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [s16guest06] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [s16guest06] SET ARITHABORT OFF 
GO
ALTER DATABASE [s16guest06] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [s16guest06] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [s16guest06] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [s16guest06] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [s16guest06] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [s16guest06] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [s16guest06] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [s16guest06] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [s16guest06] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [s16guest06] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [s16guest06] SET  ENABLE_BROKER 
GO
ALTER DATABASE [s16guest06] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [s16guest06] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [s16guest06] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [s16guest06] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [s16guest06] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [s16guest06] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [s16guest06] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [s16guest06] SET RECOVERY FULL 
GO
ALTER DATABASE [s16guest06] SET  MULTI_USER 
GO
ALTER DATABASE [s16guest06] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [s16guest06] SET DB_CHAINING OFF 
GO
ALTER DATABASE [s16guest06] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [s16guest06] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N's16guest06', N'ON'
GO
USE [s16guest06]
GO
/****** Object:  User [s16guest06]    Script Date: 5/5/2016 5:32:52 AM ******/
CREATE USER [s16guest06] FOR LOGIN [s16guest06] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [s16guest06]
GO
/****** Object:  StoredProcedure [dbo].[GenerateMonthlyReport]    Script Date: 5/5/2016 5:32:52 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetNewFeatures]    Script Date: 5/5/2016 5:32:52 AM ******/
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
/****** Object:  StoredProcedure [dbo].[StateInsert]    Script Date: 5/5/2016 5:32:52 AM ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateVersion]    Script Date: 5/5/2016 5:32:52 AM ******/
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
/****** Object:  Table [dbo].[Address]    Script Date: 5/5/2016 5:32:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Address](
	[address_id] [int] IDENTITY(1,1) NOT NULL,
	[city_id] [int] NOT NULL,
	[country_id] [int] NOT NULL,
	[state_id] [int] NOT NULL,
	[street] [varchar](100) NOT NULL,
	[zip_code] [int] NOT NULL,
 CONSTRAINT [PK__Address] PRIMARY KEY CLUSTERED 
(
	[address_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Branch]    Script Date: 5/5/2016 5:32:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Branch](
	[branch_id] [int] IDENTITY(1,1) NOT NULL,
	[branch_number] [int] NULL,
	[development_release_id] [int] NULL,
	[product_id] [int] NULL,
 CONSTRAINT [PK__Branch] PRIMARY KEY CLUSTERED 
(
	[branch_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[City]    Script Date: 5/5/2016 5:32:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[City](
	[city_id] [int] IDENTITY(1,1) NOT NULL,
	[city_name] [varchar](25) NULL,
 CONSTRAINT [PK__City] PRIMARY KEY CLUSTERED 
(
	[city_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Company]    Script Date: 5/5/2016 5:32:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Company](
	[address_id] [int] NULL,
	[company_id] [int] IDENTITY(1,1) NOT NULL,
	[company_name] [varchar](50) NOT NULL,
	[phone_id] [int] NULL,
 CONSTRAINT [PK__Company] PRIMARY KEY CLUSTERED 
(
	[company_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Country]    Script Date: 5/5/2016 5:32:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Country](
	[country_id] [int] IDENTITY(1,1) NOT NULL,
	[country_name] [varchar](50) NOT NULL,
 CONSTRAINT [PK__Country] PRIMARY KEY CLUSTERED 
(
	[country_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 5/5/2016 5:32:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Customer](
	[company_id] [int] NULL,
	[customer_id] [int] IDENTITY(1,1) NOT NULL,
	[email] [varchar](50) NULL,
	[first_name] [varchar](25) NOT NULL,
	[last_name] [varchar](25) NULL,
 CONSTRAINT [PK__Customer] PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CustomerRelease]    Script Date: 5/5/2016 5:32:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CustomerRelease](
	[changelog] [varchar](200) NULL,
	[customer_release_id] [int] IDENTITY(1,1) NOT NULL,
	[development_release_id] [int] NOT NULL,
	[customer_release_date] [date] NULL,
	[type_of_release] [varchar](50) NULL,
 CONSTRAINT [PK_CustomerRelease] PRIMARY KEY CLUSTERED 
(
	[customer_release_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[date_test]    Script Date: 5/5/2016 5:32:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[date_test](
	[date_column] [date] NULL,
	[date_id] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DevelopmentRelease]    Script Date: 5/5/2016 5:32:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DevelopmentRelease](
	[development_release_id] [int] IDENTITY(1,1) NOT NULL,
	[development_release_number] [int] NULL,
	[version_id] [int] NULL,
	[product_id] [int] NOT NULL,
 CONSTRAINT [PK_DevelopmentRelease] PRIMARY KEY CLUSTERED 
(
	[development_release_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Download]    Script Date: 5/5/2016 5:32:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Download](
	[customer_id] [int] NULL,
	[customer_release_id] [int] NULL,
	[date_id] [int] NULL,
	[download_id] [int] IDENTITY(1,1) NOT NULL,
	[download_link] [varchar](100) NULL,
	[software_platform_id] [int] NULL,
	[product_id] [int] NULL,
	[download_date] [date] NULL,
 CONSTRAINT [PK__Download] PRIMARY KEY CLUSTERED 
(
	[download_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Feature]    Script Date: 5/5/2016 5:32:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Feature](
	[feature_description] [varchar](100) NULL,
	[feature_id] [int] IDENTITY(1,1) NOT NULL,
	[product_id] [int] NULL,
	[bugfix] [bit] NOT NULL,
 CONSTRAINT [PK__Feature] PRIMARY KEY CLUSTERED 
(
	[feature_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FeatureVersion]    Script Date: 5/5/2016 5:32:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FeatureVersion](
	[feature_id] [int] NOT NULL,
	[version_id] [int] NOT NULL,
 CONSTRAINT [PK__FeatureVersion] PRIMARY KEY CLUSTERED 
(
	[feature_id] ASC,
	[version_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Iteration]    Script Date: 5/5/2016 5:32:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Iteration](
	[branch_id] [int] NULL,
	[iteration_id] [int] IDENTITY(1,1) NOT NULL,
	[iteration_number] [int] NULL,
 CONSTRAINT [PK__Iteration] PRIMARY KEY CLUSTERED 
(
	[iteration_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Phone]    Script Date: 5/5/2016 5:32:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Phone](
	[phone_id] [int] NOT NULL,
	[phone_number] [int] NULL,
	[phone_type_id] [int] NULL,
 CONSTRAINT [PK__Phone] PRIMARY KEY CLUSTERED 
(
	[phone_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PhoneType]    Script Date: 5/5/2016 5:32:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PhoneType](
	[phone_type] [varchar](25) NOT NULL,
	[phone_type_id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK__PhoneType] PRIMARY KEY CLUSTERED 
(
	[phone_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Product]    Script Date: 5/5/2016 5:32:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product](
	[product_description] [varchar](500) NULL,
	[product_id] [int] IDENTITY(1,1) NOT NULL,
	[product_name] [varchar](50) NOT NULL,
 CONSTRAINT [PK__Product] PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sample data]    Script Date: 5/5/2016 5:32:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sample data](
	[Product] [varchar](50) NULL,
	[Platform] [varchar](50) NULL,
	[Description] [varchar](50) NULL,
	[Version] [varchar](50) NULL,
	[New Features] [varchar](50) NULL,
	[Release] [varchar](50) NULL,
	[type of release] [varchar](50) NULL,
	[Date of release] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SoftwarePlatform]    Script Date: 5/5/2016 5:32:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SoftwarePlatform](
	[software_platform_id] [int] IDENTITY(1,1) NOT NULL,
	[software_platform_name] [varchar](50) NOT NULL,
 CONSTRAINT [PK__Software] PRIMARY KEY CLUSTERED 
(
	[software_platform_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[State]    Script Date: 5/5/2016 5:32:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[State](
	[state_id] [int] IDENTITY(1,1) NOT NULL,
	[state_name] [varchar](50) NOT NULL,
 CONSTRAINT [PK__State] PRIMARY KEY CLUSTERED 
(
	[state_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Version]    Script Date: 5/5/2016 5:32:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Version](
	[version_id] [int] IDENTITY(1,1) NOT NULL,
	[version_number] [float] NOT NULL,
	[software_platform_id] [int] NULL,
	[product_id] [int] NOT NULL,
 CONSTRAINT [PK_Version] PRIMARY KEY CLUSTERED 
(
	[version_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[CustomerRelease] ADD  CONSTRAINT [DF_CustomerRelease_customer_release_date]  DEFAULT (getdate()) FOR [customer_release_date]
GO
ALTER TABLE [dbo].[Download] ADD  CONSTRAINT [DF_Download_download_date]  DEFAULT (getdate()) FOR [download_date]
GO
ALTER TABLE [dbo].[Feature] ADD  CONSTRAINT [DF_Feature_bugfix]  DEFAULT ((0)) FOR [bugfix]
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_product_name]  DEFAULT ('Placeholder Name') FOR [product_name]
GO
ALTER TABLE [dbo].[Address]  WITH CHECK ADD  CONSTRAINT [FK_Address_City] FOREIGN KEY([city_id])
REFERENCES [dbo].[City] ([city_id])
GO
ALTER TABLE [dbo].[Address] CHECK CONSTRAINT [FK_Address_City]
GO
ALTER TABLE [dbo].[Address]  WITH CHECK ADD  CONSTRAINT [FK_Address_Country] FOREIGN KEY([country_id])
REFERENCES [dbo].[Country] ([country_id])
GO
ALTER TABLE [dbo].[Address] CHECK CONSTRAINT [FK_Address_Country]
GO
ALTER TABLE [dbo].[Address]  WITH CHECK ADD  CONSTRAINT [FK_Address_State] FOREIGN KEY([state_id])
REFERENCES [dbo].[State] ([state_id])
GO
ALTER TABLE [dbo].[Address] CHECK CONSTRAINT [FK_Address_State]
GO
ALTER TABLE [dbo].[Branch]  WITH CHECK ADD  CONSTRAINT [FK_Branch_DevelopmentRelease] FOREIGN KEY([development_release_id])
REFERENCES [dbo].[DevelopmentRelease] ([development_release_id])
GO
ALTER TABLE [dbo].[Branch] CHECK CONSTRAINT [FK_Branch_DevelopmentRelease]
GO
ALTER TABLE [dbo].[Branch]  WITH CHECK ADD  CONSTRAINT [FK_Branch_Product] FOREIGN KEY([product_id])
REFERENCES [dbo].[Product] ([product_id])
GO
ALTER TABLE [dbo].[Branch] CHECK CONSTRAINT [FK_Branch_Product]
GO
ALTER TABLE [dbo].[Company]  WITH CHECK ADD  CONSTRAINT [FK_Company_Address] FOREIGN KEY([address_id])
REFERENCES [dbo].[Address] ([address_id])
GO
ALTER TABLE [dbo].[Company] CHECK CONSTRAINT [FK_Company_Address]
GO
ALTER TABLE [dbo].[Company]  WITH CHECK ADD  CONSTRAINT [FK_Company_Phone] FOREIGN KEY([phone_id])
REFERENCES [dbo].[Phone] ([phone_id])
GO
ALTER TABLE [dbo].[Company] CHECK CONSTRAINT [FK_Company_Phone]
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Company] FOREIGN KEY([company_id])
REFERENCES [dbo].[Company] ([company_id])
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_Company]
GO
ALTER TABLE [dbo].[CustomerRelease]  WITH CHECK ADD  CONSTRAINT [FK_CustomerRelease_DevelopmentRelease] FOREIGN KEY([development_release_id])
REFERENCES [dbo].[DevelopmentRelease] ([development_release_id])
GO
ALTER TABLE [dbo].[CustomerRelease] CHECK CONSTRAINT [FK_CustomerRelease_DevelopmentRelease]
GO
ALTER TABLE [dbo].[DevelopmentRelease]  WITH CHECK ADD  CONSTRAINT [FK_DevelopmentRelease_Product] FOREIGN KEY([product_id])
REFERENCES [dbo].[Product] ([product_id])
GO
ALTER TABLE [dbo].[DevelopmentRelease] CHECK CONSTRAINT [FK_DevelopmentRelease_Product]
GO
ALTER TABLE [dbo].[DevelopmentRelease]  WITH CHECK ADD  CONSTRAINT [FK_DevelopmentRelease_Version] FOREIGN KEY([version_id])
REFERENCES [dbo].[Version] ([version_id])
GO
ALTER TABLE [dbo].[DevelopmentRelease] CHECK CONSTRAINT [FK_DevelopmentRelease_Version]
GO
ALTER TABLE [dbo].[Download]  WITH CHECK ADD  CONSTRAINT [FK_Download_Customer] FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customer] ([customer_id])
GO
ALTER TABLE [dbo].[Download] CHECK CONSTRAINT [FK_Download_Customer]
GO
ALTER TABLE [dbo].[Download]  WITH CHECK ADD  CONSTRAINT [FK_Download_CustomerRelease] FOREIGN KEY([customer_release_id])
REFERENCES [dbo].[CustomerRelease] ([customer_release_id])
GO
ALTER TABLE [dbo].[Download] CHECK CONSTRAINT [FK_Download_CustomerRelease]
GO
ALTER TABLE [dbo].[Download]  WITH CHECK ADD  CONSTRAINT [FK_Download_Product] FOREIGN KEY([product_id])
REFERENCES [dbo].[Product] ([product_id])
GO
ALTER TABLE [dbo].[Download] CHECK CONSTRAINT [FK_Download_Product]
GO
ALTER TABLE [dbo].[Download]  WITH CHECK ADD  CONSTRAINT [FK_Download_SoftwarePlatform] FOREIGN KEY([software_platform_id])
REFERENCES [dbo].[SoftwarePlatform] ([software_platform_id])
GO
ALTER TABLE [dbo].[Download] CHECK CONSTRAINT [FK_Download_SoftwarePlatform]
GO
ALTER TABLE [dbo].[FeatureVersion]  WITH CHECK ADD  CONSTRAINT [FK_FeatureVersion_Feature] FOREIGN KEY([feature_id])
REFERENCES [dbo].[Feature] ([feature_id])
GO
ALTER TABLE [dbo].[FeatureVersion] CHECK CONSTRAINT [FK_FeatureVersion_Feature]
GO
ALTER TABLE [dbo].[FeatureVersion]  WITH CHECK ADD  CONSTRAINT [FK_FeatureVersion_Version] FOREIGN KEY([version_id])
REFERENCES [dbo].[Version] ([version_id])
GO
ALTER TABLE [dbo].[FeatureVersion] CHECK CONSTRAINT [FK_FeatureVersion_Version]
GO
ALTER TABLE [dbo].[Iteration]  WITH CHECK ADD  CONSTRAINT [FK_Iteration_Branch] FOREIGN KEY([branch_id])
REFERENCES [dbo].[Branch] ([branch_id])
GO
ALTER TABLE [dbo].[Iteration] CHECK CONSTRAINT [FK_Iteration_Branch]
GO
ALTER TABLE [dbo].[Phone]  WITH CHECK ADD  CONSTRAINT [FK_Phone_PhoneType] FOREIGN KEY([phone_type_id])
REFERENCES [dbo].[PhoneType] ([phone_type_id])
GO
ALTER TABLE [dbo].[Phone] CHECK CONSTRAINT [FK_Phone_PhoneType]
GO
ALTER TABLE [dbo].[Version]  WITH CHECK ADD  CONSTRAINT [FK_Version_Product] FOREIGN KEY([product_id])
REFERENCES [dbo].[Product] ([product_id])
GO
ALTER TABLE [dbo].[Version] CHECK CONSTRAINT [FK_Version_Product]
GO
ALTER TABLE [dbo].[Version]  WITH CHECK ADD  CONSTRAINT [FK_Version_SoftwarePlatform] FOREIGN KEY([software_platform_id])
REFERENCES [dbo].[SoftwarePlatform] ([software_platform_id])
GO
ALTER TABLE [dbo].[Version] CHECK CONSTRAINT [FK_Version_SoftwarePlatform]
GO
USE [master]
GO
ALTER DATABASE [s16guest06] SET  READ_WRITE 
GO
