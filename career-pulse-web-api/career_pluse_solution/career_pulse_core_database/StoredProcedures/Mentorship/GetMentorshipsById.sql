CREATE PROCEDURE [dbo].[GetMentorshipsById]
	@mentorshipId INT = 0
AS
BEGIN

	SELECT M.* FROM Mentorship M WHERE M.MentorshipId = @mentorshipId FOR JSON PATH

END

