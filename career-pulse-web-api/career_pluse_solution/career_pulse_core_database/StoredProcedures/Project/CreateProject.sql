CREATE PROCEDURE [dbo].[CreateProject]
	@jsonString NVARCHAR(MAX) = '',
	@executionStatus BIT OUT
	WITH ENCRYPTION
AS
BEGIN

	INSERT INTO [Project]([CollaboratorId], [ProjectName], [ProjectDescription], [ProjectStatusEnum], [StartDate], [EndDate], [ProjectDocumentUrl], [ProjectGlobalIdentity])
	SELECT [CollaboratorId], [ProjectName], [ProjectDescription], [ProjectStatusEnum], [StartDate], [EndDate], [ProjectDocumentUrl], [ProjectGlobalIdentity]
	FROM OPENJSON(@jsonString, '$')
	WITH(
		[CollaboratorId] INT,
		[ProjectName] NVARCHAR(MAX),
		[ProjectDescription] NVARCHAR(MAX),
		[ProjectStatusEnum] INT,
		[StartDate] DATETIME,
		[EndDate] DATETIME,
		[ProjectDocumentUrl] NVARCHAR(MAX),
		[ProjectGlobalIdentity] UNIQUEIDENTIFIER
	);

	SET @executionStatus = 1;

END
