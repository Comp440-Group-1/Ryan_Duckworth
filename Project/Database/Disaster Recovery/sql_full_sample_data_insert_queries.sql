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