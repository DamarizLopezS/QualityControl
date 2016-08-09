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
    /// Interaction logic for InspectionStats.xaml
    /// </summary>
    public partial class InspectionStats : Window
    {

        public InspectionStats()
        {
            InitializeComponent();
        }

        public InspectionStats(Lot lot)
        {
            InitializeComponent();
            Global.Lot = lot;
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            lblLotCode.Content = Global.Lot.Code;
            lblLotProduct.Content = Global.Lot.Product.Name;

            dgItems.Items.Clear();
            dgItems.ItemsSource = Global.Items;
        }

        private void Button_SelectLot(object sender, RoutedEventArgs e)
        {
            LotsToInspection winLotsToInspect = new LotsToInspection();
            //aqui falta para ver si se modifico algo
            winLotsToInspect.Show();
            this.Close();
        }

        private void Button_Send(object sender, RoutedEventArgs e)
        {
            Connection c = new Connection();
            
        }

        private void Button_Inspection(object sender, RoutedEventArgs e)
        {
            if (sender is Button)
            {
                Button btn = new Button();
                
                Item i = (Item)dgItems.SelectedItem;
                InspectionWindow winInspection = new InspectionWindow(Global.Items, i.Serie);

                winInspection.Show();
                this.Close();
            }
        }

        private void dgItems_Loaded(object sender, RoutedEventArgs e)
        {
            pbItemsChecked.Maximum = Global.Items.Count;
            pbItemsChecked.Value = ItemsChecked();
        }

        private int ItemsChecked()
        {
            int itemsChecked = 0;

            foreach (Item item in Global.Items)
            {
                if (item.Status != Status.NOTEVALUATE)
                    itemsChecked++;
            }

            return itemsChecked;
        }
    }
}
