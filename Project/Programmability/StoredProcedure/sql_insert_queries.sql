--full insert into State
DELETE FROM dbo.State
DBCC CHECKIDENT ( State,RESEED, 0)
INSERT INTO dbo.State (state_name) VALUES ('California')
INSERT INTO dbo.State (state_name) VALUES ('Oregon')
INSERT INTO dbo.State (state_name) VALUES ('New York')
SELECT * FROM dbo.State

--full insert into City
DELETE FROM dbo.City
DBCC CHECKIDENT ( City,RESEED, 0)
INSERT INTO dbo.City (city_name) VALUES ('Los Angeles')
INSERT INTO dbo.City (city_name) VALUES ('London')
INSERT INTO dbo.City (city_name) VALUES ('New York')
SELECT * FROM dbo.City

--full insert into Country
DELETE FROM dbo.Country
DBCC CHECKIDENT ( Country,RESEED, 0)
INSERT INTO dbo.Country (country_name) VALUES ('United States')
INSERT INTO dbo.Country (country_name) VALUES ('England')
INSERT INTO dbo.Country (country_name) VALUES ('Canada')
SELECT * FROM dbo.Country

--full insert into Address
DELETE FROM dbo.Address
DBCC CHECKIDENT ( Address,RESEED, 0)
INSERT INTO dbo.Address (street, city_id, state_id, country_id, zip_code) VALUES ('123 Privet Street', 1, 1, 1, 91601)
INSERT INTO dbo.Address (street, city_id, state_id, country_id, zip_code) VALUES ('348 Jinx Road', 2, NULL, 2, NULL)
INSERT INTO dbo.Address (street, city_id, state_id, country_id, zip_code) VALUES ('77777 Devonshire Street', 1, 1, 1, 91344)
SELECT * FROM dbo.Address

--full insert into PhoneType
DELETE FROM dbo.PhoneType
DBCC CHECKIDENT ( PhoneType,RESEED, 0)
INSERT INTO dbo.PhoneType (phone_type) VALUES ('home')
INSERT INTO dbo.PhoneType (phone_type) VALUES ('work')
INSERT INTO dbo.PhoneType (phone_type) VALUES ('mobile')
SELECT * FROM dbo.PhoneType

--full insert into Phone
DELETE FROM dbo.Phone
DBCC CHECKIDENT ( Phone,RESEED, 0)
INSERT INTO dbo.Phone (phone_number, phone_type_id) VALUES ('123-485-8973', 2)
INSERT INTO dbo.Phone (phone_number, phone_type_id) VALUES ('1-28-397863896', 2)
INSERT INTO dbo.Phone (phone_number, phone_type_id) VALUES ('179-397-87968', 3)
INSERT INTO dbo.Phone (phone_number, phone_type_id) VALUES ('178-763-98764', 3)
SELECT * FROM dbo.Phone

--full insert into Company
--need to change company address_id because of data already in table
DELETE FROM dbo.Company
DBCC CHECKIDENT ( Company,RESEED, 0)
INSERT INTO dbo.Company (address_id, company_name, phone_id) VALUES (1, 'ABC records', 1)
INSERT INTO dbo.Company (address_id, company_name, phone_id) VALUES (2, 'ZYX Corp', 2)
INSERT INTO dbo.Company (address_id, company_name, phone_id) VALUES (NULL, '99 Store', 3)
INSERT INTO dbo.Company (address_id, company_name, phone_id) VALUES (NULL, '99 Store', 4)
SELECT * FROM dbo.Company

--full insert into Customer
--need to change company_id address id because of data already in table
DELETE FROM dbo.Customer
DBCC CHECKIDENT ( Customer,RESEED, 0)
INSERT INTO dbo.Customer (company_id, email, first_name, last_name) VALUES (1, 'p.smith@abc.com', 'Peter', 'Smith')
INSERT INTO dbo.Customer (company_id, email, first_name, last_name) VALUES (2, 'maria@zyx.com', 'Maria', 'Bounte')
INSERT INTO dbo.Customer (company_id, email, first_name, last_name) VALUES (3, 'david.sommerset@99cents.store', 'David', 'Sommerset')
INSERT INTO dbo.Customer (company_id, email, first_name, last_name) VALUES (4, 'maria.bounte@99cents.store', 'Maria', 'Bounte')
SELECT * FROM dbo.Customer

