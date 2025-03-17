class button {
  float posX, posY, sizeX, sizeY;
  String text;
  
  button(float posX, float posY, float sizeX, float sizeY, String text)
  {
    this.posX = posX;
    this.posY = posY;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.text = text;
  }
  
  void render()
  {
    rect(posX, posY, sizeX, sizeY);
    fill(0);
    textSize(40);
    text(text, posX, posY); //7.5
  }
}
