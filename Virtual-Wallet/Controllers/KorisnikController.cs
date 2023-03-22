using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using Virtual_Wallet.Helper;

namespace Virtual_Wallet.Controller
{
    public class KorisnikController
    {
        private readonly string korisnikRegistration = "RegitracijaKorisnika";
        public KorisnikController()
        {

        }

        public int LogInAttempt(string korisnickoIme, string lozinka)
        {
            try
            {
                int rowsSelected = 0;
                using (MySqlConnection conn = new MySqlConnection(ConfigurationManager.AppSettings["connectionString"]))
                {
                    conn.Open();
                    string logInAttemptQuery = $"select * from korisnik k where k.KorisnickoIme = '{korisnickoIme}' and k.Lozinka = '{lozinka}';";
                    MySqlCommand cmd = new MySqlCommand(logInAttemptQuery, conn);
                    MySqlDataReader dr = cmd.ExecuteReader();

                    while (dr.Read())
                    {
                        ++rowsSelected;
                        if (dr.RecordsAffected == -1 && dr.HasRows)
                        {
                            int Id = Int32.Parse(dr["Id"].ToString());
                            int ZajednicaId = Int32.Parse(dr["ZAJEDNICA_Id"].ToString());
                            string KorisnickoIme = dr["KorisnickoIme"].ToString();
                            string Lozinka = dr["Lozinka"].ToString();
                            bool isAdmin = Boolean.Parse(dr["IsAdmin"].ToString());
                            UserSession.createInstance(Id, ZajednicaId, KorisnickoIme, Lozinka, isAdmin);
                        }
                    }
                }
                return rowsSelected;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                return 0;
            }
        }

        public int RegistrationProcedure(string imePrezime, string korisnickoIme, string lozinkaKorisnik, string lozinkaZajednica, string email, string telefon, bool isAdmin = false)
        {
            string[] imeIPrezime = imePrezime.Split(' ');
            string ime = imeIPrezime[0];
            string prezime = imeIPrezime[1];
            try
            {
                int registrationResult = 0;
                using (MySqlConnection conn = new MySqlConnection(ConfigurationManager.AppSettings["connectionString"]))
                {
                    conn.Open();
                    MySqlCommand cmd = new MySqlCommand(korisnikRegistration, conn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    MySqlParameter param1 = new MySqlParameter(@"ime", MySqlDbType.String)
                    {
                        Value = ime,
                        Direction = ParameterDirection.Input
                    };
                    MySqlParameter param2 = new MySqlParameter(@"prezime", MySqlDbType.String)
                    {
                        Value = prezime,
                        Direction = ParameterDirection.Input
                    };
                    MySqlParameter param3 = new MySqlParameter(@"korisnickoIme", MySqlDbType.String)
                    {
                        Value = korisnickoIme,
                        Direction = ParameterDirection.Input
                    };
                    MySqlParameter param4 = new MySqlParameter(@"lozinka", MySqlDbType.String)
                    {
                        Value = lozinkaKorisnik,
                        Direction = ParameterDirection.Input
                    };
                    MySqlParameter param5 = new MySqlParameter(@"sifraZajednice", MySqlDbType.String)
                    {
                        Value = lozinkaZajednica,
                        Direction = ParameterDirection.Input
                    };
                    MySqlParameter param6 = new MySqlParameter(@"email", MySqlDbType.String)
                    {
                        Value = email,
                        Direction = ParameterDirection.Input
                    };
                    MySqlParameter param7 = new MySqlParameter(@"telefon", MySqlDbType.String)
                    {
                        Value = telefon,
                        Direction = ParameterDirection.Input
                    };
                    MySqlParameter outParam = new MySqlParameter(@"registrationResult", MySqlDbType.Int32)
                    {
                        Value = registrationResult,
                        Direction = ParameterDirection.Output
                    };
                    cmd.Parameters.Add(param1);
                    cmd.Parameters.Add(param2);
                    cmd.Parameters.Add(param3);
                    cmd.Parameters.Add(param4);
                    cmd.Parameters.Add(param5);
                    cmd.Parameters.Add(param6);
                    cmd.Parameters.Add(param7);
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
                return 0;
            }
        }
    }
}
