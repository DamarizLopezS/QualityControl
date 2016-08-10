using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

public class Global
{
    private static List<Lot> _lots;
    private static Lot _lot;

    private static List<Item> _items;
    private static Item _item;

    private static List<Inspection> _inspections;
    private static Inspection _inspection;

    public static List<Lot> Lots
    {
        get
        {
            return _lots;
        }

        set
        {
            _lots = value;
        }
    }

    public static Lot Lot
    {
        get
        {
            return _lot;
        }

        set
        {
            _lot = value;
        }
    }

    public static List<Item> Items
    {
        get
        {
            Items = Catalog.Items(_lot);
            return _items;
        }
        private set
        {
            _items = value;
        }
    }

    public static Item Item
    {
        get { return _item; }
        set { _item = value; }
    }

    public static List<Inspection> Inspections
    {
        get
        {
            return _inspections;
        }
        private set
        {
            _inspections = value;
        }
    }

    private int Position(Lot lot)
    {
        int index = -1;

        for (int i = 0; i < _lots.Count; i++)
            if (lot == _lots[i])
                index = i;

        return index;
    }

    private int Position(Item item)
    {
        int index = -1;

        for (int i = 0; i < _items.Count; i++)
            if (item == _items[i])
                index = i;

        return index;
    }
}
