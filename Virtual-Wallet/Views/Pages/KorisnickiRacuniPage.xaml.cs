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
using System.Windows.Navigation;
using System.Windows.Shapes;
using Virtual_Wallet.Controller;
using Virtual_Wallet.Models.ViewModels;

namespace Virtual_Wallet.Views.Pages
{
    /// <summary>
    /// Interaction logic for KorisnickiRacuniPage.xaml
    /// </summary>
    public partial class KorisnickiRacuniPage : Page
    {
        private RacunController _racunController;
        private List<RacunViewModel> _racunViewModelList = new List<RacunViewModel>();
        private List<KategorijaAkcijeViewModel> _kategorijeAkcijaList = new List<KategorijaAkcijeViewModel>();

        public KorisnickiRacuniPage()
        {
            InitializeComponent();
            _racunController = new RacunController();
            dgRacuni.ItemsSource = _racunController.GetData();

            _racunViewModelList = _racunController.GetComboBoxData();
            cbRacun.ItemsSource = cbSaRacuna.ItemsSource = cbNaRacun.ItemsSource = _racunViewModelList.Select(el => el.NazivRacuna);

            _kategorijeAkcijaList = _racunController.GetKategorijaAkcijeData();
            cbKategorijaAkcije.ItemsSource = _kategorijeAkcijaList.Select(el => el.NazivAkcije);
        }

        private void dgRacuni_SelectionChanged(object sender, SelectionChangedEventArgs e)
        { 

        }

        private void btnPotvrdiTransakciju_Click(object sender, RoutedEventArgs e)
        {
            if (String.IsNullOrEmpty(tbTransferIznos.Text) || 
                string.IsNullOrEmpty(cbSaRacuna.SelectedItem.ToString()) || 
                string.IsNullOrEmpty(cbNaRacun.SelectedItem.ToString()))
            {
                MessageBox.Show("Molimo odaberite odgovarajuća polja!", "Alert", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }
            else if (cbSaRacuna.SelectedItem.ToString().Equals(cbNaRacun.SelectedItem.ToString()))
            {
                MessageBox.Show("Transfer se mora obaviti između različitih računa!", "Alert", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }
            else if (Double.Parse(tbTransferIznos.Text.ToString()) <= 0) 
            {
                MessageBox.Show("Iznos novca mora biti veći od 0!", "Alert", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }
            int transferSaId = (int)cbSaRacuna.Tag;
            int transferNaId = (int)cbNaRacun.Tag;
            double iznosTransfera = Double.Parse(tbTransferIznos.Text.ToString());

            int procedureCallStatus = _racunController.TransferMoneyProcedure(transferSaId, transferNaId, iznosTransfera);
            if(procedureCallStatus == 0)
            {
                MessageBox.Show("Greška prilikom transfera novca! Pokušajte ponovo!", "Alert", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }
            else
            {
                MessageBox.Show("Transfer novca uspješno izvršen!", "Alert", MessageBoxButton.OK, MessageBoxImage.Information);   
            }
            this.dgRacuni.ItemsSource = new List<RacunViewModel>();
            this.dgRacuni.ItemsSource = _racunController.GetData();
            this.dgRacuni.UpdateLayout();
        }

        private void Page_DataContextChanged(object sender, DependencyPropertyChangedEventArgs e)
        {
            
        }

        private void Page_Initialized(object sender, EventArgs e)
        {

        }

        private void btnPotvrdiAkciju_Click(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrEmpty(cbRacun.SelectedItem.ToString()) ||
                string.IsNullOrEmpty(cbKategorijaAkcije.SelectedItem.ToString()))
            {
                MessageBox.Show("Molimo odaberite odgovarajuća polja!", "Alert", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }
            else if (Double.Parse(tbIznosAkcije.Text.ToString()) <= 0)
            {
                MessageBox.Show("Iznos novca mora biti veći od 0!", "Alert", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }
            int racunId = (int)cbRacun.Tag;
            int kategorijaAkcijeId = (int)cbKategorijaAkcije.Tag;
            double iznosAkcije = Double.Parse(tbIznosAkcije.Text);

            int statusAkcija = _racunController.AkcijaNaRacunu(racunId, kategorijaAkcijeId, iznosAkcije);
            if (statusAkcija == 0)
            {
                MessageBox.Show("Greška prilikom akcije na računu! Pokušajte ponovo!", "Alert", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }
            else
            {
                MessageBox.Show("Akcija uspješno izvršena!", "Alert", MessageBoxButton.OK, MessageBoxImage.Information);
            }
            this.dgRacuni.ItemsSource = new List<RacunViewModel>();
            this.dgRacuni.ItemsSource = _racunController.GetData();
            this.dgRacuni.UpdateLayout();

        }
        private void cbSaRacuna_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            RacunViewModel temp = _racunViewModelList.FirstOrDefault(el => el.NazivRacuna == cbSaRacuna.SelectedItem.ToString());
            cbSaRacuna.Tag = temp.Id;
        }

        private void cbNaRacun_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            RacunViewModel temp = _racunViewModelList.FirstOrDefault(el => el.NazivRacuna == cbNaRacun.SelectedItem.ToString());
            cbNaRacun.Tag = temp.Id;
        }

        private void cbRacun_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            RacunViewModel temp = _racunViewModelList.FirstOrDefault(el => el.NazivRacuna == cbRacun.SelectedItem.ToString());
            cbRacun.Tag = temp.Id;
        }

        private void cbKategorijaAkcije_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            KategorijaAkcijeViewModel temp = _kategorijeAkcijaList.FirstOrDefault(el => el.NazivAkcije == cbKategorijaAkcije.SelectedItem.ToString());
            cbKategorijaAkcije.Tag = temp.Id;
        }
    }
}
