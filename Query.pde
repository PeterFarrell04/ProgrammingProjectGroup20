/* query class can currently run queries for
   -1 String
   -1 int
   -2 String
   -2 int
   -1 String and 1 int
   
   For 1 String query, create a Query object with parameters 
   -String dataName i.e. column header
   -String searchVal i.e. data entry you are looking for
   
   run query using run() method
   
   returns ArrayList of Data objects that fit the criteria
   Query also has int count that counts how many Data objects fit the criteria
*/

class Query
{
  
  String paramName1 = "";
  String paramName2 = "";
  
  String strValToCheck1 = "";
  String strValToCheck2 = "";
  int intValToCheck1 = -1;
  int intValToCheck2 = -1;
  
  int queryType;
  
  ArrayList<Data> dataList; //list of all flights
  
  ArrayList<Data> result; //list of flights that meet query criteria
  int count; //count of flights that meet query criteria
  
  //constructor for 1 String queries
  public Query (String str1, String searchVal1)
  {
    paramName1 = str1;
    strValToCheck1 = searchVal1;
    queryType = 1;
    count = 0;
  }
  
  //constructor for 1 int queries
  public Query (String str1, int searchVal1)
  {
    paramName1 = str1;
    intValToCheck1 = searchVal1;
    queryType = 2;
    count = 0;
  }
  
  //constructor for 2 String queries
  public Query (String str1, String searchVal1, String str2, String searchVal2)
  {
    paramName1 = str1;
    paramName2 = str2;
    strValToCheck1 = searchVal1;
    strValToCheck2 = searchVal2;
    queryType = 3;
    count = 0;
  }
  
  //constructor for 2 int queries
  public Query (String str1, int searchVal1, String str2, int searchVal2)
  {
    paramName1 = str1;
    paramName2 = str2;
    intValToCheck1 = searchVal1;
    intValToCheck2 = searchVal2;
    queryType = 4;
    count = 0;
  }
  
  //constructor for 1 String 1 int queries
  public Query (String str1, String searchVal1, String str2, int searchVal2)
  {
    paramName1 = str1;
    paramName2 = str2;
    strValToCheck1 = searchVal1;
    intValToCheck2 = searchVal2;
    queryType = 5;
    count = 0;
  }
  
  //initialization block to get list of all flights
  {
    dataList = new ArrayList<Data>();
    for (int i = 1; i < lines.length; i++) 
    {
      dataList.add(new Data(10, 10, lines[i], font));
    }
  }
  
  //method to run queries based on type
  public ArrayList<Data> run()
  {
    result = new ArrayList<Data>();
    
    switch (queryType)
    {
      case 1:

        for (int i = 0; i < dataList.size(); i++)
        {
          if (dataList.get(i).getStrVal(paramName1).equals(strValToCheck1))
          {
            result.add(dataList.get(i));
            count++;
          }
        }
        break;
        
      case 2:
        
        for (int i = 0; i < dataList.size(); i++)
        {
          if (dataList.get(i).getIntVal(paramName1) == intValToCheck1)
          {
            result.add(dataList.get(i));
            count++;
          }
        }
        break;
        
      case 3:
        
        for (int i = 0; i < dataList.size(); i++)
        {
          if (dataList.get(i).getStrVal(paramName1).equals(strValToCheck1))
          {
            if (dataList.get(i).getStrVal(paramName2).equals(strValToCheck2))
            {
              result.add(dataList.get(i));
              count++;
            }
          }
        }
        break;
        
      case 4:
      
        for (int i = 0; i < dataList.size(); i++)
        {
          if (dataList.get(i).getIntVal(paramName1) == intValToCheck1)
          {
            if (dataList.get(i).getIntVal(paramName2) == intValToCheck2)
            {
              result.add(dataList.get(i));
              count++;
            }
          }
        }
        break;
        
      case 5:
      
        for (int i = 0; i < dataList.size(); i++)
        {
          if (dataList.get(i).getStrVal(paramName1).equals(strValToCheck1))
          {
            if (dataList.get(i).getIntVal(paramName2) == intValToCheck2)
            {
              result.add(dataList.get(i));
              count++;
            }
          }
        }
        break;
    }
    
    return result;
  } 
}
