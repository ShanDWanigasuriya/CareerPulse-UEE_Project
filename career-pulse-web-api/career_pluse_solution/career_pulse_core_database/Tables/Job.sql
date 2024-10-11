﻿CREATE TABLE [dbo].[Job]
(
	[JobId] INT IDENTITY NOT NULL PRIMARY KEY,
	[PostedMemberId] INT NULL,
	[JobTitle] NVARCHAR(MAX) NULL,
	[JobDecription] NVARCHAR(MAX) NULL,
	[JobTypeEnum] NVARCHAR(MAX) NULL,
	[DocumentUrl] NVARCHAR(MAX) NULL,
	[JobImageUrl] NVARCHAR(MAX) NULL,
	[IsPublic] BIT DEFAULT 1,
	[IsDeleted] BIT DEFAULT 0
)
