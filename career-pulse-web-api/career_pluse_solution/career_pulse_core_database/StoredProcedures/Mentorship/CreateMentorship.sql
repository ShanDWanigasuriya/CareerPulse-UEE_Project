CREATE PROCEDURE [dbo].[CreateMentorship]
	@jsonString NVARCHAR(MAX) = '',
	@executionStatus BIT OUT
	WITH ENCRYPTION
AS
BEGIN

	DECLARE @mentorshipId INT;

	INSERT INTO [Mentorship]([MentorId], [CollaboratorId], [MentorshipTitle], [MentorshipDescription], [MentorName], [MentorDescription], [MentorExperience], [MentorExpertise], [MentorDocumentUrl], [MentorshipGlobalIdentity])
	SELECT [MentorId], [CollaboratorId], [MentorshipTitle], [MentorshipDescription], [MentorName], [MentorDescription], [MentorExperience], [MentorExpertise], [MentorDocumentUrl], [MentorshipGlobalIdentity]
	FROM OPENJSON(@jsonString, '$')
	WITH(
		[MentorId] INT,
		[CollaboratorId] INT,
		[MentorshipTitle] NVARCHAR(MAX) ,
		[MentorshipDescription] NVARCHAR(MAX) ,
		[MentorName] NVARCHAR(MAX) ,
		[MentorDescription] NVARCHAR(MAX) ,
		[MentorExperience] NVARCHAR(MAX) ,
		[MentorExpertise] NVARCHAR(MAX) ,
		[MentorDocumentUrl] NVARCHAR(MAX) ,
		[MentorshipGlobalIdentity] UNIQUEIDENTIFIER
	);

	SET @mentorshipId = SCOPE_IDENTITY();

	INSERT INTO TimeSlot([MentorshipId], [StartDate], [EndDate])
	SELECT @mentorshipId, [StartDate], [EndDate]
	FROM OPENJSON(@jsonString, '$.TimeSlot')
	WITH(
		[StartDate] DATETIME,
		[EndDate] DATETIME 
	);

	SET @executionStatus = 1;

END