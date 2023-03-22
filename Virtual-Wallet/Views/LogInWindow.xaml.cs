using Virtual_Wallet.Models.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using Virtual_Wallet.Controller;

namespace Virtual_Wallet.Views
{
    /// <summary>
    /// Interaction logic for LogInWindow.xaml
    /// </summary>
    public partial class LogInWindow : Window
    {
        private KorisnikController _korisnikController = new KorisnikController();
        public LogInWindow()
        {
            InitializeComponent();
        }

        private void btnRegistracija_Click(object sender, RoutedEventArgs e)
        {
            if(this.Height < MaxHeight)
            {
                pnlRegistracija.Visibility = Visibility.Visible;
                this.Height = MaxHeight;
            }
            else if(this.Height == MaxHeight)
            {
                pnlRegistracija.Visibility = Visibility.Collapsed;
                this.Height = MinHeight;
            }

        }

        private void btnPotvrdiPrijavu_Click(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrEmpty(tbKorisnickoIme.Text) || string.IsNullOrEmpty(pbLozinka.Password))
            {
                MessageBox.Show("Popunite sva potrebna polja!", "Alert", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }
            int loginResult = _korisnikController.LogInAttempt(tbKorisnickoIme.Text, pbLozinka.Password);
            if (loginResult == 0)
            {
                MessageBox.Show("Korisničko ime ili lozinka su neispravni! Pokušajte ponovo!", "Alert", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }
            else if(loginResult == 1)
            {
                ZaposleniMenu _zaposleniMenu = new ZaposleniMenu();
                _zaposleniMenu.Show();
                this.Close();
            }
            
        }

        private void btnRegistracijaPotvrdi_Click(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrEmpty(tbImePrezime.Text) ||
                string.IsNullOrEmpty(tbKorisnickoImeReg.Text) || 
                string.IsNullOrEmpty(pbLozinkaReg.Password) ||
                string.IsNullOrEmpty(pbLozinkaZajednice.Password) ||
                string.IsNullOrEmpty(tbBrojTelefona.Text) ||
                string.IsNullOrEmpty(tbEMail.Text))
            {
                MessageBox.Show("Popunite sva potrebna polja da biste se registrovali!", "Alert", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }
            if(pbLozinkaReg.Password.Length < 8 )
            {
                MessageBox.Show("Lozinka treba da sadrži najmanje 8 znakova", "Alert", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }
            if (pbLozinkaReg.Password.All(char.IsLetter))
            {
                MessageBox.Show("Lozinka nije dovoljno jaka!", "Alert", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }
            
            int registrationResult = _korisnikController.RegistrationProcedure(tbImePrezime.Text, tbKorisnickoImeReg.Text, pbLozinkaReg.Password, pbLozinkaZajednice.Password, tbEMail.Text, tbBrojTelefona.Text);
            if(registrationResult == 1)
            {
                MessageBox.Show("Uspješno ste se registrovali!\n Prijavi se na sistem! ", "Alert", MessageBoxButton.OK, MessageBoxImage.Information);
                this.btnRegistracija_Click(sender, e);
            }
            else if(registrationResult == 0)
            {
                MessageBox.Show("Greška prilikom registracije! pokušajte ponovo!", "Alert", MessageBoxButton.OK, MessageBoxImage.Error);

            }
            return;
        }

        private void cbPrikaziLozinku_Checked(object sender, RoutedEventArgs e)
        {
            if (cbPrikaziLozinku.IsChecked == true)
            {
                pbLozinkaText.Text = pbLozinka.Password;
                pbLozinkaText.Visibility = Visibility.Visible;
            }
        }

        private void cbPrikaziLozinku_Unchecked(object sender, RoutedEventArgs e)
        {
            if (cbPrikaziLozinku.IsChecked == false)
            {
                pbLozinkaText.Visibility = Visibility.Collapsed;
            }
        }

        private void Image_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {

        }

        private void btnPogledajLozinku_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {

        }
    }
}
