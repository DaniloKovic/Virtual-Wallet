using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Virtual_Wallet.Models.DAO
{
    public class Korisnik
    {
        [Key]
        [Column(Order = 1)]
        public int Id { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(13, ErrorMessage = "Jmb must contain 13 characters.")]
        [RegularExpression("^[0-9]{13}$", ErrorMessage = "Only numbers are allowed.")]
        public string Jmb { get; set; }

        public int ZajednicaId { get; set; }    

        public string Ime { get; set; }
        public string Prezime { get; set; }

        [RegularExpression("^[a-zA-Z0-9]*$", ErrorMessage = "Only Alphabets and Numbers allowed.")]
        public string KorisnickoIme { get; set; }
        public string Lozinka { get; set; }
        public bool IsAdmin { get; set; }

        [RegularExpression("^+?[1 - 9][0 - 9]{7, 12}$")]
        public string Telefon { get; set; }
        public string Email { get; set; }

    }
}
