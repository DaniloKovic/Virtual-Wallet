using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Virtual_Wallet.Models.ViewModels
{
    public class StavkaBudzetaViewModel
    {
        public int KategorijaStavkeId { get; set; }
        public string KategorijaStavkeNaziv { get; set; }
        public int BudzetId { get; set; }
        public double PredvidjeniIznos { get; set; }
        public double TrenutniIznos { get; set; }
        public string Opis { get; set; }
    }
}
