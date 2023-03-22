using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using Virtual_Wallet.Helper;
using Virtual_Wallet.Models.ViewModels;

namespace Virtual_Wallet.Controllers
{
    public class PodsjetnikController
    {
        private readonly string getDataQuery = $"select * from podsjetnik p where p.KORISNIK_id = {UserSession.getInstance().Id};";

        private List<PodsjetnikViewModel> podsjetnikKorisnik = new List<PodsjetnikViewModel>();
        public List<PodsjetnikViewModel> GetData()
        {
            try
            {
                podsjetnikKorisnik.Clear();
                using (MySqlConnection conn = new MySqlConnection(ConfigurationManager.AppSettings["connectionString"]))
                {
                    conn.Open();
                    MySqlCommand cmd = new MySqlCommand(getDataQuery, conn);
                    MySqlDataReader dr = cmd.ExecuteReader();
                    while (dr.Read())
                    {
                        podsjetnikKorisnik.Add(new PodsjetnikViewModel()
                        {
                            Id = Int32.Parse(dr["Id"].ToString()),
                            KorisnikId = Int32.Parse(dr["KORISNIK_Id"].ToString()),
                            Opis = dr["Opis"].ToString(),
                            DatumOd = DateTime.Parse(dr["DatumOd"].ToString()).Date.ToShortDateString(),
                            DatumDo = DateTime.Parse(dr["DatumDo"].ToString()).Date.ToShortDateString(),
                            Zavrseno = Boolean.Parse(dr["Zavrseno"].ToString())
                        });
                    }
                    return podsjetnikKorisnik;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                return null;
            }
        }

        public int InsertNewRecord(string opis, string datumOd, string datumDo)
        {
            try
            {
                using (MySqlConnection conn = new MySqlConnection(ConfigurationManager.AppSettings["connectionString"]))
                {
                    conn.Open();
                    string insertDataQuery = $"insert into podsjetnik (Opis, DatumOd, DatumDo, KORISNIK_Id) values ('{opis}','{datumOd}','{datumDo}',{UserSession.getInstance().Id});";
                    MySqlCommand cmd = new MySqlCommand(insertDataQuery, conn);
                    int insertResult = cmd.ExecuteNonQuery();
                    return insertResult;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                return 0;
            }
        }

        public int DeleteRecord(PodsjetnikViewModel podjsetnikToDelete)
        {
            try
            {
                using (MySqlConnection conn = new MySqlConnection(ConfigurationManager.AppSettings["connectionString"]))
                {
                    conn.Open();
                    string deleteDataQuery = $"delete from podsjetnik where Id = {podjsetnikToDelete.Id};";
                    MySqlCommand cmd = new MySqlCommand(deleteDataQuery, conn);
                    int deleteResult = cmd.ExecuteNonQuery();
                    return deleteResult;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                return 0;
            }
        }

        public int UpdateRecord(PodsjetnikViewModel podsjetnikToUpdate)
                {
            try
            {
                using (MySqlConnection conn = new MySqlConnection(ConfigurationManager.AppSettings["connectionString"]))
                {
                    conn.Open();
                    string updateDataQuery = $"update podsjetnik p set p.Zavrseno = {podsjetnikToUpdate.Zavrseno} where p.Id={podsjetnikToUpdate.Id};";
                    MySqlCommand cmd = new MySqlCommand(updateDataQuery, conn);
                    int insertResult = cmd.ExecuteNonQuery();
                    return insertResult;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                return 0;
            }
        }
    }
}
