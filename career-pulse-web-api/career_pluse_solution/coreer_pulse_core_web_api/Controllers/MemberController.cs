using career_pulse_core_business_layer.Interfaces;
using career_pulse_core_model;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SimpleCrypto;

namespace coreer_pulse_core_web_api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MemberController : ControllerBase
    {
        private readonly IMemberService _memberService;
        private readonly PBKDF2 _crypto;
        private readonly Random _random;

        public MemberController
        (
            IMemberService memberService
        )
        {
            _memberService = memberService;
            _crypto = new PBKDF2();
            _random = new Random();
        }

        [HttpPost("CreateMember")]
        public async Task<IActionResult> CreateMember([FromForm] Member member)
        {
            //validate the model
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            //create new guid for user
            var memberGlobalIdentity = Guid.NewGuid();
            string memberProfileImageFileUri = string.Empty;

            //store profile image
            if (member.ProfileImage != null && member.ProfileImage.Length > 0)
            {
                var memberProfileImagesFolderPath = Path.Combine(Directory.GetCurrentDirectory(), "Uploads/Member");

                var memberProfileImageFileName = memberGlobalIdentity.ToString() + "-" + member.ProfileImage.FileName;
                var memberProfileImageFilePath = Path.Combine(memberProfileImagesFolderPath, memberProfileImageFileName);

                using (var stream = new FileStream(memberProfileImageFilePath, FileMode.Create))
                {
                    await member.ProfileImage.CopyToAsync(stream);
                }

                memberProfileImageFileUri = Path.Combine("/Uploads/Member", memberProfileImageFileName).Replace("\\", "/");
            }

            member.ProfileImageUrl = memberProfileImageFileUri;
            member.Password = _crypto.Compute(member.Password);
            member.PasswordSalt = _crypto.Salt;
            member.ActivationCode = _random.Next(100000, 1000000);
            member.MemberGlobalIdentity = memberGlobalIdentity;

            var status = await _memberService.CreateMember(member);

            if (!status)
            {
                return Ok(status);
            }

            return StatusCode(201, status);

        }

        [HttpPost("Login")]
        public async Task<IActionResult> Login(LoginRequest loginRequest)
        {
            Member member = new Member();

            return Ok(member);
        }
    }
}
