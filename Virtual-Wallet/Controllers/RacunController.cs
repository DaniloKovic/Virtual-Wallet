using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Windows;
using Virtual_Wallet.Helper;
using Virtual_Wallet.Models.Enums;
using Virtual_Wallet.Models.ViewModels;

namespace Virtual_Wallet.Controller
{
    public class RacunController
    { 
        private readonly string getDataQuery = $"select tr.NazivRacuna, r.* from korisnik k inner join racun r on r.KORISNIK_Id = k.Id inner join tip_racuna tr on r.TIP_RACUNA_Id = tr.Id where k.id = {UserSession.getInstance().Id};";
        private readonly string transferNovcaProcedura = "TransferNovca";
        private readonly string getKategorijaAkcijeQuery = $"select * from kategorija_akcije";

        private List<RacunViewModel> korisnickiRacuni = new List<RacunViewModel>();
        private List<KategorijaAkcijeViewModel> kategorijeAkcije = new List<KategorijaAkcijeViewModel>();

        public RacunController()
        {
       
        }
        public List<RacunViewModel> GetData()
        {
            try
            {
                korisnickiRacuni.Clear();
                using (MySqlConnection conn = new MySqlConnection(ConfigurationManager.AppSettings["connectionString"]))
                {
                    conn.Open();
                    MySqlCommand cmd = new MySqlCommand(getDataQuery, conn);
                    MySqlDataReader dr = cmd.ExecuteReader();
                    while (dr.Read())
                    {
                        korisnickiRacuni.Add(new RacunViewModel()
                        {
                            Id =Int32.Parse(dr["Id"].ToString()),
                            NazivRacuna = dr["NazivRacuna"].ToString(),
                            Iznos = dr["Iznos"].ToString(),
                            DatumKreiranja = dr["DatumKreiranja"].ToString(),
                            Valuta = dr["Valuta"].ToString()
                        }); 
                    }
                    return korisnickiRacuni;
                }
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public List<KategorijaAkcijeViewModel> GetKategorijaAkcijeData()
        {
            return this.GetKategorijeAkcijaList();
        }

        public List<RacunViewModel> GetComboBoxData()
        {
            return korisnickiRacuni.Select(el => new RacunViewModel()
            {
                Id = el.Id,
                NazivRacuna = el.NazivRacuna,
                Iznos = el.Iznos,
            }).ToList();
        }

        public int TransferMoneyProcedure(int transferSaId, int transferNaId, double iznosTransfera)
        {
            try
            {
                int transferLastId = 0;
                using (MySqlConnection conn = new MySqlConnection(ConfigurationManager.AppSettings["connectionString"]))
                {
                    conn.Open();
                    MySqlCommand cmd = new MySqlCommand(transferNovcaProcedura, conn)
                                       {
                                           CommandType = CommandType.StoredProcedure
                                       };
                    MySqlParameter param1 = new MySqlParameter(@"saRacunaId", MySqlDbType.Int32) 
                                            {
                                                Value = transferSaId,
                                                Direction = ParameterDirection.Input
                                            };
                    MySqlParameter param2 = new MySqlParameter(@"naRacunId", MySqlDbType.Int32) 
                                            { 
                                                Value = transferNaId,
                                                Direction= ParameterDirection.Input
                                            };
                    MySqlParameter param3 = new MySqlParameter(@"iznosTransfera", MySqlDbType.Double)
                                            {
                                                Value = iznosTransfera,
                                                Direction = ParameterDirection.Input
                                            };
                    MySqlParameter outParam = new MySqlParameter(@"transferLastId", MySqlDbType.Int32) 
                                              { 
                                                  Value = transferLastId,
                                                  Direction = ParameterDirection.Output
                                              };
                    cmd.Parameters.Add(param1);
                    cmd.Parameters.Add(param2);
                    cmd.Parameters.Add(param3);
                    cmd.Parameters.Add(outParam);

                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        Console.WriteLine(outParam.Value.ToString());
                        return (int)outParam.Value;
                    }
                    return rowsAffected;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                return 0;
            }
        }

        public int AkcijaNaRacunu(int racunId, int kategorijaAkcijeId, double iznosAkcije)
        {
            string insertQuery = $"insert into akcija_na_racunu (RACUN_Id, KATEGORIJA_AKCIJE_Id, DatumAkcije, IznosAkcije) values ({racunId},{kategorijaAkcijeId},'{DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss")}',{iznosAkcije})";
            try
            {
                using (MySqlConnection conn = new MySqlConnection(ConfigurationManager.AppSettings["connectionString"]))
                {
                    conn.Open();
                    string selectQuery = $"select r.Iznos from racun r where r.Id = {racunId};";
                    MySqlCommand cmdSelect = new MySqlCommand(selectQuery, conn);
                    var IznosNaRacunuStr =  cmdSelect.ExecuteScalar().ToString();
                    double IznosNaRacunu = Double.Parse(IznosNaRacunuStr); 

                    if (kategorijaAkcijeId == (int)KategorijaAkcijeEnum.Isplata && iznosAkcije > IznosNaRacunu) 
                    {
                        return 0;
                    }
                    else
                    {
                        MySqlCommand cmd = new MySqlCommand(insertQuery, conn);
                        int insertResult = cmd.ExecuteNonQuery();
                        return insertResult;
                    }
                }
            }
            catch (Exception ex)
            {
                return 0;
            }
        }
    }
}
