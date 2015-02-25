using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PromotionEngine.Model
{
    public class Customer
    {
        public string CustomerID { get; set; }
        public string CustomerCode { get; set; }
        public string CustomerName { get; set; }
        public string CompanyCode { get; set; }
        public string CreatedUserID { get; set; }
        public DateTime CreatedDate { get; set; }
        public bool IsActive { get; set; }
        public string BillingAddress { get; set; }
        public string ShippingAddress { get; set; }
        public string ContactPerson { get; set; }
        public string PhoneNumber { get; set; }
        public string Email { get; set; }
    }
}