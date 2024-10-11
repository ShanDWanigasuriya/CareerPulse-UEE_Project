CREATE PROCEDURE [dbo].[CreateMember]
	@jsonString NVARCHAR(MAX) = '',
	@executionStatus BIT OUT
	WITH ENCRYPTION
AS
BEGIN

	INSERT INTO [Member]([UserName], [Password], [PasswordSalt], [ActivationCode], [MemberTypeEnum], [FullName], [Email], [ProfileImageUrl], [CreatedDate], [MemberGlobalIdentity])
	SELECT [UserName], [Password], [PasswordSalt], [ActivationCode], [MemberTypeEnum], [FullName], [Email], [ProfileImageUrl], GETUTCDATE(), [MemberGlobalIdentity]
	FROM OPENJSON(@jsonString, '$')
	WITH(
		[UserName] NVARCHAR(MAX),
		[Password] NVARCHAR(MAX),
		[PasswordSalt] NVARCHAR(MAX),
		[ActivationCode] INT,
		[MemberTypeEnum] INT,
		[FullName] NVARCHAR(MAX),
		[Email] NVARCHAR(MAX),
		[ProfileImageUrl] NVARCHAR(MAX),
		[MemberGlobalIdentity] UNIQUEIDENTIFIER
	);

	SET @executionStatus = 1;

END
