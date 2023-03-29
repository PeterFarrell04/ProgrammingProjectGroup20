///made by Peter Farrell 
///searchbar usage notes

//when creating a searchbar:
//SearchBar(x,y,width,height,font);
//use function returnAnswer to get the users input for the given searchbar.
//recommended to use default width: 200, height: 40 and a size 24 font.
//create an arraylist for multiple searchbars if needed.


class SearchBar
{
  String input = "";
  String endInput = "|";
  String output = "";
  int timer = 0;
  Boolean isOpen;
  int x;
  int y;
  PFont font;
  int textSize = 24;
  int buffer = 5;
  int boxW = 200;
  int boxH = 40;
  
  SearchBar(int xpos, int ypos,int w, int h, PFont Font)
  {
    //init object
    isOpen = false;
    x = xpos;
    y = ypos;
    font = Font;
    boxW = w;
    boxH = h;
  }
  
  void update()
  {
    //draw back of textbox
    if (mouseOver() || isOpen)
    {
       stroke(255); 
    }else
    {
      stroke(0); 
    }
    fill(80);
    rect(x,y-textSize,boxW,boxH);
    fill(255);
    stroke(0); 
    
    textFont(font);
    
    
     // draw blinking "|" for user every 20 frames
     timer++;
     if (timer % 20 == 0)
     {
       if (endInput.equalsIgnoreCase(""))
       {
         endInput = "|";
       }else
       {
         endInput = "";
       }
     }
     
     
     //draw the text in the box
     if (!isOpen)
     {
       //draw text when not in use
       text("search...",x+buffer,y);
     }else
     {
       //draw text when in use
       text(input + endInput,x+buffer,y);
     }
     
     
     
  }
  
  void keyIn()
  {
    if (isOpen)
    {
      //checks if backspace is pressed and truncates string -1 from last character
      if (key == 8)
      {
        if (input.length() > 0)
        {
          input = input.substring(0,input.length()-1);
        }
      }else if (key == 10)
      {
        //if enter is pressed, we set the input as our output
        output = input;
      }else
      {
        if (key >= 32 && key <= 122)
        {
        //if any other normal character is pressed, we add it to our input
        input+=key;
        }
      }
    }
  }
  
  String returnAnswer()
  {
    //used to return answer so it can be used in different queries for searches
    return output;
  }
  
  boolean mouseOver()
  {
    //checks if the mouse is in collision with the text box
    if (mouseX > x && mouseX < x+boxW)
    {
      if (mouseY > y-textSize && mouseY < y-textSize+boxH)
      {
        return true;
      }
    }
    return false;
  }
  

  
  void mouseIn()
  {
    //if the mouse is over, and pressed the box will be opened
    //otherwise, the box will close
    if (mouseOver())
    {
      isOpen = true;
    }else
    {
      isOpen = false;
      //input = "";
    }
  }
  
}
