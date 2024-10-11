using career_pulse_core_model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace career_pulse_core_business_layer.Interfaces
{
	public interface IEventService
	{
		Task<bool> CreateEvent(Event @event);
		Task<IEnumerable<Event>> GetAllEvents();
		Task<Event> GetEventById(int eventId);
	}
}
