import java.util.HashSet;
import java.util.Arrays;

//Made by Travis Yusuf
//This class parses and generates the data needed for the heatmap

class HeatmapData {

  String[] lines = loadStrings("flights2k(1).csv"); //Loads a line of csv data into each position in a string array (parsed in the functions)




  //Gives a unique list of values in a given column (we can use this string array for things like labelling)
  String[] getUniqueValues(int colIndex) {
    //Create a HashSet to store unique values for the given column
    HashSet<String> uniqueValues = new HashSet<String>();
    //loop through each line in the CSV file and add the value at the given column index to the HashSet
    for (String line : lines) {
      String[] values = line.split(",(?=(?:[^\"]*\"[^\"]*\")*[^\"]*$)", -2); //split the line into an array of values
      uniqueValues.add(values[colIndex].trim()); // add the value at the given column index to the HashSet
    }
    //Convert the HashSet to a string array and return it
    return uniqueValues.toArray(new String[uniqueValues.size()]);
  }




  //Given a unique list of string values we can count how many times it shows up in a given column from the csv file (e.g how many times JFK shows up in column 3)
  int[] countValuesInCSV(String[] values, int colIndex) {
    //Create a HashMap to store the count of each value in the CSV file
    HashMap<String, Integer> valueCounts = new HashMap<String, Integer>();
    //loop through each line in the CSV file
    for (String line : lines) {
      String[] lineValues = line.split(",(?=(?:[^\"]*\"[^\"]*\")*[^\"]*$)", -1); //split the line into an array of values
      //loop through each value in the given array
      for (String value : values) {
        //if the value at the given index in the CSV file matches the value in the given array, increment the count for that value
        if (lineValues[colIndex].trim().equals(value)) {
          Integer count = valueCounts.get(value);
          if (count == null) {
            count = 0;
          }
          count++;
          valueCounts.put(value, count);
        }
      }
    }

    //Convert the HashMap to an int array and return it
    int[] counts = new int[values.length];
    for (int i = 0; i < values.length; i++) {
      Integer count = valueCounts.get(values[i]);
      if (count == null) {
        count = 0;
      }
      counts[i] = count;
    }
    return counts;
  }





  //sortArrays method takes two arrays as parameters, stringValues and frequency.
  public void sortArrays(String[] stringValues, int[] frequency) {
    int n = frequency.length; //n is initialized with the length of the frequency array.
    for (int i = 0; i < n-1; i++) {       //The outer loop runs from 0 to n-1. This is because the last element in the array will be in its correct position after n-1 iterations.
      for (int j = 0; j < n-i-1; j++) {   //The inner loop runs from 0 to n-i-1. This is because the largest element after each iteration will be in its correct position.
        if (frequency[j] < frequency[j+1]) { //If frequency[j] is less than frequency[j+1], swap the elements in both arrays. This sorts the frequency array in descending order.

          // swap the values in the frequency array
          int temp = frequency[j];
          frequency[j] = frequency[j+1];
          frequency[j+1] = temp;

          // swap the corresponding values in the originWACs array
          String tempWAC = stringValues[j];
          stringValues[j] = stringValues[j+1];
          stringValues[j+1] = tempWAC;
        }
      }
    }
  }

  public int[][] create2dArray(String[] stringValues, int monthAmount, int colIndex) {
    String[] MONTHS_CONST = {"01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"};
    String[] months = new String[monthAmount];

    for (int i = 0; i <= monthAmount -1; i++) {
      months[i] = MONTHS_CONST[i];
    }
    //printArray(months);

    // Initialize a 2D array to store the results
    int[][] numFlights = new int[stringValues.length][months.length];

    // Loop through each line of the CSV data
    for (int i = 1; i < lines.length; i++) {
      // Split the CSV line into individual values
      String[] values = lines[i].split(",(?=(?:[^\"]*\"[^\"]*\")*[^\"]*$)", -1);

      // Get the valueSTR(string value at given index) and month of the flight
      String valueSTR = values[colIndex];
      String month = values[0].substring(3, 5);

      // Find the index of the origin and month in the arrays
      int originIndex = -1;
      int monthIndex = -1;
      for (int j = 0; j < stringValues.length; j++) {
        if (stringValues[j].equals(valueSTR)) {
          originIndex = j;
        }
      }
      for (int j = 0; j < months.length; j++) {
        if (months[j].equals(month)) {
          monthIndex = j;
        }
      }

      // If the origin and month are valid, increment the corresponding counter in the 2D array
      if (originIndex != -1 && monthIndex != -1) {
        numFlights[originIndex][monthIndex]++;
      }
    }
    return numFlights; //Returns the newly created 2d array to be used in Heatmap generation
  }

  public String[] resize1DArray(String[] originalArray, int newSize, int startIndex, int endIndex) {
    if (startIndex < 0 || startIndex >= originalArray.length) {
      throw new IllegalArgumentException("startIndex is out of bounds");
    }
    if (endIndex < startIndex || endIndex >= originalArray.length) {
      throw new IllegalArgumentException("endIndex is out of bounds");
    }
    String[] resizedArray = new String[newSize];
    int originalSize = endIndex - startIndex + 1;
    int copyLength = Math.min(newSize, originalSize);
    System.arraycopy(originalArray, startIndex, resizedArray, 0, copyLength);
    return resizedArray;
  }