--full insert into SoftwarePlatform
DELETE FROM dbo.SoftwarePlatform
DBCC CHECKIDENT ( SoftwarePlatform,RESEED, 0)
INSERT INTO dbo.SoftwarePlatform (software_platform_name) VALUES ('Windows')
INSERT INTO dbo.SoftwarePlatform (software_platform_name) VALUES ('OSX')
INSERT INTO dbo.SoftwarePlatform (software_platform_name) VALUES ('Linux')
SELECT * FROM dbo.SoftwarePlatform

--full insert into Feature
--SELECT * FROM dbo.FeatureVersion
DELETE FROM dbo.Feature
DBCC CHECKIDENT ( Feature,RESEED, 0)
INSERT INTO dbo.Feature (feature_description, bugfix) VALUES ('login module', 0)
INSERT INTO dbo.Feature (feature_description, bugfix) VALUES ('patient registration', 0)
INSERT INTO dbo.Feature (feature_description, bugfix) VALUES ('patient profile', 0)
INSERT INTO dbo.Feature (feature_description, bugfix) VALUES ('patient release form', 0)
INSERT INTO dbo.Feature (feature_description, bugfix) VALUES ('physician profile', 0)
INSERT INTO dbo.Feature (feature_description, bugfix) VALUES ('address verification', 0)
--INSERT INTO dbo.Feature (feature_description, bugfix) VALUES ('login module', 0)
--INSERT INTO dbo.Feature (feature_description, bugfix) VALUES ('patient registration', 0)
--INSERT INTO dbo.Feature (feature_description, bugfix) VALUES ('patient profile', 0)
--INSERT INTO dbo.Feature (feature_description, bugfix) VALUES ('patient release form', 0)
--INSERT INTO dbo.Feature (feature_description, bugfix) VALUES ('physician profile', 0)
--INSERT INTO dbo.Feature (feature_description, bugfix) VALUES ('address verification', 0)
INSERT INTO dbo.Feature (feature_description, bugfix) VALUES ('patient authentication', 0)
INSERT INTO dbo.Feature (feature_description, bugfix) VALUES ('patient medication form', 0)
INSERT INTO dbo.Feature (feature_description, bugfix) VALUES ('patient e-bill', 0)
INSERT INTO dbo.Feature (feature_description, bugfix) VALUES ('patient reporting', 0)
INSERT INTO dbo.Feature (feature_description, bugfix) VALUES ('patient reporting bug fix', 1)
SELECT * FROM dbo.Feature

--full insert into Product
DELETE FROM dbo.Product
DBCC CHECKIDENT ( Product,RESEED, 0)
INSERT INTO dbo.Product (product_name, product_description) VALUES ('EHR System', 'health records system for the patients')
SELECT * FROM dbo.Product

--full insert into Version
DELETE FROM dbo.Version
DBCC CHECKIDENT ( Version,RESEED, 0)
INSERT INTO dbo.Version (version_number, software_platform_id, product_id) VALUES (1.1, 1, 1)
INSERT INTO dbo.Version (version_number, software_platform_id, product_id) VALUES (1.2, 3, 1)
INSERT INTO dbo.Version (version_number, software_platform_id, product_id) VALUES (1.1, 3, 1)
INSERT INTO dbo.Version (version_number, software_platform_id, product_id) VALUES (2.1, 1, 1)
INSERT INTO dbo.Version (version_number, software_platform_id, product_id) VALUES (2.2, 3, 1)
SELECT * FROM dbo.Version

--full insert into FeatureVersion
DELETE FROM dbo.FeatureVersion
INSERT INTO dbo.FeatureVersion (version_id, feature_id) VALUES (1, 1)
INSERT INTO dbo.FeatureVersion (version_id, feature_id) VALUES (1, 2)
INSERT INTO dbo.FeatureVersion (version_id, feature_id) VALUES (1, 3)
INSERT INTO dbo.FeatureVersion (version_id, feature_id) VALUES (1, 4)
INSERT INTO dbo.FeatureVersion (version_id, feature_id) VALUES (1, 5)
INSERT INTO dbo.FeatureVersion (version_id, feature_id) VALUES (1, 6)

INSERT INTO dbo.FeatureVersion (version_id, feature_id) VALUES (2, 1)
INSERT INTO dbo.FeatureVersion (version_id, feature_id) VALUES (2, 2)
INSERT INTO dbo.FeatureVersion (version_id, feature_id) VALUES (2, 3)
INSERT INTO dbo.FeatureVersion (version_id, feature_id) VALUES (2, 4)
INSERT INTO dbo.FeatureVersion (version_id, feature_id) VALUES (2, 5)

