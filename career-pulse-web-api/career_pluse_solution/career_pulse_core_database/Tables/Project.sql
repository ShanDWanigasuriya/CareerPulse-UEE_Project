CREATE TABLE [dbo].[Project]
(
	[ProjectId] INT IDENTITY NOT NULL,
	[CollaboratorId] INT NULL,
	[ProjectName] NVARCHAR(MAX) NULL,
	[ProjectDescription] NVARCHAR(MAX) NULL,
	[ProjectStatusEnum] INT NULL,
	[StartDate] DATETIME NULL,
	[EndDate] DATETIME NULL,
	[ProjectDocumentUrl] NVARCHAR(MAX) NULL,
	[ProjectGlobalIdentity] UNIQUEIDENTIFIER NULL,
	[IsPublic] BIT DEFAULT 1,
	[IsDeleted] BIT DEFAULT 0	

	CONSTRAINT [Project_ProjectId_PK] PRIMARY KEY CLUSTERED ([ProjectId])
)
