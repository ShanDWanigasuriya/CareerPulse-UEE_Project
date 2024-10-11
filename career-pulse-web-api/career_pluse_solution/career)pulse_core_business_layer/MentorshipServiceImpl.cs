using bank_data_web_business_layer.Interfaces;
using career_pulse_core_business_layer.Interfaces;
using career_pulse_core_model;
using career_pulse_core_repository;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace career_pulse_core_business_layer
{
    public class MentorshipServiceImpl : IMentorshipService
    {
        private readonly IDatabaseService _databaseService;
        public readonly MentorshipRepository<Mentorship> _mentorshipRepository;

        public MentorshipServiceImpl(IDatabaseService databaseService)
        {
            _databaseService = databaseService;
            _mentorshipRepository = new MentorshipRepository<Mentorship>(_databaseService.GetConnectionString());
        }

        public async Task<bool> CreateMentorship(Mentorship mentorship)
        {
            string mentorshipJsonString = JsonConvert.SerializeObject(mentorship);
            bool status = _mentorshipRepository.InsertData("CreateMentorship", mentorshipJsonString);
            return status;
        }

		public async Task<IEnumerable<Mentorship>> GetAllMentorships()
		{
			var mentorships = _mentorshipRepository.RetrieveData("GetAllMentorships");
			return mentorships;
		}

		public async Task<Mentorship> GetMentorshipsById(int mentorshipId)
		{
			var mentorship = _mentorshipRepository.RetrieveData("GetMentorshipsById", new Microsoft.Data.SqlClient.SqlParameter[]
            {
                new Microsoft.Data.SqlClient.SqlParameter("@mentorshipId", mentorshipId)
            }).FirstOrDefault();
			return mentorship;
		}
	}
}
