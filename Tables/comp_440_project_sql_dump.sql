USE [s16guest06]
GO
/****** Object:  Table [dbo].[Address]    Script Date: 4/30/2016 11:45:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Address](
	[address_id] [int] IDENTITY(1,1) NOT NULL,
	[city_id] [int] NULL,
	[country_id] [int] NULL,
	[state_id] [int] NULL,
	[street] [varchar](100) NULL,
	[zip_code] [int] NULL,
 CONSTRAINT [PK__Address__CAA247C89C16635E] PRIMARY KEY CLUSTERED 
(
	[address_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Branch]    Script Date: 4/30/2016 11:45:28 PM ******/
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
/****** Object:  Table [dbo].[City]    Script Date: 4/30/2016 11:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[City](
	[city_id] [int] IDENTITY(1,1) NOT NULL,
	[city_name] [varchar](25) NULL,
PRIMARY KEY CLUSTERED 
(
	[city_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Company]    Script Date: 4/30/2016 11:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Company](
	[address_id] [int] NULL,
	[company_id] [int] IDENTITY(1,1) NOT NULL,
	[company_name] [varchar](50) NULL,
	[phone_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[company_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Country]    Script Date: 4/30/2016 11:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Country](
	[country_id] [int] IDENTITY(1,1) NOT NULL,
	[country_name] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[country_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 4/30/2016 11:45:28 PM ******/
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
	[first_name] [varchar](25) NULL,
	[last_name] [varchar](25) NULL,
PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CustomerRelease]    Script Date: 4/30/2016 11:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CustomerRelease](
	[changelog] [varchar](200) NULL,
	[customer_release_id] [int] IDENTITY(1,1) NOT NULL,
	[development_release_id] [int] NULL,
	[download_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[customer_release_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Date]    Script Date: 4/30/2016 11:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Date](
	[date_id] [int] IDENTITY(1,1) NOT NULL,
	[date_day] [tinyint] NULL,
	[date_month] [tinyint] NULL,
	[date_year] [smallint] NULL,
PRIMARY KEY CLUSTERED 
(
	[date_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DevelopmentRelease]    Script Date: 4/30/2016 11:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DevelopmentRelease](
	[development_release_id] [int] IDENTITY(1,1) NOT NULL,
	[development_release_number] [int] NULL,
	[feature_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[development_release_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Download]    Script Date: 4/30/2016 11:45:28 PM ******/
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
PRIMARY KEY CLUSTERED 
(
	[download_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Feature]    Script Date: 4/30/2016 11:45:28 PM ******/
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
	[version] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[feature_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FeatureVersion]    Script Date: 4/30/2016 11:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FeatureVersion](
	[feature_id] [int] NOT NULL,
	[version] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[feature_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Iteration]    Script Date: 4/30/2016 11:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Iteration](
	[branch_id] [int] NULL,
	[iteration_id] [int] IDENTITY(1,1) NOT NULL,
	[iteration_number] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[iteration_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Phone]    Script Date: 4/30/2016 11:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Phone](
	[phone_id] [int] NOT NULL,
	[phone_number] [int] NULL,
	[phone_type_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[phone_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PhoneType]    Script Date: 4/30/2016 11:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PhoneType](
	[phone_type] [varchar](25) NULL,
	[phone_type_id] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[phone_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Product]    Script Date: 4/30/2016 11:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product](
	[product_description] [varchar](500) NULL,
	[product_id] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sample data]    Script Date: 4/30/2016 11:45:28 PM ******/
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
/****** Object:  Table [dbo].[SoftwarePlatform]    Script Date: 4/30/2016 11:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SoftwarePlatform](
	[software_platform_id] [int] IDENTITY(1,1) NOT NULL,
	[software_platform_name] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[software_platform_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[State]    Script Date: 4/30/2016 11:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[State](
	[state_id] [int] IDENTITY(1,1) NOT NULL,
	[state_name] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[state_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
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
ALTER TABLE [dbo].[CustomerRelease]  WITH CHECK ADD  CONSTRAINT [FK_CustomerRelease_Download] FOREIGN KEY([download_id])
REFERENCES [dbo].[Download] ([download_id])
GO
ALTER TABLE [dbo].[CustomerRelease] CHECK CONSTRAINT [FK_CustomerRelease_Download]
GO
ALTER TABLE [dbo].[DevelopmentRelease]  WITH CHECK ADD  CONSTRAINT [FK_DevelopmentRelease_Feature] FOREIGN KEY([feature_id])
REFERENCES [dbo].[Feature] ([feature_id])
GO
ALTER TABLE [dbo].[DevelopmentRelease] CHECK CONSTRAINT [FK_DevelopmentRelease_Feature]
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
ALTER TABLE [dbo].[Download]  WITH CHECK ADD  CONSTRAINT [FK_Download_Date] FOREIGN KEY([date_id])
REFERENCES [dbo].[Date] ([date_id])
GO
ALTER TABLE [dbo].[Download] CHECK CONSTRAINT [FK_Download_Date]
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
ALTER TABLE [dbo].[Feature]  WITH CHECK ADD  CONSTRAINT [FK_Feature_Product] FOREIGN KEY([product_id])
REFERENCES [dbo].[Product] ([product_id])
GO
ALTER TABLE [dbo].[Feature] CHECK CONSTRAINT [FK_Feature_Product]
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
