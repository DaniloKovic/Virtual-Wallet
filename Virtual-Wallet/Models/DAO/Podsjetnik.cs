using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Virtual_Wallet.Models.DAO
{
    public class Podsjetnik
    {
        public int Id { get; set; }
        public int KorisnikId { get; set; }
        public string Opis { get; set; }
        public DateTime? DatumOd { get; set; }
        public DateTime? DatumDo { get; set; }
        public bool Zavrseno { get; set; }
    }
}
