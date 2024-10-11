CREATE PROCEDURE [dbo].[CreateEvent]
	@jsonString NVARCHAR(MAX) = '',
	@executionStatus BIT OUT
	WITH ENCRYPTION
AS
BEGIN

	INSERT INTO [Event]([PostedMemberId], [EventTitle], [EventDescription], [EventVenueEnm], [EventLink], [EventDocumentUrl], [StartDate], [EndDate])
	SELECT [PostedMemberId], [EventTitle], [EventDescription], [EventVenueEnm], [EventLink], [EventDocumentUrl], [StartDate], [EndDate]
	FROM OPENJSON(@jsonString, '$')
	WITH(
		[PostedMemberId] INT,
		[EventTitle] NVARCHAR(MAX),
		[EventDescription] NVARCHAR(MAX),
		[EventVenueEnm] NVARCHAR(MAX),
		[EventLink] NVARCHAR(MAX),
		[EventDocumentUrl] NVARCHAR(MAX),
		[StartDate] DATETIME,
		[EndDate] DATETIME
	);

	SET @executionStatus = 1;

END
