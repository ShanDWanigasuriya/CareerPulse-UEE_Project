CREATE PROCEDURE [dbo].[GetEventById]
	@eventId INT = 0
AS
BEGIN

	SELECT E.* FROM [Event] E WHERE E.EventId = @eventId FOR JSON PATH

END
