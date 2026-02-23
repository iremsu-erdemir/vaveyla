IF NOT EXISTS (SELECT 1 FROM sys.databases WHERE name = 'VaveylaDb')
BEGIN
    CREATE DATABASE VaveylaDb;
END
GO

USE VaveylaDb;
GO

IF OBJECT_ID('dbo.Users', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Users
    (
        UserId UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
        FullName NVARCHAR(120) NOT NULL,
        Email NVARCHAR(256) NOT NULL,
        PasswordHash NVARCHAR(200) NOT NULL,
        Role TINYINT NOT NULL,
        CreatedAtUtc DATETIME2 NOT NULL
            CONSTRAINT DF_Users_CreatedAtUtc DEFAULT SYSUTCDATETIME(),
        CONSTRAINT CK_Users_Role CHECK (Role IN (1, 2, 3))
    );

    CREATE UNIQUE INDEX UX_Users_Email ON dbo.Users (Email);
END
GO
