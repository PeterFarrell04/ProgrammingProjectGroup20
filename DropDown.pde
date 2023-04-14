///made by Peter Farrell 
 
///DropDown usage notes
//used to make dropdown widget which holds a seperate widget as its 'child'
//when making a DropDown instance:
//dropList.add(x,y,name,font,buffer*);
//*buffer should be the space on the yaxis that the child widget occupies, as buffer determines the height of the box when expanded
class DropDown
{
  float x, y;
  int textSize = 24;
  String title;
  PFont font;
  Boolean isOpen = false;
  int index;
  int buffer;
  int exBuffer = 0;
  int event = 0;
  float boxW,boxH,boxX,boxY;
  String lastOutput = "";
  String queryLink = "";
  SearchBar child;
  Checkbox filterChild;
  Query q;
   DropDown(float x, float y, String title, PFont font, int buffer, int event)
   {
     this.x = x;
     this.y = y;
     this.title = title;
     this.font = font;
     this.buffer = buffer;
     child = new SearchBar(round(x),round(y+buffer),200,40,font);
     filterChild = new Checkbox(round(x)-40,round(y)-24, 48,48,100);
     this.event = event;
     switch(event)
     {
       case 2:
       queryLink = "MKT_CARRIER_FL_NUM";
       break;
       case 3:
       queryLink = "ORIGIN";
       break;
       case 0:
       queryLink = "FL_DATE";
       break;
       case 8:
       queryLink = "DEST";
       break;
       case 13:
        queryLink = "CRS_DEP_TIME";
        break;
        case 15:
        queryLink =  "CRS_ARR_TIME";
        break;
       default:
       queryLink = "DEST";
       break;
     }
   }
   
   void update()
   {
     //fine search
     if (!lastOutput.equals(child.output))
     {
       if (event == 2 || event == 13 || event == 15)
       {
         int integerOutput;
         try
         {
           integerOutput = Integer.valueOf(child.output);
         }catch(NumberFormatException ex)
         {
          integerOutput = -1;
         }
         q = new Query(queryLink,integerOutput);
         dataList = q.run();
         println(child.output+" "+q.count);
         queryResultCount = q.count;
         lastOutput = child.output;
       }else
       {
         q = new Query(queryLink,child.output);
         dataList = q.run();
         println(child.output+" "+q.count);
         lastOutput = child.output;
       }
       
     }
       
     if (filterChild.link)
     {
       coarseAnswer = event;
     }
     filterChild.y = round(y)-24+exBuffer;
     filterChild.draw();
     
     this.index = dropList.indexOf(this);
     
     exBuffer = 0;
     for (int i = 0; i < index; i++)
     {
       if (dropList.get(i).isOpen)
       {
         exBuffer += dropList.get(i).buffer;
         
       }
     }
     
     boxW = 300;
     boxH = textSize*2;
     boxX = x-textSize/2;
     boxY = y-textSize+exBuffer;
     if (mouseOver())
     {
       stroke(255);
     }else
     {
       stroke(0);
     }
     if (isOpen)
     {
       fill (180);
       rect(boxX, boxY, boxW, boxH+buffer);
     }
     fill(100);
     rect(boxX,boxY,boxW,boxH);
     fill(255);
     textFont(font);
     text(title, x,y+exBuffer);
     
     if (!isOpen)
     {
       triangle(x+title.length()*textSize/2.2, y-(textSize/2) -4 + exBuffer, x+24+title.length()*textSize/2.2, y-(textSize/2) -4 + exBuffer, x+12+title.length()*textSize/2.2, y+4 + exBuffer);
     }else
     {
        triangle(x+title.length()*textSize/2.2, y+(textSize/2) -12 + exBuffer, x+24+title.length()*textSize/2.2, y+(textSize/2) -12 + exBuffer, x+12+title.length()*textSize/2.2, y-20 + exBuffer);
        //child.y += exBuffer;
         child.y = (int)y+exBuffer+(buffer);
        child.update();
     

        
     }
     stroke(0);
     

   }
   
  boolean mouseOver()
  {
    //checks if the mouse is in collision with the text box
    if (mouseX > boxX && mouseX < boxX+boxW)
    {
      if (mouseY > boxY && mouseY < boxY+boxH)
      {
        return true;
      }
    }
    return false;
  }
  
  void mouseIn()
  {
    filterChild.mouseIn();

    if (isOpen)
    {
      child.mouseIn();
    }
    //if the mouse is over, and pressed the box will be opened
    if (mouseOver())
    {
      isOpen ^= true;
    }
  }
  void keyIn()
  {
     child.keyIn();
  }
   
}
