using System;
using System.Collections.Generic;
using System.Globalization;
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
using Virtual_Wallet.Controllers;
using Virtual_Wallet.Models.ViewModels;

namespace Virtual_Wallet.Views.Pages
{
    /// <summary>
    /// Interaction logic for PodsjetnikPage.xaml
    /// </summary>
    public partial class PodsjetnikPage : Page
    {
        private PodsjetnikController _podsjetnikController;
        public PodsjetnikPage()
        {
            InitializeComponent();
            _podsjetnikController = new PodsjetnikController();
            dgPodsjetnik.ItemsSource = _podsjetnikController.GetData();
        }

        private void btnDodaj_Click(object sender, RoutedEventArgs e)
        {
            if(spDodajNovuStavku.Visibility == Visibility.Hidden)
            {
                spDodajNovuStavku.Visibility = Visibility.Visible;
                return;
            }
            else if(spDodajNovuStavku.Visibility == Visibility.Visible)
            {
                if(string.IsNullOrEmpty(tbOpis.Text) || dtpDatumOd.SelectedDate == null || dtpDatumDo.SelectedDate == null)
                {
                    MessageBox.Show("Unesite potrebne podatke!", "Alert", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }
                else
                {
                    var dateFrom = dtpDatumOd.SelectedDate.Value.Date.ToString("yyyy-MM-dd");
                    var dateTo = dtpDatumDo.SelectedDate.Value.Date.ToString("yyyy-MM-dd");
                    var insertResult = _podsjetnikController.InsertNewRecord(tbOpis.Text, dateFrom, dateTo);
                    if (insertResult == 1)
                    {
                        MessageBox.Show("Uspješno ste dodali novu stavku u podsjetnik!", "Alert", MessageBoxButton.OK, MessageBoxImage.Information);
                        this.dgPodsjetnik.ItemsSource = new List<PodsjetnikViewModel>();
                        this.dgPodsjetnik.ItemsSource = _podsjetnikController.GetData();
                        this.dgPodsjetnik.UpdateLayout();
                    }
                    else if (insertResult == -1)
                    {
                        MessageBox.Show("Greška prilikom dodavanja nove stavke! Pokušajte ponovo!", "Alert", MessageBoxButton.OK, MessageBoxImage.Error);                       
                    }
                    return;
                }
                
            }
           
        }

        private void dgPodsjetnik_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }

        private void btnAzuriraj_Click(object sender, RoutedEventArgs e)
        {
            if(dgPodsjetnik.SelectedItem == null)
            {
                MessageBox.Show("Molimo odaberite stavku!", "Alert", MessageBoxButton.OK, MessageBoxImage.Information);
                return;
            }
            else
            {
                var podjsetnikToUpdate = dgPodsjetnik.SelectedItem as PodsjetnikViewModel;
                var updateResult = _podsjetnikController.UpdateRecord(podjsetnikToUpdate);
                if (updateResult == 1)
                {
                    MessageBox.Show("Uspješno ste ažurirali stavku!", "Alert", MessageBoxButton.OK, MessageBoxImage.Information);
                    this.dgPodsjetnik.ItemsSource = new List<PodsjetnikViewModel>();
                    this.dgPodsjetnik.ItemsSource = _podsjetnikController.GetData();
                    this.dgPodsjetnik.UpdateLayout();
                }
                else if (updateResult == -1)
                {
                    MessageBox.Show("Greška prilikom ažuriranja nove stavke! Pokušajte ponovo!", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                }
                return;

            }
            
        }

        private void btnObrisi_Click(object sender, RoutedEventArgs e)
        {
            if (dgPodsjetnik.SelectedItem == null)
            {
                MessageBox.Show("Molimo odaberite stavku!", "Alert", MessageBoxButton.OK, MessageBoxImage.Information);
                return;
            }
            else
            {
                var podjsetnikToUpdate = dgPodsjetnik.SelectedItem as PodsjetnikViewModel;
                var deleteResult = _podsjetnikController.DeleteRecord(podjsetnikToUpdate);
                if (deleteResult == 1)
                {
                    MessageBox.Show("Uspješno obrisali stavku!", "Alert", MessageBoxButton.OK, MessageBoxImage.Information);
                    this.dgPodsjetnik.ItemsSource = new List<PodsjetnikViewModel>();
                    this.dgPodsjetnik.ItemsSource = _podsjetnikController.GetData();
                    this.dgPodsjetnik.UpdateLayout();
                }
                else if (deleteResult == -1)
                {
                    MessageBox.Show("Greška prilikom brisanja stavke! Pokušajte ponovo!", "Alert", MessageBoxButton.OK, MessageBoxImage.Error);
                }
                return;
            }
        }
    }
}
