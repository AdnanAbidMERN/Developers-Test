﻿/*
Deployment script for ShipmentDB

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "ShipmentDB"
:setvar DefaultFilePrefix "ShipmentDB"
:setvar DefaultDataPath "C:\Users\DEll\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"
:setvar DefaultLogPath "C:\Users\DEll\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creating database $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Creating Table [dbo].[CARRIER]...';


GO
CREATE TABLE [dbo].[CARRIER] (
    [carrier_id]   INT           NOT NULL,
    [carrier_name] VARCHAR (100) NOT NULL,
    [carrier_mode] VARCHAR (25)  NOT NULL,
    CONSTRAINT [PK_CARRIER] PRIMARY KEY CLUSTERED ([carrier_id] ASC) ON [PRIMARY]
) ON [PRIMARY];


GO
PRINT N'Creating Table [dbo].[SHIPMENT]...';


GO
CREATE TABLE [dbo].[SHIPMENT] (
    [shipment_id]          INT             NOT NULL,
    [shipper_id]           INT             NOT NULL,
    [shipment_description] VARCHAR (100)   NOT NULL,
    [shipment_weight]      NUMERIC (18, 2) NOT NULL,
    [shipment_rate_id]     INT             NOT NULL,
    [carrier_id]           INT             NOT NULL,
    CONSTRAINT [PK_SHIPMENT] PRIMARY KEY CLUSTERED ([shipment_id] ASC) ON [PRIMARY]
) ON [PRIMARY];


GO
PRINT N'Creating Table [dbo].[SHIPMENT_RATE]...';


GO
CREATE TABLE [dbo].[SHIPMENT_RATE] (
    [shipment_rate_id]          INT          NOT NULL,
    [shipment_rate_class]       VARCHAR (10) NOT NULL,
    [shipment_rate_description] VARCHAR (25) NOT NULL,
    CONSTRAINT [PK_SHIPMENT_RATE] PRIMARY KEY CLUSTERED ([shipment_rate_id] ASC) ON [PRIMARY]
) ON [PRIMARY];


GO
PRINT N'Creating Table [dbo].[SHIPPER]...';


GO
CREATE TABLE [dbo].[SHIPPER] (
    [shipper_id]   INT           NOT NULL,
    [shipper_name] VARCHAR (100) NOT NULL,
    CONSTRAINT [PK_SHIPPER] PRIMARY KEY CLUSTERED ([shipper_id] ASC) ON [PRIMARY]
) ON [PRIMARY];


GO
PRINT N'Creating Procedure [dbo].[Shipper_Shipment_Details]...';


GO
CREATE PROCEDURE [dbo].[Shipper_Shipment_Details]
@shipper_id INT
AS
BEGIN
  SELECT
    s.shipment_id,
    sh.shipper_name,
    c.carrier_name,
    s.shipment_description,
    s.shipment_weight,
    sr.shipment_rate_description
  FROM SHIPMENT 
  INNER JOIN SHIPPER sh ON s.shipper_id = sh.shipper_id
  INNER JOIN CARRIER c ON s.carrier_id = c.carrier_id
  INNER JOIN SHIPMENT_RATE sr ON s.shipment_rate_id = sr.shipment_rate_id
  WHERE sh.shipper_id = @shipper_id;
END;
GO
PRINT N'Creating Procedure [dbo].[spShipper_GetAll]...';


GO
CREATE PROCEDURE [dbo].[spShipper_GetAll]
AS
begin
	select * from dbo.[SHIPPER]
end
GO
-- Create tables
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SHIPMENT]') AND type in (N'U'))
ALTER TABLE [dbo].[SHIPMENT] DROP CONSTRAINT IF EXISTS [FK_SHIPMENT_SHIPPER]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SHIPMENT]') AND type in (N'U'))
ALTER TABLE [dbo].[SHIPMENT] DROP CONSTRAINT IF EXISTS [FK_SHIPMENT_SHIPMENT_RATE]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SHIPMENT]') AND type in (N'U'))
ALTER TABLE [dbo].[SHIPMENT] DROP CONSTRAINT IF EXISTS [FK_SHIPMENT_CARRIER]
GO
/****** Object:  Table [dbo].[SHIPPER]    Script Date: 3/8/2023 4:18:20 PM ******/
DROP TABLE IF EXISTS [dbo].[SHIPPER]
GO
/****** Object:  Table [dbo].[SHIPMENT_RATE]    Script Date: 3/8/2023 4:18:20 PM ******/
DROP TABLE IF EXISTS [dbo].[SHIPMENT_RATE]
GO
/****** Object:  Table [dbo].[SHIPMENT]    Script Date: 3/8/2023 4:18:20 PM ******/
DROP TABLE IF EXISTS [dbo].[SHIPMENT]
GO
/****** Object:  Table [dbo].[CARRIER]    Script Date: 3/8/2023 4:18:20 PM ******/
DROP TABLE IF EXISTS [dbo].[CARRIER]
GO
/****** Object:  Table [dbo].[CARRIER]    Script Date: 3/8/2023 4:18:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CARRIER](
	[carrier_id] [int] NOT NULL,
	[carrier_name] [varchar](100) NOT NULL,
	[carrier_mode] [varchar](25) NOT NULL,
 CONSTRAINT [PK_CARRIER] PRIMARY KEY CLUSTERED 
(
	[carrier_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SHIPMENT]    Script Date: 3/8/2023 4:18:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SHIPMENT](
	[shipment_id] [int] NOT NULL,
	[shipper_id] [int] NOT NULL,
	[shipment_description] [varchar](100) NOT NULL,
	[shipment_weight] [numeric](18, 2) NOT NULL,
	[shipment_rate_id] [int] NOT NULL,
	[carrier_id] [int] NOT NULL,
 CONSTRAINT [PK_SHIPMENT] PRIMARY KEY CLUSTERED 
(
	[shipment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SHIPMENT_RATE]    Script Date: 3/8/2023 4:18:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SHIPMENT_RATE](
	[shipment_rate_id] [int] NOT NULL,
	[shipment_rate_class] [varchar](10) NOT NULL,
	[shipment_rate_description] [varchar](25) NOT NULL
 CONSTRAINT [PK_SHIPMENT_RATE] PRIMARY KEY CLUSTERED 
(
	[shipment_rate_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SHIPPER]    Script Date: 3/8/2023 4:18:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SHIPPER](
	[shipper_id] [int] NOT NULL,
	[shipper_name] [varchar](100) NOT NULL,
 CONSTRAINT [PK_SHIPPER] PRIMARY KEY CLUSTERED 
(
	[shipper_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SHIPMENT]  WITH CHECK ADD  CONSTRAINT [FK_SHIPMENT_CARRIER] FOREIGN KEY([carrier_id])
REFERENCES [dbo].[CARRIER] ([carrier_id])
GO
ALTER TABLE [dbo].[SHIPMENT] CHECK CONSTRAINT [FK_SHIPMENT_CARRIER]
GO
ALTER TABLE [dbo].[SHIPMENT]  WITH CHECK ADD  CONSTRAINT [FK_SHIPMENT_SHIPMENT_RATE] FOREIGN KEY([shipment_rate_id])
REFERENCES [dbo].[SHIPMENT_RATE] ([shipment_rate_id])
GO
ALTER TABLE [dbo].[SHIPMENT] CHECK CONSTRAINT [FK_SHIPMENT_SHIPMENT_RATE]
GO
ALTER TABLE [dbo].[SHIPMENT]  WITH CHECK ADD  CONSTRAINT [FK_SHIPMENT_SHIPPER] FOREIGN KEY([shipper_id])
REFERENCES [dbo].[SHIPPER] ([shipper_id])
GO
ALTER TABLE [dbo].[SHIPMENT] CHECK CONSTRAINT [FK_SHIPMENT_SHIPPER]
GO
-- Create tables


-- Insert data into dbo.SHIPPER
if not exists (select 1 from dbo.[SHIPPER])
begin
INSERT INTO dbo.SHIPPER (shipper_id, shipper_name) VALUES (1, 'Blossom Manufacturing')
INSERT INTO dbo.SHIPPER (shipper_id, shipper_name) VALUES (2, 'Sporting Partners')
INSERT INTO dbo.SHIPPER (shipper_id, shipper_name) VALUES (3, 'Associates and Company')
end
-- Insert data into dbo.CARRIER
if not exists (select 1 from dbo.[CARRIER])
begin
INSERT INTO dbo.CARRIER (carrier_id, carrier_name, carrier_mode) VALUES (1, 'Short Line RailRoad', 'RAIL')
INSERT INTO dbo.CARRIER (carrier_id, carrier_name, carrier_mode) VALUES (2, 'Planet Express', 'TRUCK')
INSERT INTO dbo.CARRIER (carrier_id, carrier_name, carrier_mode) VALUES (3, 'Greene Transport', 'TRUCK')
INSERT INTO dbo.CARRIER (carrier_id, carrier_name, carrier_mode) VALUES (4, 'Big Boats R Us', 'OCEAN')
INSERT INTO dbo.CARRIER (carrier_id, carrier_name, carrier_mode) VALUES (5, 'Speedy Delivery', 'TRUCK')
end

-- Insert data into dbo.SHIPMENT_RATE
if not exists (select 1 from dbo.[SHIPMENT_RATE])
begin
INSERT INTO dbo.SHIPMENT_RATE (shipment_rate_id, shipment_rate_class, shipment_rate_description) VALUES (1, 'FULL', 'Full Price')
INSERT INTO dbo.SHIPMENT_RATE (shipment_rate_id, shipment_rate_class, shipment_rate_description) VALUES (2, '50OFF', '50% Discount')
INSERT INTO dbo.SHIPMENT_RATE (shipment_rate_id, shipment_rate_class, shipment_rate_description) VALUES (3, '10OFF', '10% Discount')
end

-- Insert data into dbo.SHIPMENT
if not exists (select 1 from dbo.[SHIPMENT])
begin
INSERT INTO dbo.SHIPMENT (shipment_id, shipper_id, shipment_description, shipment_weight, shipment_rate_id, carrier_id)
	VALUES (1, 1, 'Machine Parts', 130.54, 1, 1)
INSERT INTO dbo.SHIPMENT (shipment_id, shipper_id, shipment_description, shipment_weight, shipment_rate_id, carrier_id)
	VALUES (2, 3, 'Office Supplies', 10.05, 2, 3)
INSERT INTO dbo.SHIPMENT (shipment_id, shipper_id, shipment_description, shipment_weight, shipment_rate_id, carrier_id)
	VALUES (3, 2, 'Basketball Hoops', 13.4, 2, 4)
INSERT INTO dbo.SHIPMENT (shipment_id, shipper_id, shipment_description, shipment_weight, shipment_rate_id, carrier_id)
	VALUES (4, 2, 'Football Helmets', 25.98, 2, 2)
INSERT INTO dbo.SHIPMENT (shipment_id, shipper_id, shipment_description, shipment_weight, shipment_rate_id, carrier_id)
	VALUES (5, 1, 'Conveyor System', 250.10, 1, 5)
INSERT INTO dbo.SHIPMENT (shipment_id, shipper_id, shipment_description, shipment_weight, shipment_rate_id, carrier_id)
	VALUES (6, 3, 'Automobile Engines', 65.25, 3, 2)
end
GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Update complete.';


GO
