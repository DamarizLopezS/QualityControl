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

namespace WPFAppQualityControl
{
    /// <summary>
    /// Interaction logic for LotsToInspection.xaml
    /// </summary>
    public partial class LotsToInspection : Window
    {

        public LotsToInspection()
        {
            InitializeComponent();
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            dgLots.Items.Clear();
            Global.Lots = Catalog.LotsUnchecked;
            dgLots.ItemsSource = Global.Lots;
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            if (dgLots.SelectedItem != null)
            {
                Global.Lot = new Lot(((Lot)dgLots.SelectedItem).Code);

                if (sender is Button)
                {
                    InspectionStats winInspectionStats = new InspectionStats();
                    winInspectionStats.Show();
                    this.Close();
                }
            }
        }
    }
}
