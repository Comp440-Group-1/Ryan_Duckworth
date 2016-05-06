--Database Backup Script
--Purpose: The purpose of this script is to provide a simple way to backup the s16guest06 database so that in the
--         event of a disaster, the database can be recovered intact. Backups should be performed at least weekly,
--		   if not more, to ensure that key data coming into this low volume database is not at risk of being lost.
--Issues:  This script uses the server's internal filesystem so it won't work. However, it's purpose is to illustrate
--         how it could be used in a disaster scenario.

DECLARE @filename VARCHAR(20)
DECLARE @filepath VARCHAR(100)
DECLARE @backup_date VARCHAR(10)

SET @filepath = 'C:\SQL_Backups\'

SET @backup_date = CONVERT(VARCHAR(20),GETDATE())

BEGIN

SET @filename = @filepath + @backup_date+'_database_backup.BAK'

BACKUP DATABASE s16guest06 TO DISK = @filename

END