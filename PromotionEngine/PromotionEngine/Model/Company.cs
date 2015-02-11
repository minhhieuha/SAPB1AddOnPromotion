using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PromotionEngine.Model
{
    public class Company
    {
        public string CompanyCode { get; set; }
        public string CompanyName { get; set; }
        public bool IsActive { get; set; }
        public string Address { get; set; }
        public string ContactPerson { get; set; }
        public string ContactPhone { get; set; }

    }
}