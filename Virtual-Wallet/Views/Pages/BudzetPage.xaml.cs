using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
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
    /// Interaction logic for BudzetPage.xaml
    /// </summary>
    public partial class BudzetPage : Page
    {
        private BudzetController _budzetController;
        public BudzetPage()
        {
            InitializeComponent();
            _budzetController = new BudzetController();
            dgBudzeti.ItemsSource = _budzetController.GetData();

        }

        private void dgBudzet_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }

        private void btnDodajBudzet_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnObrisi_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnAzuriraj_Click(object sender, RoutedEventArgs e)
        {

        }

        private void dgBudzeti_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }

        private void btnPrikaziStavke_Click(object sender, RoutedEventArgs e)
        {
            if (dgBudzeti.SelectedItem == null)
            {
                MessageBox.Show("Molimo odaberite budžet za više informacija!", "Error", MessageBoxButton.OK, MessageBoxImage.Information);
                return;
            }
            else
            {
                BudzetViewModel budzetItem = dgBudzeti.SelectedItem as BudzetViewModel;
                dgStavkeBudzet.ItemsSource = _budzetController.GetStavkeBudzeta(budzetItem.Id);
            }
        }

        private void btnStavkaAzuriraj_Click(object sender, RoutedEventArgs e)
        {
            if (dgBudzeti.SelectedItem == null)
            {
                MessageBox.Show("Molimo odaberite stavku budžeta koju želite ažurirati!", "Error", MessageBoxButton.OK, MessageBoxImage.Information);
                return;
            }
            else
            {
                StavkaBudzetaViewModel stavkaItem = dgStavkeBudzet.SelectedItem as StavkaBudzetaViewModel;
                int updateStavkaResult = _budzetController.UpdateStavkaBudzeta(stavkaItem);
                if (updateStavkaResult == 1)
                {
                    dgBudzeti.SelectedItem = null;
                    dgStavkeBudzet.SelectedItem = null;

                    this.dgBudzeti.ItemsSource = _budzetController.GetData();
                    this.dgBudzeti.UpdateLayout();
                }
            }
        }

        private void btnDodajNoviBudzet_Click(object sender, RoutedEventArgs e)
        {
            if (dgBudzeti.SelectedItem == null)
            {
                MessageBox.Show("Popunite polja o budžetu koji želite kreirati!", "Error", MessageBoxButton.OK, MessageBoxImage.Information);
                return;
            }
            else
            {
                BudzetViewModel newBudzetItem = dgBudzeti.SelectedItem as BudzetViewModel;

                string pattern = @"[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}";
                Match m1 = Regex.Match(newBudzetItem.DatumOd, pattern);
                Match m2 = Regex.Match(newBudzetItem.DatumDo, pattern);

                if (m1.Success && m2.Success)
                {
                    DateTime? dateFrom = DateTime.Parse(newBudzetItem.DatumOd);
                    DateTime? dateTo = DateTime.Parse(newBudzetItem.DatumDo);
                    if (dateFrom.HasValue && dateTo.HasValue && dateFrom < dateTo)
                    {
                        int insertBudzetResult = _budzetController.AddNoviBudzet(newBudzetItem);

                        if (insertBudzetResult == 1)
                        {
                            dgBudzeti.SelectedItem = null;
                            this.dgBudzeti.ItemsSource = _budzetController.GetData();
                            this.dgBudzeti.UpdateLayout();
                        }
                    }

                }
                else
                {
                    MessageBox.Show("Neispravan format datuma!", "Error", MessageBoxButton.OK, MessageBoxImage.Information);
                    return;
                }


            }
        }

        private void btnAzurirajBudzet_Click(object sender, RoutedEventArgs e)
        {
            if (dgBudzeti.SelectedItem == null)
            {
                MessageBox.Show("Molimo odaberite budžet za više informacija!", "Error", MessageBoxButton.OK, MessageBoxImage.Information);
                return;
            }
            else
            {
                BudzetViewModel budzetItemToUpdate = dgBudzeti.SelectedItem as BudzetViewModel;

                string pattern = @"[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}";
                Match m1 = Regex.Match(budzetItemToUpdate.DatumOd, pattern);
                Match m2 = Regex.Match(budzetItemToUpdate.DatumDo, pattern);

                if (m1.Success && m2.Success)
                {
                    DateTime? dateFrom = DateTime.Parse(budzetItemToUpdate.DatumOd);
                    DateTime? dateTo = DateTime.Parse(budzetItemToUpdate.DatumDo);

                    if (dateFrom.HasValue && dateTo.HasValue && dateFrom < dateTo)
                    {
                        int updateBudzetResult = _budzetController.UpdateBudzet(budzetItemToUpdate);

                        if (updateBudzetResult == 1)
                        {
                            dgBudzeti.SelectedItem = null;
                            this.dgBudzeti.ItemsSource = _budzetController.GetData();
                            this.dgBudzeti.UpdateLayout();
                        }
                    }

                }
                else
                {
                    MessageBox.Show("Neispravan format datuma!", "Error", MessageBoxButton.OK, MessageBoxImage.Information);
                    return;
                }
            }
        }

        private void btnStavkaIzbrisi_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnStavkaDodaj_Click(object sender, RoutedEventArgs e)
        {

        }
    }
}