  //Resizes data to fit heatmap onto screen
  int[][] resize2DArray(int[][] originalArray, int startRow, int endRow, int startColumn, int endColumn) {
    int numRows = endRow - startRow;
    int numColumns = endColumn - startColumn;
    int[][] newArray = new int[numRows][numColumns]; // create new array with specified size

    for (int i = 0; i < numRows; i++) {
      for (int j = 0; j < numColumns; j++) {
        if ((i + startRow) < originalArray.length && (j + startColumn) < originalArray[0].length) {
          newArray[i][j] = originalArray[i + startRow][j + startColumn]; // copy over value
        } else {
          newArray[i][j] = 0; // fill with default value if new array size is bigger than original
        }
      }
    }

    return newArray;
  }


  String[] textParser(String[] strings, boolean keepLastTwo) {
    StringBuilder sb = new StringBuilder();
    for (String s : strings) {
      String sanitized = s.replaceAll("\"", ""); // Remove quotation marks
      if (keepLastTwo && sanitized.length() > 1) {
        sb.append(sanitized.substring(sanitized.length() - 2));
      } else {
        sb.append(sanitized);
      }
      sb.append("|"); // Use pipe character as delimiter
    }
    String result = sb.toString().trim();
    return result.split("\\|"); // Escape the pipe character in the regex pattern
  }

  int buttonWidth = 150; // width of each button
  int buttonHeight = 50; // height of each button
  int buttonSpacing = 20; // spacing between buttons
  int dataColumn = 0; // initial value of dataColumn

  void drawButtons() {
    textAlign(CENTER, CENTER); // center the text in the buttons

    // draw the buttons
    fill(200); // set the color of the buttons
    rect(0, 0, buttonWidth, buttonHeight); // draw the first button
    rect(buttonWidth + buttonSpacing, 0, buttonWidth, buttonHeight); // draw the second button
    rect((buttonWidth + buttonSpacing) * 2, 0, buttonWidth, buttonHeight); // draw the third button
    rect((buttonWidth + buttonSpacing) * 3, 0, buttonWidth, buttonHeight); // draw the fourth button



    //Values that work:  2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 17
    // 2=MKT_CARRIER_FL_NUM, 3=ORIGIN, 4=ORIGIN_CITY_NAME, 5=ORIGIN_STATE_ABR, 6=ORIGIN_WAC, 7=DEST, 8=DEST_CITY_NAME, 9=DEST_STATE_ABR, 10=DEST_WAC,
    //11=CRS_DEP_TIME, 14=ARR_TIME, 17=DISTANCE


    // draw the button labels
    fill(0); // set the color of the text
    textSize(14); // set the size of the text
    text("Carrier Flight Num", buttonWidth/2, buttonHeight/2); // label the first button
    text("Origin", buttonWidth + buttonSpacing + buttonWidth/2, buttonHeight/2); // label the second button
    text("Origin City", (buttonWidth + buttonSpacing) * 2 + buttonWidth/2, buttonHeight/2); // label the third button
    text("Origin State", (buttonWidth + buttonSpacing) * 3 + buttonWidth/2, buttonHeight/2); // label the fourth button

    // check if the mouse is over each button and highlight it if it is
    if (mouseX >= 0 && mouseX <= buttonWidth && mouseY >= 0 && mouseY <= buttonHeight) {
      fill(255, 0, 0, 50); // highlight the first button
    } else if (mouseX >= buttonWidth + buttonSpacing && mouseX <= buttonWidth * 2 + buttonSpacing && mouseY >= 0 && mouseY <= buttonHeight) {
      fill(255, 0, 0, 50); // highlight the second button
    } else if (mouseX >= (buttonWidth + buttonSpacing) * 2 && mouseX <= buttonWidth * 3 + buttonSpacing * 2 && mouseY >= 0 && mouseY <= buttonHeight) {
      fill(255, 0, 0, 50); // highlight the third button
    } else if (mouseX >= (buttonWidth + buttonSpacing) * 3 && mouseX <= buttonWidth * 4 + buttonSpacing * 3 && mouseY >= 0 && mouseY <= buttonHeight) {
      fill(255, 0, 0, 50); // highlight the fourth button
    }
  }

  void mouseClicked() {
    // check if the mouse is over each button and change dataColumn if the button is clicked
    if (mouseX >= 0 && mouseX <= buttonWidth && mouseY >= 0 && mouseY <= buttonHeight) {
      dataColumn = 2; // set dataColumn to 2 if the first button was clicked
    } else if (mouseX >= buttonWidth + buttonSpacing && mouseX <= buttonWidth * 2 + buttonSpacing && mouseY >= 0 && mouseY <= buttonHeight) {
      dataColumn = 3; // set dataColumn to 3 if the second button was clicked
    } else if (mouseX >= (buttonWidth + buttonSpacing) * 2 && mouseX <= buttonWidth * 3 + buttonSpacing * 2 && mouseY >= 0 && mouseY <= buttonHeight) {
      dataColumn = 4; // set dataColumn to 4 if the third button was clicked
    } else if (mouseX >= (buttonWidth + buttonSpacing) * 3 && mouseX <= buttonWidth * 4 + buttonSpacing * 3 && mouseY >= 0 && mouseY <= buttonHeight) {
      dataColumn = 5; // set dataColumn to 5 if the fourth button was clicked
    }
  }
}
