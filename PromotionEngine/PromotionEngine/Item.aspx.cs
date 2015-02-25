using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Configuration;
using Newtonsoft.Json;
using System.Data;
using System.Web.Script.Services;

namespace PromotionEngine
{
    public partial class Item : System.Web.UI.Page
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
        public static void UpdateItem(string oItem, bool isInsert)
        {
            Model.Item item = JsonConvert.DeserializeObject<Model.Item>(oItem);
            if (isInsert)
            {
                item.CreatedDate = DateTime.Now;

                if (HttpContext.Current.Session["LoginUser"] != null)
                {
                    DataTable tbUser = (DataTable)HttpContext.Current.Session["LoginUser"];

                    if (tbUser != null && tbUser.Rows.Count > 0)
                    {
                        item.CreatedUserID = tbUser.Rows[0]["UserID"].ToString();
                    }
                }
            }
            Promotion pmt = new Promotion();

            string errMsg = pmt.UpdateJsonItem("", "", item.ItemID, item.ItemCode, item.ItemName, item.CompanyCode, item.BasePrice, item.CreatedUserID, item.CreatedDate
                                                        , item.IsActive, item.AllowPromotion, ConfigurationManager.AppSettings["DATABASE_NAME"].ToString(), isInsert);
              if (errMsg.Length == 0)
            {

            }
        }
        [WebMethod]
        public static string GetItems()
        {
            Promotion pmt = new Promotion();
            DataSet dsPromotion = pmt.GetAllItem(ConfigurationManager.AppSettings["DATABASE_NAME"].ToString());
            if (dsPromotion != null)
            {
                return JsonConvert.SerializeObject(dsPromotion.Tables[0]);
            }
            return string.Empty;
        }
    }
}