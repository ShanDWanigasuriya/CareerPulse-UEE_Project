using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace career_pulse_core_model
{
	public class TimeSlot
	{
		public int TimeSlotId { get; set; }
		public int MentorshipId { get; set; }
		public DateTime StartDate { get; set; }
		public DateTime EndDate { get; set; }

	}
}
