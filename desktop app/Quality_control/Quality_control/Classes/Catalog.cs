using System;
using System.Collections.Generic;
using System.Data;
using MySql.Data.MySqlClient;
using System.Collections;

public class Catalog
{
    private static Connection connection;

    /// <summary>
    /// All Lots
    /// </summary>
    public static List<Lot> Lots
    {
        get
        {
            List<Lot> lots = new List<Lot>();

            connection = new Connection();
            DataTable table = connection.ExecuteQuery(
                "SELECT lot_code FROM lots"
                );
            foreach (DataRow row in table.Rows)
            {
                lots.Add(new Lot(int.Parse(row["lot_code"].ToString())));
            }

            return lots;
        }
    }

    public static List<Lot> LotsUnchecked
    {
        get
        {
            List<Lot> lots = new List<Lot>();

            connection = new Connection();
            DataTable table = connection.ExecuteQuery(
                "SELECT lot_code FROM lots WHERE lot_status = " + (int)Status.NOTEVALUATE
                );
            foreach (DataRow row in table.Rows)
            {
                lots.Add(new Lot(int.Parse(row["lot_code"].ToString())));
            }

            return lots;
        }
    }

    /// <summary>
    /// All items
    /// </summary>
    public static List<Item> AllItems
    {
        get
        {
            List<Item> items = new List<Item>();
            connection = new Connection();
            DataTable table = connection.ExecuteQuery(
                "SELECT itm_serie, lot_code, itm_status FROM items"
                );
            foreach (DataRow row in table.Rows)
            {
                items.Add(new Item(int.Parse(row["itm_serie"].ToString())));
            }

            return items;
        }
    }


    /// <summary>
    /// Items from a Lot
    /// </summary>
    /// <param name="lot">Lot</param>
    /// <returns></returns>
    public static List<Item> Items(Lot lot)
    {
        List<Item> items = new List<Item>();

        connection = new Connection();
        MySqlCommand command = new MySqlCommand(
            "SELECT itm_serie, itm_status FROM items WHERE lot_code = ?CODE"
            );
        command.Parameters.AddWithValue("?CODE", lot.Code);
        DataTable table = connection.ExecuteQuery(command);
        foreach (DataRow row in table.Rows)
        {
            items.Add(new Item(int.Parse(row["itm_serie"].ToString()), lot, (Status)int.Parse(row["itm_status"].ToString())));
        }

        return items;
    }

    /// <summary>
    /// Item from List of Lots
    /// </summary>
    /// <param name="lots">Lots</param>
    /// <returns></returns>
    public static List<Item> Items(List<Lot> lots)
    {
        List<Item> items = new List<Item>();

        connection = new Connection();
        MySqlCommand command = new MySqlCommand(
            "SELECT itm_serie, itm_status FROM items WHERE lot_code in (?CODES)"
            );
        command.Parameters.AddWithValue("?CODES", ByComas(lots));
        DataTable table = connection.ExecuteQuery(command);
        foreach (Lot lot in lots)
        {
            foreach (DataRow row in table.Rows)
            {
                items.Add(new Item(int.Parse(row["itm_serie"].ToString()), lot, (Status)row["itm_status"]));
            }
        }

        return items;
    }


    private static string ByComas(List<Lot> lots)
    {
        string result = "";

        foreach (Lot lot in lots)
        {
            result += lot.Code + ",";
        }
        result = result.Substring(0, result.Length - 1);

        return result;
    }
}
