using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Web.Services;
using System.Web.Script.Services;
using Newtonsoft.Json;
using System.Collections;

namespace PromotionEngine
{
    public partial class User : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["IsAdmin"] != null)
            {
                if (!bool.Parse(HttpContext.Current.Session["IsAdmin"].ToString()))
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public static ArrayList GetAllCompany()
        {

            ArrayList lstArrLanguage = new ArrayList();


            List<Model.Company> lstCompany = new List<Model.Company>();

            Promotion pmt = new Promotion();
            DataSet dsPromotion = pmt.GetAllCompany(ConfigurationManager.AppSettings["DATABASE_NAME"].ToString());
            if (dsPromotion != null)
            {
                foreach (DataRow r in dsPromotion.Tables[0].Rows)
                {
                    Model.Company cmp = new Model.Company();

                    cmp.CompanyCode = r["CompanyCode"].ToString();
                    cmp.CompanyName = r["CompanyName"].ToString();

                    lstCompany.Add(cmp);
                    lstArrLanguage.Add(new ListItem(r["CompanyCode"].ToString(), r["CompanyName"].ToString()));

                }
            }
            return lstArrLanguage;// JsonConvert.SerializeObject(lstCompany);
        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public static void UpdateUser(string oUser,bool isInsert)
        {
            Model.User user = JsonConvert.DeserializeObject<Model.User>(oUser);
            Promotion pmt = new Promotion();

            string errMsg = pmt.UpdateJsonUser("", "", user.UserID, user.UserName, user.CompanyCode, user.Password, user.IsAdmin, user.IsActive, user.IsTrial, user.Email, user.Phone,
                  ConfigurationManager.AppSettings["DATABASE_NAME"].ToString(), isInsert);
            if (errMsg.Length == 0)
            {

            }

        }
        [WebMethod]
        public static string GetUsers()
        {
            Promotion pmt = new Promotion();
            DataSet dsPromotion = pmt.GetAllUser(ConfigurationManager.AppSettings["DATABASE_NAME"].ToString());
            if (dsPromotion != null)
            {
                return JsonConvert.SerializeObject(dsPromotion.Tables[0]);
            }
            return string.Empty;
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
        protected void btnAddNew_Click(object sender, EventArgs e)
        {

        }
    }
}