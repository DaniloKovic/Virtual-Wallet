using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Virtual_Wallet.Controller;
using Virtual_Wallet.Models.ViewModels;

namespace Virtual_Wallet.Helper
{
    public static class ControllerExtension
    {
        public static List<KategorijaAkcijeViewModel> GetKategorijeAkcijaList(this RacunController _racunController)
        {
            List <KategorijaAkcijeViewModel> kategorijaAkcijeList = new List <KategorijaAkcijeViewModel>();
            string getKategorijaAkcijeQuery = $"select * from kategorija_akcije";
            try
            {
                using (MySqlConnection conn = new MySqlConnection(ConfigurationManager.AppSettings["connectionString"]))
                {
                    conn.Open();
                    MySqlCommand cmd = new MySqlCommand(getKategorijaAkcijeQuery, conn);
                    MySqlDataReader dr = cmd.ExecuteReader();
                    while (dr.Read())
                    {
                        kategorijaAkcijeList.Add(new KategorijaAkcijeViewModel()
                        {
                            Id = Int32.Parse(dr["Id"].ToString()),
                            NazivAkcije = dr["NazivAkcije"].ToString(),
                        });
                    }
                    return kategorijaAkcijeList;
                }
            }
            catch (Exception ex)
            {
                return null;
            }
        }
    }
}
