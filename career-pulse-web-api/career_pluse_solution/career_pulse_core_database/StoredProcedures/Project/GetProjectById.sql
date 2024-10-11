CREATE PROCEDURE [dbo].[GetProjectById]
	@projectId INT = 0
AS
BEGIN

	SELECT P.* FROM [Project] P WHERE P.ProjectId = @projectId FOR JSON PATH

END
