﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MySql.Data.MySqlClient;
using System.Data;

public class Inspection
{
    private int _id;
    private List<Answer> _answers;

    public Inspection()
    {
        _id = 0;
        _answers = new List<Answer>();
    }

    public Inspection(int id)
    {
        Connection c = new Connection();
        MySqlCommand command = new MySqlCommand(
            "SELECT ins_id FROM inspections WHERE ins_id = ?ID"
            );
        command.Parameters.AddWithValue("?ID",id);
        DataRow inspection = c.GetFirstRow(command);
        if(inspection!=null)
        {
            _id = (int)inspection["ins_id"];
            // Get answers
            MySqlCommand answersCommand = new MySqlCommand(
                "SELECT anw_id, anw_value, que_id, itm_id FROM inspection_answers WHERE ins_id = ?INSID"
                );
            answersCommand.Parameters.AddWithValue("?INSID", _id);
            DataTable table = c.ExecuteQuery(command);
            _answers = new List<Answer>();
            foreach(DataRow r in table.Rows)
            {
                _answers.Add(
                    new Answer(
                        int.Parse(r["anw_id"].ToString()),
                        (AnswerValue)int.Parse(r["anw_value"].ToString()),
                        new Item(int.Parse(r["itm_id"].ToString())),
                        new Question(int.Parse(r["que_id"].ToString()))
                        )
                    );
            }
        }

    }

    public Inspection(List<Answer> answers)
    {
        _id = 0;
        _answers = answers;
    }

    public int Id
    {
        get
        {
            return _id;
        }
    }

    public List<Answer> Answers
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
}
