class ifStatement extends statement {
  int conditionClick = 0;
  int resultClick = 0;
  
  ifStatement(int x, int y)
  {
    super(x, y);
  }
  
  void render()
  {
    fill(255);
    rect(x,y-(h/4),w,h/2);
    rect(x,y+(h/4),w,h/2);
    fill(0);
    textSize(14);
    text("if "+this.cond,x,y-(h/4));
    text("then "+this.then,x,y+(h/4));
  }
  
  void condition()
  {
    conditionClick++;
    if (conditionClick == 7)
    {
      conditionClick = 1;
    }
    
    if (conditionClick == 1)
    {
      this.cond = "red";
    }
    else if (conditionClick == 2)
    {
      this.cond = "green";
    }
    else if (conditionClick == 3)
    {
      this.cond = "blue";
    }
    else if (conditionClick == 4)
    {
      this.cond = "1 side";
    }
    else if (conditionClick == 5)
    {
      this.cond = "3 sides";
    }
    else if (conditionClick == 6)
    {
      this.cond = "4 sides";
    }
  }
  
  void result()
  {
    resultClick++;
    if (resultClick == 4)
    {
      resultClick = 1;
    }
    if (resultClick == 1)
    {
      this.then = "change";
    } else if (resultClick == 2)
    {
      this.then = "pass";
    } else if (resultClick == 3)
    {
      this.then = "break";
    }
  }
}
