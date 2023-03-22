using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Virtual_Wallet.Models.ViewModels
{
    public class RacunViewModel
    {
        public int Id { get; set; }
        public string NazivRacuna { get; set; }
        public int KorisnikId { get; set; }
        public string Iznos { get; set; }
        public string DatumKreiranja { get; set; }

        public string Valuta { get; set; }
    }
}
