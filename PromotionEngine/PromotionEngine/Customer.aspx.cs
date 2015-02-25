using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Configuration;
using System.Data;
using Newtonsoft.Json;
using System.Web.Script.Services;

namespace PromotionEngine
{
    public partial class Customer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static string GetCompanys()
        {
            Promotion pmt = new Promotion();
            DataSet dsPromotion = pmt.GetAllCompany(ConfigurationManager.AppSettings["DATABASE_NAME"].ToString());
            if (dsPromotion != null)
            {
                return JsonConvert.SerializeObject(dsPromotion.Tables[0]);
            }
            return string.Empty;
        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public static void UpdateCustomer(string oCustomer, bool isInsert)
        {
            Model.Customer customer = JsonConvert.DeserializeObject<Model.Customer>(oCustomer);
            if (isInsert)
            {
                customer.CreatedDate = DateTime.Now;

                if (HttpContext.Current.Session["LoginUser"] != null)
                {
                    DataTable tbUser = (DataTable)HttpContext.Current.Session["LoginUser"];

                    if (tbUser != null && tbUser.Rows.Count > 0)
                    {
                        customer.CreatedUserID = tbUser.Rows[0]["UserID"].ToString();
                    }
                }
            }
            Promotion pmt = new Promotion();

            string errMsg = pmt.UpdateJsonCustomer("", "", customer.CustomerID, customer.CustomerCode, customer.CustomerName, customer.CompanyCode, customer.CreatedUserID, customer.CreatedDate
                , customer.IsActive, customer.BillingAddress, customer.ShippingAddress, customer.ContactPerson, customer.PhoneNumber, customer.Email, ConfigurationManager.AppSettings["DATABASE_NAME"].ToString(), isInsert);
            if (errMsg.Length == 0)
            {

            }
        }
        [WebMethod]
        public static string GetCustomers()
        {
            Promotion pmt = new Promotion();
            DataSet dsPromotion = pmt.GetAllCustomer(ConfigurationManager.AppSettings["DATABASE_NAME"].ToString());
            if (dsPromotion != null)
            {
                return JsonConvert.SerializeObject(dsPromotion.Tables[0]);
            }
            return string.Empty;
        }
    }
}