using bank_data_web_business_layer.Interfaces;
using career_pulse_core_business_layer.Interfaces;
using career_pulse_core_model;
using career_pulse_core_repository;
using Microsoft.Data.SqlClient;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace career_pulse_core_business_layer
{
	public class EventServiceImpl : IEventService
	{
		private readonly IDatabaseService _databaseService;
		public readonly EventRepository<Event> _eventRepository;

		public EventServiceImpl(IDatabaseService databaseService)
		{
			_databaseService = databaseService;
			_eventRepository = new EventRepository<Event>(_databaseService.GetConnectionString());
		}

		public async Task<bool> CreateEvent(Event @event)
		{
			string eventJsonString = JsonConvert.SerializeObject(@event);
			bool status = _eventRepository.InsertData("CreateEvent", eventJsonString);
			return status;
		}

		public async Task<IEnumerable<Event>> GetAllEvents()
		{
			var events = _eventRepository.RetrieveData("GetAllEvents");
			return events;
		}

		public async Task<Event> GetEventById(int eventId)
		{
			var eventss = _eventRepository.RetrieveData("GetEventById", new SqlParameter[]
			{
				new SqlParameter("@eventId", eventId)
			}).FirstOrDefault();

			return eventss;
		}
	}
}
