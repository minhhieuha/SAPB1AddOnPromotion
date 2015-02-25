using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PromotionEngine.Model
{
    public class Item
    {
        public string ItemID { get; set; }
        public string ItemCode { get; set; }
        public string ItemName { get; set; }
        public string CompanyCode { get; set; }
        public double BasePrice { get; set; }
        public string CreatedUserID { get; set; }
        public DateTime CreatedDate { get; set; }
        public bool IsActive { get; set; }
        public bool AllowPromotion { get; set; }
    }
}