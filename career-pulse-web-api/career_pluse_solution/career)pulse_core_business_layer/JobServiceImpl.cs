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
	public class JobServiceImpl : IJobService
	{
		private readonly IDatabaseService _databaseService;
		public readonly JobRepository<Job> _jobRepository;

		public JobServiceImpl(IDatabaseService databaseService)
		{
			_databaseService = databaseService;
			_jobRepository = new JobRepository<Job>(_databaseService.GetConnectionString());
		}

		public async Task<bool> CreateJob(Job job)
		{
			string jobJsonString = JsonConvert.SerializeObject(job);
			bool status = _jobRepository.InsertData("CreateJob", jobJsonString);
			return status;
		}

		public async Task<IEnumerable<Job>> GetAllJobs()
		{
			var jobs = _jobRepository.RetrieveData("GetAllJobs");
			return jobs;
		}

		public async Task<Job> GetJobById(int JobId)
		{
			var job = _jobRepository.RetrieveData("GetJobById", new Microsoft.Data.SqlClient.SqlParameter[]
			{
				new Microsoft.Data.SqlClient.SqlParameter("@JobId", JobId)
			}).FirstOrDefault();
			return job;
		}
	}
}