INSERT INTO dbo.FeatureVersion (version_id, feature_id) VALUES (3, 6)

INSERT INTO dbo.FeatureVersion (version_id, feature_id) VALUES (4, 7)
INSERT INTO dbo.FeatureVersion (version_id, feature_id) VALUES (4, 8)
INSERT INTO dbo.FeatureVersion (version_id, feature_id) VALUES (4, 9)
INSERT INTO dbo.FeatureVersion (version_id, feature_id) VALUES (4, 10)

INSERT INTO dbo.FeatureVersion (version_id, feature_id) VALUES (5, 7)
INSERT INTO dbo.FeatureVersion (version_id, feature_id) VALUES (5, 8)
INSERT INTO dbo.FeatureVersion (version_id, feature_id) VALUES (5, 9)
INSERT INTO dbo.FeatureVersion (version_id, feature_id) VALUES (5, 10)
INSERT INTO dbo.FeatureVersion (version_id, feature_id) VALUES (5, 11)
SELECT * FROM dbo.FeatureVersion

--full insert into DevelopmentRelease
DELETE FROM dbo.DevelopmentRelease
DBCC CHECKIDENT ( DevelopmentRelease,RESEED, 0)
INSERT INTO dbo.DevelopmentRelease (development_release_number, version_id, product_id) VALUES (1.1, 1, 1)
INSERT INTO dbo.DevelopmentRelease (development_release_number, version_id, product_id) VALUES (1.1, 3, 1)
INSERT INTO dbo.DevelopmentRelease (development_release_number, version_id, product_id) VALUES (1.1, 2, 1)
INSERT INTO dbo.DevelopmentRelease (development_release_number, version_id, product_id) VALUES (2.1, 4, 1)
INSERT INTO dbo.DevelopmentRelease (development_release_number, version_id, product_id) VALUES (2.1, 5, 1)
INSERT INTO dbo.DevelopmentRelease (development_release_number, version_id, product_id) VALUES (2.2, 5, 1)
SELECT * FROM dbo.DevelopmentRelease

--full insert into CustomerRelease
DELETE FROM dbo.CustomerRelease
DBCC CHECKIDENT ( CustomerRelease,RESEED, 0)
INSERT INTO dbo.CustomerRelease (development_release_id, customer_release_date, type_of_release) VALUES (1, '2000-01-01', 'new product release')
INSERT INTO dbo.CustomerRelease (development_release_id, customer_release_date, type_of_release) VALUES (2, '2000-01-01', 'new product release')
INSERT INTO dbo.CustomerRelease (development_release_id, customer_release_date, type_of_release) VALUES (3, '2000-01-01', 'new product release')
INSERT INTO dbo.CustomerRelease (development_release_id, customer_release_date, type_of_release) VALUES (4, '2000-05-01', 'new features release')
INSERT INTO dbo.CustomerRelease (development_release_id, customer_release_date, type_of_release) VALUES (5, '2000-05-01', 'new features release')
INSERT INTO dbo.CustomerRelease (development_release_id, customer_release_date, type_of_release) VALUES (6, '2000-06-13', 'bug fix release')
SELECT * FROM dbo.CustomerRelease

--full insert into Download
DELETE FROM dbo.Download
DBCC CHECKIDENT ( Download,RESEED, 0)
INSERT INTO dbo.Download (customer_id, customer_release_id, download_link, product_id, download_date) VALUES (1, 4, 'test_url1', 1, '2000-06-01')
INSERT INTO dbo.Download (customer_id, customer_release_id, download_link, product_id, download_date) VALUES (2, 4, 'test_url1', 1, '2000-03-01')
INSERT INTO dbo.Download (customer_id, customer_release_id, download_link, product_id, download_date) VALUES (3, 6, 'test_url2', 1, '2000-07-01')
INSERT INTO dbo.Download (customer_id, customer_release_id, download_link, product_id, download_date) VALUES (4, 6, 'test_url2', 1, '2000-09-01')
SELECT * FROM dbo.Download

INSERT INTO dbo.Version (version_number, software_platform_id, product_id)
VALUES (3.4,2,1);

SELECT * FROM dbo.Version

--full insert into FeatureVersion
INSERT INTO dbo.FeatureVersion (version_id, feature_id)
VALUES (12, 7)

SELECT * FROM dbo.FeatureVersion
SELECT * FROM dbo.Version
SELECT * FROM dbo.Feature

SELECT * FROM dbo.Feature
WHERE feature_id = 
(SELECT feature_id FROM dbo.FeatureVersion
WHERE version_id  = 2);


