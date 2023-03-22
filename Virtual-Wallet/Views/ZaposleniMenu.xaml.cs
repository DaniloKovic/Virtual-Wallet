using Virtual_Wallet.Views.Pages;
using Virtual_Wallet.Views.UserControls;
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

namespace Virtual_Wallet.Views
{
    /// <summary>
    /// Interaction logic for ZaposleniMenu.xaml
    /// </summary>
    public partial class ZaposleniMenu : Window
    {
        private Grid _windowGrid = new Grid();
        private List<DockPanel> _dockPanelList = new List<DockPanel>();
        public ZaposleniMenu()
        {
            InitializeComponent();
            // ApplyCustomStyle(LoggedUserHelper.currentUserTemplateID.ToString());
        }

        private void ApplyCustomStyle(string templateID)
        {
            var windowChildControls = LogicalTreeHelper.GetChildren(this);
            _windowGrid = windowChildControls.OfType<Grid>().ElementAt(0);
            foreach (var gridChild in _windowGrid.Children)
            {
                if (gridChild.GetType() == typeof(DockPanel))
                {
                    DockPanel dockPanel = (DockPanel)gridChild;
                    if (!dockPanel.Name.Equals("dpZaposleniFrame"))
                        _dockPanelList.Add(dockPanel);
                }
            }
            foreach (var dockPanel in _dockPanelList)
            {
                dockPanel.Style = (Style)Application.Current.FindResource($"dpTemplateStyle{templateID}");
            }
        }

        private void btnKnjige_Click(object sender, RoutedEventArgs e)
        {
            ZaposleniMenuContainer.Content = new AboutUsPage(); // Učitavanje odgovarajućeg Page objekta u Frame(Container)
        }

        private void btnMojaZaduzenja_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnMojNalog_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnONama_Click(object sender, RoutedEventArgs e)
        {

        }
    }
}
