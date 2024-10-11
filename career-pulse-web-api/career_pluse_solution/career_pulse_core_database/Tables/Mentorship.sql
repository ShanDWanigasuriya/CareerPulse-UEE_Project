CREATE TABLE [dbo].[Mentorship]
(
	[MentorshipId] INT IDENTITY,
	[MentorId] INT NULL DEFAULT 1,
	[CollaboratorId] INT NULL DEFAULT 1,
	[MentorshipTitle] NVARCHAR(MAX) NULL,
	[MentorshipDescription] NVARCHAR(MAX) NULL,
	[MentorName] NVARCHAR(MAX) NULL,
	[MentorDescription] NVARCHAR(MAX) NULL,
	[MentorExperience] NVARCHAR(MAX) NULL,
	[MentorExpertise] NVARCHAR(MAX) NULL,
	[MentorDocumentUrl] NVARCHAR(MAX) NULL,
	[IsPublic] BIT DEFAULT 1,
	[IsDeleted] BIT DEFAULT 0,
	[IsAvailable] BIT DEFAULT 1,
	[MentorshipGlobalIdentity] UNIQUEIDENTIFIER NULL,

	CONSTRAINT [Mentorship_MentorshipId_PK] PRIMARY KEY CLUSTERED ([MentorshipId])

)