--Join of Feature and Version table using junction table FeatureVersion
SELECT dbo.Version.*, dbo.Feature.* 
FROM dbo.FeatureVersion
JOIN dbo.Version ON FeatureVersion.version_id = dbo.Version.version_id
JOIN dbo.Feature ON FeatureVersion.feature_id = dbo.Feature.feature_id

SELECT dbo.Version.version_number, dbo.Feature.feature_description, dbo.Version.software_platform_id
FROM dbo.FeatureVersion
JOIN dbo.Version ON FeatureVersion.version_id = dbo.Version.version_id
JOIN dbo.Feature ON FeatureVersion.feature_id = dbo.Feature.feature_id
ORDER BY Version.version_number

SELECT COUNT(*)
FROM dbo.FeatureVersion
JOIN dbo.Version ON FeatureVersion.version_id = dbo.Version.version_id
JOIN dbo.Feature ON FeatureVersion.feature_id = dbo.Feature.feature_id);

--full insert into Date table
INSERT INTO dbo.Date (date_day, date_month, date_year)
VALUES (5, 5, 2016)

INSERT INTO dbo.Date (date_day, date_month, date_year)
VALUES (5, 4, 2016)

SELECT * FROM dbo.Date

--partial insert into Company
INSERT INTO dbo.Company (company_name)
VALUES ('company1');

--update Companyid
UPDATE dbo.Company
SET company_id = 100
WHERE company_id = 1

SELECT * FROM dbo.Company

--full insert into Customer table
INSERT INTO dbo.Customer (company_id, email, first_name, last_name)
VALUES (1, 'first_email', 'Ryan1', 'Duckworth1');

SELECT * FROM dbo.Customer

--Full insert of DevelopmentRelease table
INSERT INTO dbo.DevelopmentRelease(development_release_number, version_id, product_id)
VALUES (1, 2, 1)

SELECT * FROM dbo.DevelopmentRelease

--Full insert of CustomerRelease table
INSERT INTO dbo.CustomerRelease (development_release_id, date_id)
VALUES (1, 2)

SELECT * FROM dbo.CustomerRelease


--full insert into Download table
INSERT INTO dbo.Download (customer_id, customer_release_id, date_id, download_link, software_platform_id, product_id, date)
VALUES (2, 1, 2, 'third_dl_link', 1, 2, '2016-03-17');

INSERT INTO dbo.Download (customer_id, customer_release_id, date_id, download_link, software_platform_id, product_id)
VALUES (2, 1, 2, 'third_dl_link', 1, 2);

SELECT * FROM dbo.Download

DELETE FROM dbo.Download
WHERE download_id = 7


SELECT dbo.Download.*, dbo.Date.date_day, dbo.Date.date_month, dbo.Date.date_year
FROM dbo.Download
JOIN dbo.Date ON dbo.Download.date_id = dbo.Date.date_id

SELECT COUNT(*) as cnt FROM dbo.Download
WHERE dbo.Download.date_id = 0

--Adds count next to record of joined tables
SELECT dbo.Download.*, dbo.Date.date_day, dbo.Date.date_month, dbo.Date.date_year, COUNT(*) as cnt
FROM dbo.Download
JOIN dbo.Date ON dbo.Download.date_id = dbo.Date.date_id
GROUP BY dbo.Download.customer_id, dbo.Download.customer_release_id, dbo.Download.download_id, dbo.Download.download_link, dbo.download.date_id, dbo.Download.software_platform_id, dbo.Download.product_id, dbo.Date.date_day, dbo.Date.date_month, dbo.Date.date_year

SELECT dbo.Download.*, dbo.Date.date_day, dbo.Date.date_month, dbo.Date.date_year
FROM dbo.Download
JOIN dbo.Date ON dbo.Download.date_id = dbo.Date.date_id
WHERE dbo.Download.customer_id = 1
GROUP BY product_id

SELECT dbo.Download.product_id, dbo.Date.date_day, SUM(date_day) as day
FROM dbo.Download
INNER JOIN dbo.Date ON dbo.Download.date_id = dbo.Date.date_id

SELECT MONTH(5);
SELECT GETDATE() AS CurrentDateTime

SELECT DATEPART() AS currentdate;

INSERT INTO date_test (date_column, date_id)
VALUES ('2016-04-03', 1);

INSERT INTO date_test (datetime_column)
VALUES (GETDATE());

SELECT * FROM date_test

SELECT * FROM date_test
WHERE MONTH(date_column) = 5

