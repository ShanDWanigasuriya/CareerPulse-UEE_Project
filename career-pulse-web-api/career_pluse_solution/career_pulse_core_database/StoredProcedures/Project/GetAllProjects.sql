﻿CREATE PROCEDURE [dbo].[GetAllProjects]
AS
BEGIN

	SELECT P.* FROM [Project] P ORDER BY P.ProjectId DESC FOR JSON PATH

END
