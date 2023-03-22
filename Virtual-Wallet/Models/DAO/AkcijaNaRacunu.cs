using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Virtual_Wallet.Models.DAO
{
    public class AkcijaNaRacunu
    {
        public int Id { get; set; }
        public int RacunId { get; set; }
        public int KategorijaAkcijeId { get; set; }
        public double IznosAkcije { get; set; }
        public DateTime DatumAkcije { get; set; }
    }
}
