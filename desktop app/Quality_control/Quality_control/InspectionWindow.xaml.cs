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
    /// Interaction logic for Inspection.xaml
    /// </summary>
    public partial class InspectionWindow : Window
    {
        private int _itemSelectedPosition;

        public InspectionWindow()
        {
            InitializeComponent();
            Global.Item = new Item();
            _itemSelectedPosition = -1;
            Global.Inspections = new Inspection[Global.Items.Count];
        }

        public InspectionWindow(List<Item> items)
        {
            InitializeComponent();
            if (Global.Items.Count > 0)
            {
                Global.Item = Global.Items[0];
                Global.CurrentLot = Global.Item.Lot;
                _itemSelectedPosition = -1;
                Global.Inspections = new Inspection[Global.Items.Count];
            }
        }

        public InspectionWindow(List<Item> items, int itemSerie)
        {
            InitializeComponent();
            Global.Item = Get.Item(Global.Items, itemSerie);
            _itemSelectedPosition = Get.ItemPosition(Global.Items, itemSerie);
            Global.CurrentLot = Global.Item.Lot;
            if (Global.Inspections == null || Global.Lot != Global.CurrentLot)
                Global.Inspections = new Inspection[Global.Items.Count];
        }
        public void Window_Loaded(object sender, RoutedEventArgs e)
        {
            LoadInfo();
        }

        private void Button_Next(object sender, RoutedEventArgs e)
        {
            if (_itemSelectedPosition < Global.Items.Count - 1)
            {
                Global.Item = Global.Items[++_itemSelectedPosition];
                LoadInfo();
            }
        }

        private void Button_AllItems(object sender, RoutedEventArgs e)
        {
            InspectionStats winInspectionStats = new InspectionStats(Global.CurrentLot);

            winInspectionStats.Show();

            this.Close();
        }

        private void Button_Previous(object sender, RoutedEventArgs e)
        {
            if (_itemSelectedPosition > 0)
            {
                Global.Item = Global.Items[--_itemSelectedPosition];
                LoadInfo();
            }
        }

        private void Button_Inspect(object sender, RoutedEventArgs e)
        {
            Inspect(sender,e);
        }

        private void Inspect(object sender, RoutedEventArgs e)
        {
            if (Global.Inspections[_itemSelectedPosition] == null)
                Global.Inspections[_itemSelectedPosition] = new Inspection(Get.Answers(Global.CurrentLot,Global.Item));

            for (int i  = 0; i  < Global.Inspections[_itemSelectedPosition].Answers.Count; i ++)
            {
                Global.Inspections[_itemSelectedPosition].Answers[i] = (Answer)dgInspection.Items[i];
            }

            Global.Item.Status = Get.InspectionStatus(Global.Inspections[_itemSelectedPosition]);

            if(Global.Item.Status == Status.NOTEVALUATE)
            {
                double noResult = 0;
                foreach (Answer answer in Global.Inspections[_itemSelectedPosition].Answers)
                {
                    if (answer.Value == AnswerValue.NO)
                        noResult++;
                }
                if (noResult / Global.Inspections[_itemSelectedPosition].Answers.Count <= 0.08)// mandar el 0.08 a configuracion
                    Global.Item.Status = Status.APPROVED;
                else
                    Global.Item.Status = Status.REWORK;
            }
            
            ConfirmLotInspection(sender,e);
        }

        private void ConfirmLotInspection(object sender, RoutedEventArgs e)
        {
            if (_itemSelectedPosition + 1 < Global.Inspections.Length - 1)
                Button_Next(sender, e);
            else if (ItemsChecked() < Global.Inspections.Length)
            {
                _itemSelectedPosition = FindInspection();
                Global.Item = Global.Items[_itemSelectedPosition];
                LoadInfo();
            }
            else
            {
                MessageBoxResult result = MessageBox.Show("Lot: " + Global.CurrentLot.Code + " CHECKED");
                if (result == MessageBoxResult.OK)
                    Button_AllItems(sender, e);
            }
        }

        private int ItemsChecked()
        {
            int itemsChecked = 0;

            for (int i = 0; i < Global.Inspections.Length; i++)
            {
                if (Global.Inspections[i] != null)
                    itemsChecked++;
            }

            return itemsChecked;
        }

        private int FindInspection()
        {
            int i = Global.Inspections.Length;

            for (int ind = Global.Items.Count - 1; ind >= 0; ind--)
            {
                if (Global.Inspections[ind] == null)
                    i = ind;
                try
                {
                    if (Global.Inspections[ind - 1] != null)
                    {
                        i = ind;
                    }
                }
                catch (IndexOutOfRangeException) { }
            }
            for (int ind = 0; ind < Global.Items.Count; ind++)
            {
                if (Global.Inspections[ind] == null)
                    i = ind;
            }

            return i;
        }

        private void LoadInfo()
        {
            lblLot.Content = Global.CurrentLot.Code;
            lblDate.Content = DateTime.Now;
            lblProduct.Content = Global.CurrentLot.Product;
            lblItemSerie.Content = Global.Item.Serie;
            if (Global.Inspections[_itemSelectedPosition] == null || Global.Inspections.Length == 0)
            {
                Global.Answers = Get.Answers(Global.CurrentLot, Global.Item);
                dgInspection.ItemsSource = Global.Answers;
            }
            else
            {
                Global.Answers = Get.Answers(Global.Inspections[_itemSelectedPosition]);
                dgInspection.ItemsSource = Global.Answers;
            }
            Refresh();
        }

        private void btnYes_Click(object sender, RoutedEventArgs e)
        {
            if (sender is Button)
            {
                Answer a = (Answer)dgInspection.SelectedItem;
                if (a.Value != AnswerValue.YES)
                    a.Value = AnswerValue.YES;
                else
                    a.Value = AnswerValue.NOTVALUE;
                Global.Answers[dgInspection.SelectedIndex] = a;
                Refresh();
            }
        }

        private void btnNo_Click(object sender, RoutedEventArgs e)
        {
            if (sender is Button)
            {
                Answer a = (Answer)dgInspection.SelectedItem;
                if (a.Value != AnswerValue.NO)
                    a.Value = AnswerValue.NO;
                else
                    a.Value = AnswerValue.NOTVALUE;
                Global.Answers[dgInspection.SelectedIndex] = a;
                Refresh();
            }
        }

        private void Refresh()
        {
            dgInspection.Items.Refresh();
            btnInspect.IsEnabled = IsInspectComplete();
        }

        private bool IsInspectComplete()
        {
            bool isInspectionComplete = true;

            foreach (Answer answ in dgInspection.Items)
            {
                if (answ.Value == AnswerValue.NOTVALUE)
                    isInspectionComplete = false;
            }

            return isInspectionComplete;
        }
    }
}
