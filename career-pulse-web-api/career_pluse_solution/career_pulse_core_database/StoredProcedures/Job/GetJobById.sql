﻿CREATE PROCEDURE [dbo].[GetJobById]
	@JobId INT = 0
AS
BEGIN

	SELECT J.* FROM [Job] J WHERE J.JobId = @JobId FOR JSON PATH

END