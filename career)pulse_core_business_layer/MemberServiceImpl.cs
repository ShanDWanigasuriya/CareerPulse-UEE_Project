using bank_data_web_business_layer.Interfaces;
using career_pulse_core_business_layer.Interfaces;
using career_pulse_core_model;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Text;
using System.Threading.Tasks;

namespace career_pulse_core_business_layer
{
    public class MemberServiceImpl : IMemberService
    {
        private readonly IDatabaseService _databaseService;
        public readonly MemberRepository<Member> _memberRepository;

        public MemberServiceImpl(IDatabaseService databaseService)
        {
            _databaseService = databaseService;
            _memberRepository = new MemberRepository<Member>(_databaseService.GetConnectionString());
        }

        public async Task<bool> CreateMember(Member member)
        {
            string memberJsonString = JsonConvert.SerializeObject(member);
            bool status = _memberRepository.InsertData("CreateMember", memberJsonString);
            return status;
        }
    }
}
