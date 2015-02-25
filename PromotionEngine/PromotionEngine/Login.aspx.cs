using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web.Script.Services;
using Newtonsoft.Json;
using System.Configuration;
using System.Data;

namespace PromotionEngine
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public static string GetLogin(string userName, string passWord)
        {
            Promotion pmt = new Promotion();

            DataSet dsUser = pmt.GetLogin(ConfigurationManager.AppSettings["DATABASE_NAME"].ToString(), userName, passWord);
            if (dsUser != null && dsUser.Tables.Count > 0 && dsUser.Tables[0].Rows.Count > 0)
            {
                HttpContext.Current.Session["IsAdmin"] = dsUser.Tables[0].Rows[0]["IsAdmin"];
                HttpContext.Current.Session["CompanyCode"] = dsUser.Tables[0].Rows[0]["CompanyCode"];
                HttpContext.Current.Session["LoginUser"] = dsUser.Tables[0];
            }
            else
            {
                return "FAILED";
            }
            return "SUCCESS";
        }
    }
}