Select date_id, date_column, MONTH(date_column) AS ReportingMonth, COUNT(date_column) AS count
FROM date_test
--WHERE MONTH(date_column) = 5
GROUP BY date_column, date_id

--user group by product id

SELECT dbo.Download.*, dbo.Date.date_day, dbo.Date.date_month, dbo.Date.date_year, dbo.Product.product_id, dbo.Product.product_description, dbo.Version.version_number
FROM dbo.Download
JOIN dbo.Date ON dbo.Download.date_id = dbo.Date.date_id
JOIN dbo.Product ON dbo.Download.product_id = dbo.Product.product_id
JOIN dbo.CustomerRelease ON dbo.CustomerRelease.customer_release_id = dbo.Download.customer_release_id
JOIN dbo.DevelopmentRelease ON dbo.DevelopmentRelease.development_release_id = dbo.CustomerRelease.development_release_id
JOIN dbo.Version ON dbo.Version.version_id = dbo.DevelopmentRelease.version_id

SELECT * FROM Download
SELECT * FROM CustomerRelease
SELECT * FROM DevelopmentRelease
SELECT * FROM Version

SELECT dbo.Product.product_id, dbo.Product.product_description, dbo.Version.version_number, MONTH(dbo.download.date) AS ReportingMonth, COUNT(dbo.download.date) AS DownloadCount
FROM dbo.Download
JOIN dbo.Date ON dbo.Download.date_id = dbo.Date.date_id
JOIN dbo.Product ON dbo.Download.product_id = dbo.Product.product_id
JOIN dbo.CustomerRelease ON dbo.CustomerRelease.customer_release_id = dbo.Download.customer_release_id
JOIN dbo.DevelopmentRelease ON dbo.DevelopmentRelease.development_release_id = dbo.CustomerRelease.development_release_id
JOIN dbo.Version ON dbo.Version.version_id = dbo.DevelopmentRelease.version_id
GROUP BY MONTH(dbo.download.date), dbo.Product.product_id, dbo.Product.product_description, dbo.Version.version_number

SELECT dbo.Product.product_id, MONTH(dbo.download.date) AS ReportingMonth, COUNT(dbo.download.date) AS count
FROM dbo.Download
JOIN dbo.Date ON dbo.Download.date_id = dbo.Date.date_id
JOIN dbo.Product ON dbo.Download.product_id = dbo.Product.product_id
JOIN dbo.CustomerRelease ON dbo.CustomerRelease.customer_release_id = dbo.Download.customer_release_id
JOIN dbo.DevelopmentRelease ON dbo.DevelopmentRelease.development_release_id = dbo.CustomerRelease.development_release_id
JOIN dbo.Version ON dbo.Version.version_id = dbo.DevelopmentRelease.version_id
GROUP BY MONTH(dbo.download.date), dbo.Product.product_id

SELECT * FROM Product

EXEC GenerateMonthlyReport;

SELECT * FROM Feature
SELECT * FROM Version
SELECT * FROM dbo.FeatureVersion

--given product_id and version_id get version number
DECLARE @v_num AS float;
SELECT @v_num = (SELECT version_number FROM Version
WHERE version_id = 7)
--PRINT @v_num

DECLARE @v_id AS int;
SET @v_id = 7;
DECLARE @new_features AS int
SELECT @new_features =
(SELECT COUNT(*)
FROM dbo.FeatureVersion
JOIN dbo.Version ON FeatureVersion.version_id = dbo.Version.version_id
JOIN dbo.Feature ON FeatureVersion.feature_id = dbo.Feature.feature_id
WHERE dbo.Version.version_number <=@v_num AND dbo.Version.version_number > (CEILING(@v_num) -1) AND dbo.Feature.bugfix = 0)

IF @new_features > 0
PRINT ('There are ' + CAST(@new_features AS VARCHAR(20)) + ' new features in the ' + CAST(@v_num AS VARCHAR(20)) + ' release since the previous release!') 
ELSE
PRINT ('This is a bug fix release, there are no new features in release ' + CAST(@v_num AS VARCHAR(20)));


SELECT * FROM Version
WHERE version_number <= @X AND version_number > (CEILING(@X) -1)

EXEC GetNewFeatures @v_id = 7, @v_id_previous = 2, @product_id = 2

SELECT dbo.Version.*, dbo.Feature.* 
FROM dbo.FeatureVersion
JOIN dbo.Version ON FeatureVersion.version_id = dbo.Version.version_id
JOIN dbo.Feature ON FeatureVersion.feature_id = dbo.Feature.feature_id