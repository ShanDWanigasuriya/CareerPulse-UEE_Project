CREATE PROCEDURE [dbo].[CreateJob]
	@jsonString NVARCHAR(MAX) = '',
	@executionStatus BIT OUT
	WITH ENCRYPTION
AS
BEGIN

	INSERT INTO [Job]([PostedMemberId], [JobTitle], [JobDecription], [JobTypeEnum], [DocumentUrl], [JobImageUrl])
	SELECT [PostedMemberId], [JobTitle], [JobDecription], [JobTypeEnum], [DocumentUrl], [JobImageUrl]
	FROM OPENJSON(@jsonString, '$')
	WITH(
		[PostedMemberId] INT,
		[JobTitle] NVARCHAR(MAX),
		[JobDecription] NVARCHAR(MAX),
		[JobTypeEnum] NVARCHAR(MAX),
		[DocumentUrl] NVARCHAR(MAX),
		[JobImageUrl] NVARCHAR(MAX)
	);

	SET @executionStatus = 1;

END