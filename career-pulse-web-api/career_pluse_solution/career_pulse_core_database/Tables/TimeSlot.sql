CREATE TABLE [dbo].[TimeSlot]
(
	[TimeSlotId] INT IDENTITY NOT NULL PRIMARY KEY,
	[MentorshipId] INT NULL,
	[StartDate] DATETIME NULL,
	[EndDate] DATETIME NULL
)
