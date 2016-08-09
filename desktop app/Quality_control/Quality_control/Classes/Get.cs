using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

public class Get
{

    /// <summary>
    /// Answers for Lot
    /// </summary>
    /// <param name="lot">Lot where get questions</param>
    /// <param name="item">Item</param>
    /// <returns></returns>
    public static List<Answer> Answers(Lot lot, Item item)
    {
        List<Answer> answers = new List<Answer>();

        foreach (Question ques in lot.Product.Questions)
            answers.Add(new Answer(item, ques));

        return answers;
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="inspection"></param>
    /// <returns></returns>
    public static List<Answer> Answers(Inspection inspection)
    {
        return inspection.Answers;
    }

    /// <summary>
    /// Get Item by serie number
    /// </summary>
    /// <param name="items">Items to search</param>
    /// <param name="itemSerie">Serie number</param>
    /// <returns></returns>
    public static Item Item(List<Item> items, int itemSerie)
    {
        Item item = new Item();
        foreach (Item i in items)
        {
            if (i.Serie == itemSerie)
                item = i;
        }
        return item;
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="item"></param>
    /// <param name="inspections"></param>
    /// <returns></returns>
    public static Inspection Inspection(Item item, List<Inspection> inspections)
    {
        Inspection i = new Inspection();

        foreach(Inspection ins in inspections)
        {
            if(ins.Answers.Count>0)
            {
                if (ins.Answers[0].Item.Serie == item.Serie)
                    i = ins;
            }
        }
        return i;
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="items"></param>
    /// <param name="itemSerie"></param>
    /// <returns></returns>
    public static int ItemPosition(List<Item> items, int itemSerie)
    {
        int position = -1;

        for (int i = 0; i < items.Count; i++)
        {
            if (items[i].Serie == itemSerie)
                position = i;
        }

        return position;
    }

    public static Status InspectionStatus(Inspection inspection)
    {
        Status status = Status.NOTEVALUATE;

        if (inspection != null & inspection.Answers.Count>0)
        {
            int results = 0;
            foreach (Answer answer in inspection.Answers)
            {
                if (answer.Value == AnswerValue.YES)
                    results += 1;
            }
            if (results == inspection.Answers.Count)
                status = Status.APPROVED;
            else if (results < inspection.Answers.Count && results>0)
            {
                if (results >= inspection.Answers.Count * .95)
                    status = Status.APPROVED;
                else if (results < inspection.Answers.Count * .95)
                    status = Status.NOTEVALUATE;
            }
            else if (results == 0)
                status = Status.NOTEVALUATE;
        }
        return status;
    }

    public static int GlobalPosition(Lot lot)
    {
        int index = -1;

        for (int i = 0; i < Global.Lots.Count; i++)
        {
            if (Global.Lots[i].Code == lot.Code)
                index = i;
        }

        return index;
    }

    public static bool IsInspectionChanged(List<Inspection> inspections)
    {
        bool isChanged = false;

        foreach (Inspection inspection in inspections)
        {
            
        }

        return isChanged;
    }

}