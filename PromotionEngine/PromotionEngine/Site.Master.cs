using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace PromotionEngine
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["LoginUser"] == null || HttpContext.Current.Session["IsAdmin"] == null || HttpContext.Current.Session["CompanyCode"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            if (HttpContext.Current.Session["LoginUser"] != null)
            {
                DataTable tbUser = (DataTable)HttpContext.Current.Session["LoginUser"];

                if (tbUser != null && tbUser.Rows.Count > 0)
                {

                    string userName = tbUser.Rows[0]["UserName"].ToString();

                    if(bool.Parse(tbUser.Rows[0]["IsAdmin"].ToString()))
                    {
                        userName += " (Admin)";
                        //this.lblYouAreIn.Visible = false;
                        //this.lblCompany.Visible = false;
                        //this.lblTextCompany.Visible = false;
                    }
                    this.lblUserName.Text =userName;
                    this.lblCompany.Text = tbUser.Rows[0]["CompanyName"].ToString();
                }
            }
        }

        protected void lnkLogOut_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}
