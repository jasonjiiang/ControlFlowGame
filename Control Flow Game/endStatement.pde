class endStatement extends statement {
  endStatement(int x, int y, whileStatement loop)
  {
    super(x, y);
    condition();
    this.loop = loop;
  }
  
  void render()
  {
    fill(255);
    rect(x,y,w,h);
    fill(0);
    textSize(14);
    text("end",x,y);
  }
  
  void condition()
  {
    this.cond = "startAgain";
  }
  
  void result()
  {
    this.then = "none";
  }
}
