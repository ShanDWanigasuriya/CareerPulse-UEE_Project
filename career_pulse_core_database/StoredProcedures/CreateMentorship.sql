CREATE PROCEDURE [dbo].[CreateMentorship]
	@jsonString NVARCHAR(MAX) = '',
	@executionStatus BIT OUT
	WITH ENCRYPTION
AS
BEGIN

	INSERT INTO [Mentorship]([MentorId], [MentorshipTitle], [MentorshipDescription], [MentorshipTypeEnum], [MentorshipImageUrl], [StartDate], [EndDate], [MentorshipGlobalIdentity])
	SELECT [MentorId], [MentorshipTitle], [MentorshipDescription], [MentorshipTypeEnum], [MentorshipImageUrl], [StartDate], [EndDate], [MentorshipGlobalIdentity]
	FROM OPENJSON(@jsonString, '$')
	WITH(
		[MentorId] INT,
		[MentorshipTitle] NVARCHAR(MAX),
		[MentorshipDescription] NVARCHAR(MAX),
		[MentorshipTypeEnum] INT,
		[MentorshipImageUrl] NVARCHAR(MAX),
		[StartDate] DATETIME,
		[EndDate] DATETIME,
		[MentorshipGlobalIdentity] UNIQUEIDENTIFIER
	);

	SET @executionStatus = 1;

END