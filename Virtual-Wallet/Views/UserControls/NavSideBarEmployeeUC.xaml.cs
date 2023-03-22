using System.Windows;
using System.Windows.Controls;
using Virtual_Wallet.Views.Pages;
using Virtual_Wallet.Views;
using System.Windows.Media;
using Virtual_Wallet.Models.Enums;

namespace Virtual_Wallet.Views.UserControls
{
    /// <summary>
    /// Interaction logic for NavSideBarEmployeeUC.xaml
    /// </summary>
    public partial class NavSideBarEmployeeUC : UserControl
    {
        public NavSideBarEmployeeUC()
        {
            InitializeComponent();
        }

        private void btnKnjige_Click(object sender, RoutedEventArgs e)
        {
            ((ZaposleniMenu)(Window.GetWindow(this))).ZaposleniMenuContainer.Content = new AboutUsPage();
        }

        private void btnMojaZaduzenja_Click(object sender, RoutedEventArgs e)
        {
            ((ZaposleniMenu)(Window.GetWindow(this))).ZaposleniMenuContainer.Content = new AboutUsPage();
        }

        private void btnMojNalog_Click(object sender, RoutedEventArgs e)
        {
            ((ZaposleniMenu)(Window.GetWindow(this))).ZaposleniMenuContainer.Content = new AboutUsPage();
        }

        private void btnONama_Click(object sender, RoutedEventArgs e)
        {
            ((ZaposleniMenu)(Window.GetWindow(this))).ZaposleniMenuContainer.Content = new AboutUsPage();
        }

        private void btnDodajNovuKnjigu_Click(object sender, RoutedEventArgs e)
        {
            ((ZaposleniMenu)(Window.GetWindow(this))).ZaposleniMenuContainer.Content = new AboutUsPage();
        }

        private void btnNovoZaduzenje_Click(object sender, RoutedEventArgs e)
        {
            ((ZaposleniMenu)(Window.GetWindow(this))).ZaposleniMenuContainer.Content = new AboutUsPage();
        }

        private void btnKorisnickiNalozi_Click(object sender, RoutedEventArgs e)
        {
            ((ZaposleniMenu)(Window.GetWindow(this))).ZaposleniMenuContainer.Content = new AboutUsPage();
        }

        private void btnRacuni_Click(object sender, RoutedEventArgs e)
        {
            ((ZaposleniMenu)(Window.GetWindow(this))).ZaposleniMenuContainer.Content = new KorisnickiRacuniPage();
        }

        private void btnPodsjetnik_Click(object sender, RoutedEventArgs e)
        {
            ((ZaposleniMenu)(Window.GetWindow(this))).ZaposleniMenuContainer.Content = new PodsjetnikPage();
        }

        private void btnBudzet_Click(object sender, RoutedEventArgs e)
        {
            ((ZaposleniMenu)(Window.GetWindow(this))).ZaposleniMenuContainer.Content = new BudzetPage();
        }

        private void btnNoviBudzet_Click(object sender, RoutedEventArgs e)
        {
            ((ZaposleniMenu)(Window.GetWindow(this))).ZaposleniMenuContainer.Content = new NoviBudzetPage();
        }
    }
}
