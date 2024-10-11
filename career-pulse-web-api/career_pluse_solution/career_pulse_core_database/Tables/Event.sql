CREATE TABLE [dbo].[Event]
(
	[EventId] INT IDENTITY NOT NULL PRIMARY KEY,
	[PostedMemberId] INT NULL,
	[EventTitle] NVARCHAR(MAX) NULL,
	[EventDescription] NVARCHAR(MAX) NULL,
	[EventVenueEnm] NVARCHAR(MAX) NULL,
	[EventLink] NVARCHAR(MAX) NULL,
	[EventDocumentUrl] NVARCHAR(MAX) NULL,
	[StartDate] DATETIME NULL,
	[EndDate] DATETIME NULL,
	[IsPublic] BIT DEFAULT 1,
	[IsDeleted] BIT DEFAULT 0
)
