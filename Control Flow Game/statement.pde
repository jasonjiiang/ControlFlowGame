abstract class statement {
  int x, y;
  int w, h;
  String cond;
  String then;
  whileStatement loop;
  endStatement end;
  
  statement(int x, int y)
  {
    this.w = 100;
    this.h = 50;
    this.x = x;
    this.y = y;
  }
  
  abstract void render();
  abstract void condition();
  abstract void result();
  
  void drag(int x, int y)
  {
    this.x = x;
    this.y = y;
  }
  
  int getX()
  {
    return this.x;
  }
  
  int getY()
  {
    return this.y;
  }
  
  int getWidth()
  {
    return this.w;
  }
  
  int getHeight()
  {
    return this.h;
  }
  
  String getCond()
  {
    return this.cond; 
  }
  
  String getRes()
  {
    return this.then; 
  }
  
  void setEnd(endStatement end)
  {
    this.end = end;
  }
  
  endStatement getEnd()
  {
    return this.end;
  }
  
  whileStatement getLoop()
  {
    return this.loop;
  }
}
