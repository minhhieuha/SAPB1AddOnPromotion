using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PromotionEngine.Model
{
    public class User
    {
        public string CompanyCode { get; set; }
        public string Password { get; set; }
        public bool IsAdmin { get; set; }
        public bool IsActive { get; set; }
        public bool IsTrial { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string UserName { get; set; }
        public string UserID { get; set; }
    }
}