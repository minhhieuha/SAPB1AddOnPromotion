﻿using System;
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

namespace PromotionEngine
{
    public partial class Company : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData();
                
            }
        }

        private  void LoadData()
        {
            Promotion pmt = new Promotion();
            DataSet dsPromotion = pmt.GetAllCompany(ConfigurationManager.AppSettings["DATABASE_NAME"].ToString());
            if (dsPromotion != null)
            {
                this.grvCompany.DataSource = dsPromotion;
                this.grvCompany.DataBind();
            }
        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public static void UpdateCompany(string oCompany)
        {
            Model.Company company = JsonConvert.DeserializeObject<Model.Company>(oCompany);
            Promotion pmt = new Promotion();

          string errMsg=   pmt.UpdateJsonCompany("", "", company.CompanyCode, company.CompanyName, company.IsActive, company.Address, company.ContactPerson, company.ContactPhone,
                ConfigurationManager.AppSettings["DATABASE_NAME"].ToString(), true);
          if (errMsg.Length == 0)
          {
              
          }

        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public static void GetRevenueDetail(string oCompany)
        {
        }
        protected void btnAddNew_Click(object sender, EventArgs e)
        {

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {

        }
    }
}