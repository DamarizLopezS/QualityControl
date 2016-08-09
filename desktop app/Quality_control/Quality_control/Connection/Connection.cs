using MySql.Data.MySqlClient;
using System.Data;
using System.Configuration;

public class Connection
{
    #region attributes
    private MySqlConnection _connection;
    #endregion

    #region methods
    private bool Open()
    {
        bool result = false;
        try
        {
            _connection.Open();
            result = true;
        }
        catch (MySqlException ex) { }
        return result;
    }

    private void Close()
    {
        _connection.Close();
        _connection.Dispose();
    }

    public DataTable ExecuteQuery(MySqlCommand command)
    {
        DataTable table = new DataTable();
        if (Open())
        {
            command.Connection = _connection; //link command with conneciton
            MySqlDataAdapter adapter = new MySqlDataAdapter(command);
            try
            {
                adapter.Fill(table); //execute query
            }
            catch (MySqlException ex)
            {
            }
            finally
            {
                Close(); // close connection
            }
        }

        return table;
    }

    public DataTable ExecuteQuery(string query)
    {
        MySqlCommand command = new MySqlCommand(query);
        return ExecuteQuery(command);
    }

    public bool ExecuteNonQuery(MySqlCommand command)
    {
        bool executed = false;
        if (Open())
        {
            command.Connection = _connection;
            try
            {
                command.ExecuteNonQuery();
                executed = true;
            }
            catch (MySqlException ex)
            { }
            finally
            {
                Close();
            }
        }

        return executed;
    }

    public bool ExecuteNonQuery(string query)
    {
        MySqlCommand command = new MySqlCommand(query);
        return ExecuteNonQuery(command);
    }

    public DataRow GetFirstRow(DataTable table)
    {
        if (table.Rows.Count > 0)
            return table.Rows[0];
        else
            return null;
    }

    public DataRow GetFirstRow(MySqlCommand command)
    {
        DataTable table = ExecuteQuery(command);
        return GetFirstRow(table);
    }

    public DataRow GetFirstRow(string query)
    {
        DataTable table = ExecuteQuery(new MySqlCommand(query));
        return GetFirstRow(table);
    }

    #endregion

    #region constructors

    public Connection()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

        _connection = new MySqlConnection(connectionString);
    }

    #endregion
}