class block {
  int x, y;
  int sides;
  int size = 50;
  String colour;
  int dir = 5;
  boolean changed = false;
  boolean looping = false;
  statement loop;
  
  block(int x, int y, int sides, String colour)
  {
    this.x = x;
    this.y = y;
    this.sides = sides;
    this.colour = colour;
  }
  
  block(block blk, int x, int y)
  {
    this.setX(x);
    this.setY(y);
    this.setColour(blk.getColour());
    this.setSides(blk.getSides());
  }
  
  void render()
  {
    if (this.colour == "red")
    {
      fill(200,0,0);
    }
    else if (this.colour == "green")
    {
      fill(0,200,0);
    }
    else if (this.colour == "blue")
    {
      fill(0,0,200);
    }
    
    if (this.sides == 1)
    {
      circle(this.x,this.y,size);
    }
    else if (this.sides == 3)
    {
      triangle(this.x-(size/2), this.y+(size/2), this.x+(size/2), this.y+(size/2), this.x, this.y-(size/2));
    }
    else if (this.sides == 4)
    {
      square(this.x,this.y,size);
    }
  }
  
  void move()
  {
    this.x+=this.dir;
  }
  
  void fall()
  {
    this.y+=5;
  }
  
  void stop()
  {
    this.x-=this.dir;
  }
  
  void stopFall()
  {
    this.y-=5;
  }
  
  void changeDir()
  {
    this.dir *= -1;
    this.changed = true;
  }
  
  int getX()
  {
    return this.x;
  }
  
  int getY()
  {
    return this.y;
  }
  
  int getSize()
  {
    return this.size;
  }
  
  int getSides()
  {
    return this.sides;
  }
  
  String getColour()
  {
    return this.colour;
  }
  
  void setX(int input)
  {
    this.x = input;
  }
  
  void setY(int input)
  {
    this.y = input;
  }
  
  void setSize(int input)
  {
    this.size = input;
  }
  
  void setSides(int input)
  {
    this.sides = input;
  }
  
  void setColour(String input)
  {
    this.colour = input;
  }
  
  boolean getChanged()
  {
    return this.changed;
  }
  
  int getSpeed()
  {
    return this.dir;
  }
  
  boolean isLooping()
  {
    return this.looping;
  }
  
  statement getLoop()
  {
    return this.loop;
  }
  
  void setLoop(boolean input, statement loop)
  {
    this.looping = input;
    this.loop = loop;
  }
  
  void setLoop(boolean input)
  {
    this.looping = input;
  }
  void drag(int x, int y)
  {
    this.x = x;
    this.y = y;
  }
}
