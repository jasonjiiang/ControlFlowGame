class whileStatement extends statement {
  whileStatement(int x, int y)
  {
    super(x, y);
    condition();
  }
  
  void render()
  {
    fill(255);
    rect(x,y,w,h);
    fill(0);
    textSize(14);
    text("while true",x,y);
  }
  
  void condition()
  {
    cond = "looping";
  }
  
  void result()
  {
    this.then = "none";
  }
}
