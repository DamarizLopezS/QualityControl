using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

public class Global
{
    private static List<Lot> _lots;
    private static List<List<Item>> _lotItems;

    private static Lot _lot;
    private static Lot _currentLot;
    private static Item _item;
    private static List<Answer> _answers;
    private static List<List<Inspection[]>> _lotInspecitons;

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

    public static List<List<Item>> LotItems
    {
        get
        {
            if (_lotItems == null || _lotItems.Count == 0 || _lots.Count > _lotItems.Count)
            {
                _lotItems = new List<List<Item>>();
                if (_lots != null)
                {
                    foreach (Lot lot in _lots)
                    {
                        List<Item> items = Catalog.Items(lot);
                        _lotItems.Add(items);
                    }
                }
            }
            return _lotItems;
        }
        set
        {
            _lotItems = value;
        }
    }

    public static List<Item> Items
    {
        get
        {
            return LotItems[Get.GlobalPosition(Lot)];
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

    public static Item Item
    {
        get
        {
            return _item;
        }

        set
        {
            _item = value;
        }
    }

    public static List<Answer> Answers
    {
        get
        {
            return _answers;
        }

        set
        {
            _answers = value;
        }
    }

    public static Lot CurrentLot
    {
        get
        {
            return _currentLot;
        }

        set
        {
            _currentLot = value;
        }
    }

    /// <summary>
    /// Inspections by lots
    /// </summary>
    public static List<List<Inspection[]>> LotInspecitons
    {
        get
        {
            if(_lots !=null)
            {
                for (int i = 0; i < _lots.Count; i++)
                {
                    _lotInspecitons.Add(new List<Inspection[]>());
                    _lotInspecitons[i].Add(new Inspection[0]);
                }
            }
            return _lotInspecitons;
        }

        set
        {
            _lotInspecitons = value;
        }
    }

    /// <summary>
    /// Inspections by items from global Lot
    /// </summary>
    public static List<Inspection[]> ItemInspections
    {
        get
        {
            return LotInspecitons[Get.GlobalPosition(_lot)];
        }
        set
        {
            LotInspecitons[Get.GlobalPosition(_lot)] = value;
        }
    }


    /// <summary>
    /// Inspections from global Item
    /// </summary>
    public static Inspection[] Inspections
    {
        get
        {
            return ItemInspections[Get.GlobalPosition(_item)];
        }
        set
        {
            ItemInspections[Get.GlobalPosition(_item)] = value;
        }
    }
}
