using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Virtual_Wallet.Models.DAO
{
    public class Racun
    {
        public int Id { get; set; }
        public int TipRacunaId { get; set; }
        public int KorisnikId { get; set; }
        public double Iznos { get; set; }
        public DateTime DatumKreiranja { get; set; }

        [StringLength(3, ErrorMessage = "Jmb must contain 13 characters.")]
        public string Valuta { get; set; }
    }
}
