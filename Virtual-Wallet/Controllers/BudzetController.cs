using MySql.Data.MySqlClient;
using System;
using System.Collections;
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
    public class BudzetController
    {
        private readonly string getDataQuery = $"select * from budzet where KORISNIK_Id = {UserSession.getInstance().Id};";
        private List<BudzetViewModel> budzetKorisnik = new List<BudzetViewModel>();
        public List<BudzetViewModel> GetData()
        {
            try
            {
                budzetKorisnik.Clear();
                using (MySqlConnection conn = new MySqlConnection(ConfigurationManager.AppSettings["connectionString"]))
                {
                    conn.Open();
                    MySqlCommand cmd = new MySqlCommand(getDataQuery, conn);
                    MySqlDataReader dr = cmd.ExecuteReader();
                    while (dr.Read())
                    {
                        budzetKorisnik.Add(new BudzetViewModel()
                        {
                            Id = Int32.Parse(dr["Id"].ToString()),
                            KorisnikId = Int32.Parse(dr["KORISNIK_Id"].ToString()),
                            DatumOd = DateTime.Parse(dr["DatumOd"].ToString()).Date.ToShortDateString(),
                            DatumDo = DateTime.Parse(dr["DatumDo"].ToString()).Date.ToShortDateString(),
                            PredvidjeniIznos = Double.Parse(dr["PredvidjeniIznos"].ToString()),
                            TrenutniIznos = Double.Parse(dr["TrenutniIznos"].ToString())
                        });
                    }
                    return budzetKorisnik;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                return null;
            }
        }

        public List<StavkaBudzetaViewModel> GetStavkeBudzeta(int budzetId)
        {
            List<StavkaBudzetaViewModel> stavkeBudzeta = new List<StavkaBudzetaViewModel>();
            string getStavkeBudzetaQuery = "select ks.Id as Id, ks.Naziv as Naziv, sb.PredvidjeniIznos as PredvidjeniIznos, sb.TrenutniIznos as TrenutniIznos, sb.Opis as Opis " +
                                           "from budzet b " +
                                           "inner join stavka_budzeta sb on b.Id = sb.BUDZET_Id " +
                                           "inner join kategorija_stavke ks on sb.kategorija_stavke_Id = ks.Id " +
                                           $"where b.KORISNIK_Id = {UserSession.getInstance().Id} and b.Id = {budzetId};";
            try
            {
                using (MySqlConnection conn = new MySqlConnection(ConfigurationManager.AppSettings["connectionString"]))
                {
                    conn.Open();
                    MySqlCommand cmd = new MySqlCommand(getStavkeBudzetaQuery, conn);
                    MySqlDataReader dr = cmd.ExecuteReader();
                    while (dr.Read())
                    {
                        stavkeBudzeta.Add(new StavkaBudzetaViewModel()
                        {
                            KategorijaStavkeId = Int32.Parse(dr["Id"].ToString()),
                            KategorijaStavkeNaziv = dr["Naziv"].ToString(),
                            BudzetId = budzetId,
                            PredvidjeniIznos = Double.Parse(dr["PredvidjeniIznos"].ToString()),
                            TrenutniIznos = Double.Parse(dr["TrenutniIznos"].ToString()),
                            Opis = dr["Opis"].ToString()
                        });
                    }
                    return stavkeBudzeta;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                return null;
            }
        }


        public int AddNoviBudzet(BudzetViewModel newBudzetItem)
        {
            string[] datumOd = newBudzetItem.DatumOd.Split('/');
            string[] datumDo = newBudzetItem.DatumDo.Split('/');

            string dateFrom = $"{datumOd[2]}{'-'}{datumOd[0]}{'-'}{datumOd[1]}";
            string dateTo = $"{datumDo[2]}{'-'}{datumDo[0]}{'-'}{datumDo[1]}";
            string insertNewBudzetQuesry = $"insert into budzet (KORISNIK_Id, DatumOd, DatumDo, PredvidjeniIznos, TrenutniIznos) values ({UserSession.getInstance().Id},'{dateFrom}','{dateTo}',{newBudzetItem.PredvidjeniIznos},{newBudzetItem.TrenutniIznos});";
            try
            {
                using (MySqlConnection conn = new MySqlConnection(ConfigurationManager.AppSettings["connectionString"]))
                {
                    conn.Open();
                    MySqlCommand cmd = new MySqlCommand(insertNewBudzetQuesry, conn);
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

        public int UpdateStavkaBudzeta(StavkaBudzetaViewModel stavkaBudzetaItem)
        {
            string updateStavkaBudzetaQuery = "update stavka_budzeta " + 
                                              $"set PredvidjeniIznos = {stavkaBudzetaItem.PredvidjeniIznos}, " +
                                              $"TrenutniIznos = {stavkaBudzetaItem.TrenutniIznos}, " +
                                              $"Opis = '{stavkaBudzetaItem.Opis}' " +
                                              $"where KATEGORIJA_STAVKE_Id = {stavkaBudzetaItem.KategorijaStavkeId} and BUDZET_Id = {stavkaBudzetaItem.BudzetId}; ";
            try
            {
                using (MySqlConnection conn = new MySqlConnection(ConfigurationManager.AppSettings["connectionString"]))
                {
                    conn.Open();
                    MySqlCommand cmd = new MySqlCommand(updateStavkaBudzetaQuery, conn);
                    int updateResult = cmd.ExecuteNonQuery();
                    return updateResult;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                return 0;
            }
        }

        public int UpdateBudzet(BudzetViewModel budzetItemToUpdate)
        {
            string[] datumOd = budzetItemToUpdate.DatumOd.Split('/');
            string[] datumDo = budzetItemToUpdate.DatumDo.Split('/');

            string dateFrom = $"{datumOd[2]}{'-'}{datumOd[0]}{'-'}{datumOd[1]}";
            string dateTo = $"{datumDo[2]}{'-'}{datumDo[0]}{'-'}{datumDo[1]}";

            string updateStavkaBudzetaQuery = $"update budzet set DatumOd = '{dateFrom}', DatumDo = '{dateTo}', PredvidjeniIznos = {budzetItemToUpdate.PredvidjeniIznos} where Id = {budzetItemToUpdate.Id};";
            try
            {
                using (MySqlConnection conn = new MySqlConnection(ConfigurationManager.AppSettings["connectionString"]))
                {
                    conn.Open();
                    MySqlCommand cmd = new MySqlCommand(updateStavkaBudzetaQuery, conn);
                    int updateResult = cmd.ExecuteNonQuery();
                    return updateResult;
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
