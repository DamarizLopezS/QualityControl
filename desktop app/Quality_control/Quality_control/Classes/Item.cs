///////////////////////////////////////////////////////////
//  Item.cs
//  Implementation of the Class Item
//  Generated by Enterprise Architect
//  Created on:      18-Jul-2016 9:13:59 PM
//  Original author: UserAnonymous
///////////////////////////////////////////////////////////

using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using MySql.Data.MySqlClient;
using System.Data;


public class Item {

	private int _serie;
	private Lot _Lot;
    private Status _status;
    private Inspection _Inspection;

    /// <summary>
    /// Empty Item
    /// </summary>
    public Item()
    {
        _serie = 0;
        _Lot = new Lot();
        _status = Status.NOTEVALUATE;
        _Inspection = new Inspection();
    }

    /// <summary>
    /// Item with values
    /// </summary>
    /// <param name="serie"></param>
    /// <param name="lot"></param>
    /// <param name="status"></param>
    /// <param name="inspection"></param>
    public Item(int serie, Lot lot, Status status)
    {
        _serie = serie;
        _Lot = lot;
        _status = status;
        _Inspection = Get.Inspection(this);
    }

    /// <summary>
    /// Gets Item from DB
    /// </summary>
    /// <param name="serie"></param>
    public Item(int serie){
        Connection c = new Connection();
        MySqlCommand command = new MySqlCommand(
            "SELECT itm_serie, lot_code, itm_status FROM items WHERE itm_serie = ?SERIE"
            );
        command.Parameters.AddWithValue("?SERIE",serie);

        DataRow firstRow = c.GetFirstRow(command);
        if (firstRow != null)
        {
            _serie = int.Parse(firstRow["itm_serie"].ToString());
            _Lot = new Lot(int.Parse(firstRow["lot_code"].ToString()));
            _status = (Status)firstRow["itm_status"];
            _Inspection = new Inspection(this);
        }
        else
            throw new ObjectNotFoundException("Item");
	}

    /// <summary>
    /// Serie
    /// </summary>
	public int Serie{
		get{
			return _serie;		}
	}

    /// <summary>
    /// Lot
    /// </summary>
    public Lot Lot
    {
        get
        {
            return _Lot;
        }

        set
        {
            _Lot = value;
        }
    }

    /// <summary>
    /// Status
    /// </summary>
    public Status Status
    {
        get
        {
            return _status;
        }

        set
        {
            _status = value;
        }
    }

    public Inspection Inspection
    {
        get
        {
            return _Inspection;
        }

        set
        {
            _Inspection = value;
        }
    }

    public override bool Equals(object obj)
    {
        return obj is Item && (obj as Item).Serie == this.Serie;
    }

    public override int GetHashCode()
    {
        return this.Serie;
    }
}//end Item