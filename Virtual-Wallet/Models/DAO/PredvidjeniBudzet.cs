using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Virtual_Wallet.Models.DAO
{
    public class PredvidjeniBudzet
    {
        public int Id { get; set; }
        public int KorisnikId { get; set; }
        public DateTime DatumOd { get; set; }
        public DateTime DatumDo { get; set; }
        public double Iznos { get; set; }
    }
}
