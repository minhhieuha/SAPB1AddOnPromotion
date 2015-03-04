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
using System.IO;
using System.Web.UI.HtmlControls;

namespace PromotionEngine
{
    public class Response
    {
        public List<Model.Company> Data { get; set; }
        public int Count { get; set; }
        public string Errors { get; set; }

        public Response(List<Model.Company> data, int count)
        {
            this.Data = data;
            this.Count = count;
        }

        public Response(string errors)
        {
            this.Errors = errors;
        }

        public Response()
        {

        }
    }
    public partial class Company : System.Web.UI.Page
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
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public static Response GetCompanys()
        {
            List<Model.Company> lstCompany = new List<Model.Company>();
            Promotion pmt = new Promotion();
            DataSet dsPromotion = pmt.GetAllCompany(ConfigurationManager.AppSettings["DATABASE_NAME"].ToString());
            if (dsPromotion != null)
            {

                foreach (DataRow r in dsPromotion.Tables[0].Rows)
                {
                    Model.Company company = new Model.Company();
                    company.CompanyCode = r["CompanyCode"].ToString();
                    company.CompanyName = r["CompanyName"].ToString();
                    company.Address = r["Address"].ToString();
                    company.ContactPerson = r["ContactPerson"].ToString();
                    company.ContactPhone = r["ContactPhone"].ToString();
                    company.IsActive = bool.Parse(r["IsActive"].ToString());
                    lstCompany.Add(company);
                }
                var jsonData = new { total = dsPromotion.Tables[0].Rows.Count, lstCompany };
                return new Response(lstCompany, dsPromotion.Tables[0].Rows.Count);
            }
            return new Response();
        }
        [WebMethod]
        public static string GetJsonCompanys()
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
        public static void UpdateCompany(string oCompany,bool isInsert)
        {
            Model.Company company = JsonConvert.DeserializeObject<Model.Company>(oCompany);
            Promotion pmt = new Promotion();
            string errMsg = pmt.UpdateJsonCompany("", "", company.CompanyCode, company.CompanyName, company.IsActive, company.Address, company.ContactPerson, company.ContactPhone,
                  ConfigurationManager.AppSettings["DATABASE_NAME"].ToString(), isInsert);
            if (errMsg.Length == 0)
            {
                //Show error message
            }
        }
    }
}