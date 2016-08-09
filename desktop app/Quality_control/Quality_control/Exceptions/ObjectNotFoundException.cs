using System;

public class ObjectNotFoundException : Exception
{
    private string _object;

    public override string Message
    {
        get
        {
            return _object+" not found in the database.";
        }
    }

    public ObjectNotFoundException(string obj)
    {
        _object = obj;
    }
}