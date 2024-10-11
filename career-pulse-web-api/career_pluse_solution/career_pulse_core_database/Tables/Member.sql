CREATE TABLE [dbo].[Member]
(
	[MemberId] INT IDENTITY,
	[UserName] NVARCHAR(MAX) NULL,
	[Password] NVARCHAR(MAX) NULL,
	[PasswordSalt] NVARCHAR(MAX) NULL,
	[ActivationCode] INT NULL,
	[MemberTypeEnum] INT NULL,
	[FullName] NVARCHAR(MAX) NULL,
	[Email] NVARCHAR(MAX) NULL,
	[ProfileImageUrl] NVARCHAR(MAX) NULL,
	[CreatedDate] DATETIME,
	[IsDeleted] BIT DEFAULT 0,
	[IsActive] BIT DEFAULT 1,
	[MemberGlobalIdentity] UNIQUEIDENTIFIER NULL,

	CONSTRAINT [Member_MemberId_PK] PRIMARY KEY CLUSTERED ([MemberId])
)
