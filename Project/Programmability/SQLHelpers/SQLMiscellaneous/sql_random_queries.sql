INSERT INTO dbo.Product (product_description)
VALUES ('First Description');

INSERT INTO dbo.Product (product_description)
VALUES ('Second Description');

INSERT INTO dbo.SoftwarePlatform (software_platform_name)
VALUES ('Windows')

INSERT INTO dbo.SoftwarePlatform (software_platform_name)
VALUES ('OSX')

INSERT INTO dbo.SoftwarePlatform (software_platform_name)
VALUES ('Linux')

INSERT INTO dbo.Version (version_number, software_platform_id, product_id)
VALUES (1,1,1);

INSERT INTO dbo.Version (version_number, software_platform_id, product_id)
VALUES (2,1,1);

INSERT INTO dbo.Version (version_number, software_platform_id, product_id)
VALUES (2.1,1,1);

INSERT INTO dbo.Version (version_number, software_platform_id, product_id)
VALUES (2,2,2);

INSERT INTO dbo.Version (version_number, software_platform_id, product_id)
VALUES (3.5,2,2);

SELECT * FROM dbo.PRODUCT;

SELECT * FROM dbo.SoftwarePlatform;

SELECT * FROM dbo.Version;

SELECT * FROM dbo.Version
WHERE version_id = 2;

--get product_description for associated version

SELECT product_description
FROM dbo.Product
WHERE product_id 
= 
(SELECT product_id FROM dbo.Version
WHERE version_id = 3)

SELECT product_id FROM dbo.Version

DELETE FROM Version
WHERE version_id = 5;

UPDATE dbo.Version
SET version_number = 4
WHERE version_number=
(SELECT MAX(version_number)
FROM dbo.Version
WHERE product_id = 1);


SELECT * FROM dbo.Version
WHERE version_number
=
(SELECT MAX(version_number)
FROM dbo.Version
WHERE product_id = 1);

SELECT * FROM dbo.Version;
EXEC UpdateVersion @product_id = 1, @new_version_number = 26;

IF 
(SELECT COUNT(*) FROM dbo.Product
WHERE product_id = 1) = 0
PRINT 'No matching product_id in the Product table!';
ELSE
PRINT 'All good'