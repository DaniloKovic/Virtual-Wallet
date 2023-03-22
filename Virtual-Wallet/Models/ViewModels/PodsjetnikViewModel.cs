using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Virtual_Wallet.Models.ViewModels
{
    public class PodsjetnikViewModel
    {
        public int Id { get; set; }
        public int KorisnikId { get; set; }
        public string Opis { get; set; }
        public string DatumOd { get; set; }
        public string DatumDo { get; set; }

        public bool Zavrseno { get; set; }
    }
}
