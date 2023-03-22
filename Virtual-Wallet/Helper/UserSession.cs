using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Virtual_Wallet.Helper
{
    public sealed class UserSession
    {
        private UserSession() { }
        private UserSession(int id, int zajednicaId, string korisnickoIme, string lozinka, bool isAdmin) 
        {
            Id = id;
            ZajednicaId = zajednicaId;
            KorisnickoIme = korisnickoIme;
            Lozinka = lozinka;
            IsAdmin = isAdmin;
        }
        private static UserSession instance = null;

        public int Id { get; private set; }
        public int ZajednicaId { get; private set; }
        public string KorisnickoIme { get; private set; }
        public string Lozinka { get; private set; }
        public bool IsAdmin { get; private set; }

        public static void createInstance(int id, int zajednicaId, string korisnickoIme, string lozinka, bool isAdmin)
        {
            if(instance == null)
            {
                instance = new UserSession(id, zajednicaId, korisnickoIme, lozinka, isAdmin);
            }
        }
        public static UserSession getInstance()
        {               
            return instance;
        }
    }

    internal class KorisnikPartialInfo
    {
        public KorisnikPartialInfo() { }
    }
}
