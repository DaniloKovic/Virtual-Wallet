using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Virtual_Wallet.Models.ViewModels
{
    public class BudzetViewModel
    {
        public int Id { get; set; }
        public int KorisnikId { get; set; }
        public string DatumOd { get; set; }
        public string DatumDo { get; set; }
        public string Mjesec { get; set; }
        public double PredvidjeniIznos { get; set; }
        public double TrenutniIznos { get; set; }
    }
}
