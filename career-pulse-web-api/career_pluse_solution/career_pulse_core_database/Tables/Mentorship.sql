CREATE TABLE [dbo].[Mentorship]
(
	[MentorshipId] INT IDENTITY,
	[MentorId] INT NULL,
	[MentorshipTitle] NVARCHAR(MAX) NULL,
	[MentorshipDescription] NVARCHAR(MAX) NULL,
	[MentorshipTypeEnum] INT NULL,
	[MentorshipImageUrl] NVARCHAR(MAX) NULL,
	[StartDate] DATETIME NULL,
	[EndDate] DATETIME NULL,
	[IsPublic] BIT DEFAULT 1,
	[IsDeleted] BIT DEFAULT 0,
	[MentorshipGlobalIdentity] UNIQUEIDENTIFIER NULL,

	CONSTRAINT [Mentorship_MentorshipId_PK] PRIMARY KEY CLUSTERED ([MentorshipId])

)
