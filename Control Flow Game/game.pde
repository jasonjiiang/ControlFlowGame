import java.util.Iterator;

enum gamePages
{
  START, SELECT, PLAYING, OVER, HELP, CREDIT
}
gamePages gamePage = gamePages.START;
int gameLevel;
int unlockedLevel = 1;
boolean started = false;
boolean win = false;

ArrayList<block> bList = new ArrayList<block>();
ArrayList<block> chosenBlocks = new ArrayList<block>();
ArrayList<statement> sList = new ArrayList<statement>();

int helpPage = 1;

void setup()
{
  size(750, 500);
  imageMode(CENTER);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
}

void draw()
{
  background(255);
  button back = new button(375, 400, 160, 60, "Back");
  
  if (gamePage == gamePages.START)
  {
    fill(0);
    textSize(40);
    text("Learn to Program through Games", 375, 100);
    textSize(20);
    text("- Control Flow Game", 375, 140);

    fill(51, 204, 51);
    button play = new button(375, 240, 160, 60, "Play");
    play.render();

    fill(204, 0, 0);
    button help = new button(375, 320, 160, 60, "Help");
    help.render();

    fill(0, 153, 255);
    button cred = new button(375, 400, 160, 60, "Credits");
    cred.render();
  } else if (gamePage == gamePages.SELECT)
  {
    fill(0);
    textSize(40);
    text("Select Level:", 187.5, 50);
    
    color unlocked = color(0, 153, 255);
    color locked = color(0, 78, 130);
    
    fill(unlocked);
    button level = new button(110, 120, 50, 50, "1");
    level.render();
    
    if (unlockedLevel >= 2) {fill(unlocked);} 
    else {fill(locked);}
    button level2 = new button(170, 120, 50, 50, "2");
    level2.render();

    if (unlockedLevel >= 3) {fill(unlocked);} 
    else {fill(locked);}
    button level3 = new button(230, 120, 50, 50, "3");
    level3.render();

    if (unlockedLevel >= 4) {fill(unlocked);} 
    else {fill(locked);}
    button level4 = new button(290, 120, 50, 50, "4");
    level4.render();

    if (unlockedLevel >= 5) {fill(unlocked);} 
    else {fill(locked);}
    button level5 = new button(350, 120, 50, 50, "5");
    level5.render();

    fill(0, 153, 255);
    back.render();
  } else if (gamePage == gamePages.PLAYING)
  {
    blockHitSides();
    platformHitbox();
    renderLevels();
    
    button back2 = new button(25, 25, 50, 50, "<");
    fill(0, 153, 255);
    back2.render();
    button start = new button(25, 75, 50, 50, ">");
    if (!started)
    {
      fill(0, 200, 0);
      start.render();
    }
    
    for (block blk: chosenBlocks)
    {
      blk.render();
    }
    
    statementCollision();
    clearStatements();
    blockHitTarget();
  } else if (gamePage == gamePages.OVER)
  {
    fill(0);
    textSize(40);
    text("Game Over", 375, 100);

    fill(204, 0, 0);
    button retry = new button(285, 240, 160, 60, "Retry");
    retry.render();
    
    if (win)
    {
      fill(0, 200, 0);
      textSize(14);
      text("Congratulations! You Won!", 375, 125);
      fill(51, 204, 51);
    } else
    {
      fill(200, 0, 0);
      textSize(14);
      text("Incorrect block detected! You Lost!", 375, 125);
      if (unlockedLevel >= gameLevel + 1 &&
      gameLevel < 5)
      {
        fill(51, 204, 51);
      } else
      {
        fill(23, 89, 23);
      }
    }
    button next = new button(465, 240, 160, 60, "Next");
    next.render();

    fill(0, 153, 255);
    button menu = new button(375, 320, 160, 60, "Menu");
    menu.render();
  } else if (gamePage == gamePages.HELP)
  {
    File assets = new File("./Assets");
    PImage img;
    img = loadImage(assets+"/helpPage"+Integer.toString(helpPage)+".png");
    image(img, 375,200);
    
    textSize(20);
    text(Integer.toString(helpPage)+"/13", 375, 350);
    button prev = new button(250, 400, 50, 50, "<");
    fill(0, 153, 255);
    prev.render();
    button next = new button(500, 400, 50, 50, ">");
    fill(0, 153, 255);
    next.render();
    fill(0, 153, 255);
    back.render();
  } else if (gamePage == gamePages.CREDIT)
  {
    text("Credits:", 375, 50);
    textSize(20);
    text("Jason Jiang", 375, 100);
    text("21360554@stu.mmu.ac.uk", 375, 150);
    fill(0, 153, 255);
    back.render();
  }
}

void mousePressed()
{
  //Detects which buttons are pressed
  if (gamePage == gamePages.START)
  {
    if (mouseX > 295 && mouseX < 295+160 && mouseY > 210 && mouseY < 210+60)
    {
      gamePage = gamePages.SELECT;
    } else if (mouseX > 295 && mouseX < 295+160 && mouseY > 290 && mouseY < 290+60)
    {
      gamePage = gamePages.HELP;
    } else if (mouseX > 295 && mouseX < 295+160 && mouseY > 370 && mouseY < 370+60)
    {
      gamePage = gamePages.CREDIT;
    }
  } else if (gamePage == gamePages.SELECT)
  {
    if (mouseX > 295 && mouseX < 295+160 && mouseY > 370 && mouseY < 370+60)
    {
      gamePage = gamePages.START;
    } else if (mouseX > 85 && mouseX < 85+50 && mouseY > 95 && mouseY < 95+50)
    {
      gameLevel = 1;
      gamePage = gamePages.PLAYING;
      newLevel();
    } else if (mouseX > 145 && mouseX < 145+50 && mouseY > 95 && mouseY < 95+50)
    {
      if (unlockedLevel >= 2)
      {
        gameLevel = 2;
        gamePage = gamePages.PLAYING;
        newLevel();
      }
    } else if (mouseX > 205 && mouseX < 205+50 && mouseY > 95 && mouseY < 95+50)
    {
      if (unlockedLevel >= 3)
      {
        gameLevel = 3;
        gamePage = gamePages.PLAYING;
        newLevel();
      }
    } else if (mouseX > 265 && mouseX < 265+50 && mouseY > 95 && mouseY < 95+50)
    {
      if (unlockedLevel >= 4)
      {
        gameLevel = 4;
        gamePage = gamePages.PLAYING;
        newLevel();
      }
    } else if (mouseX > 325 && mouseX < 325+50 && mouseY > 95 && mouseY < 95+50)
    {
      if (unlockedLevel >= 5)
      {
        gameLevel = 5;
        gamePage = gamePages.PLAYING;
        newLevel();
      }
    }
  } else if (gamePage == gamePages.PLAYING)
  {
    if (mouseX > 0 && mouseX < 50 && mouseY > 0 && mouseY < 50)
    {
      gameLevel = 0;
      gamePage = gamePages.SELECT;
      bList.clear();
      sList.clear();
      chosenBlocks.clear();
    } else if (!started && mouseX > 0 && mouseX < 50 && mouseY > 50 && mouseY < 100)
    {
      started = true;
    }
  } else if (gamePage == gamePages.OVER)
  {
    if (mouseX > 205 && mouseX < 205+160 && mouseY > 210 && mouseY < 210+60)
    {
      //retry button
      gamePage = gamePages.PLAYING;
      newLevel();
    } else if (mouseX > 385 && mouseX < 385+160 && mouseY > 210 && mouseY < 210+60)
    {
      //next button
      if (unlockedLevel >= gameLevel + 1 &&
      gameLevel < 5)
      {
        gameLevel++;
        gamePage = gamePages.PLAYING;
        newLevel();
      }
    } else if (mouseX > 295 && mouseX < 295+160 && mouseY > 290 && mouseY < 290+60)
    {
      gamePage = gamePages.START;
      bList.clear();
      sList.clear();
      chosenBlocks.clear();
    }
  } else if (gamePage == gamePages.HELP)
  {
    if (mouseX > 295 && mouseX < 295+160 && mouseY > 370 && mouseY < 370+60)
    {
      gamePage = gamePages.START;
    } else if (mouseX > 225 && mouseX < 225+50 && mouseY > 375 && mouseY < 375+50)
    {
      if (helpPage > 1)
      {
        helpPage--;
      }
    } else if (mouseX > 475 && mouseX < 475+50 && mouseY > 375 && mouseY < 375+50)
    {
      if (helpPage < 13)
      {
        helpPage++;
      }
    }
  } else if (gamePage == gamePages.CREDIT)
  {
    if (mouseX > 295 && mouseX < 295+160 && mouseY > 370 && mouseY < 370+60)
    {
      gamePage = gamePages.START;
    }
  }
  
  //editing the if statements
  if (gamePage == gamePages.PLAYING && !started)
  {
    for (statement stmt: sList)
    {
      if (mouseX > stmt.getX()-50 && mouseX < (stmt.getX()-50)+100 
      && mouseY > stmt.getY()-25 && mouseY < stmt.getY())
      {
        stmt.condition();
      }
      else if (mouseX > stmt.getX()-50 && mouseX < (stmt.getX()-50)+100 
      && mouseY > stmt.getY() && mouseY < (stmt.getY()-25)+50)
      {
        stmt.result();
      }
    }
  }
}

void mouseDragged()
{
  if (gamePage == gamePages.PLAYING)
  {
    for (block blk: bList)
    {
      if (mouseX > blk.getX()-(blk.getSize()/2) 
      && mouseX < (blk.getX()-(blk.getSize()/2))+blk.getSize()
      && mouseY > blk.getY()-(blk.getSize()/2) 
      && mouseY < (blk.getY()-(blk.getSize()/2))+blk.getSize())
      {
        blk.drag(mouseX, mouseY);
      }
    }
  }
  
  if (gamePage == gamePages.PLAYING && !started)
  {
    boolean drag = false;
    for (statement stmt: sList)
    {
      //check which statement is getting dragged
      if (mouseX > stmt.getX()-(stmt.getWidth()/2) 
      && mouseX < (stmt.getX()-(stmt.getWidth()/2))+stmt.getWidth()
      && mouseY > stmt.getY()-(stmt.getHeight()/2) 
      && mouseY < (stmt.getY()-(stmt.getHeight()/2))+stmt.getHeight())
      {
        //for loop over statements for collision when dragging
        for (statement stmt2: sList)
        {
          if (stmt != stmt2) //checks if same statement
          { //checks if statement is in the other statement when dragging if true then false
            if (!(mouseX + stmt.getWidth() > stmt2.getX()
            && mouseX < stmt2.getX() + stmt2.getWidth()
            && mouseY + stmt.getHeight() > stmt2.getY()
            && mouseY < stmt2.getY() + stmt2.getHeight()))
            {
              drag = true;
            } else
            {
              drag = false;
              break;
            }
          }
        }
        //after checking all the collisions for the other statements then drag
        if (drag || sList.size() == 1)
        {
          stmt.drag(mouseX, mouseY);
        }
      }
    }
    //statement spawners
    int arrayLen = sList.size();
    for (int i = 0; i< arrayLen; i++)
    {
      statement stmt = sList.get(i);
      if (mouseX > stmt.getX()-(stmt.getWidth()/2) 
      && mouseX < (stmt.getX()-(stmt.getWidth()/2))+stmt.getWidth()
      && mouseY > stmt.getY()-(stmt.getHeight()/2) 
      && mouseY < (stmt.getY()-(stmt.getHeight()/2))+stmt.getHeight())
      {
        if (stmt instanceof ifStatement && 
        !(mouseX + stmt.getWidth() > 200
        && mouseX < 200 + 100
        && mouseY + stmt.getHeight() > 25
        && mouseY < 25 + 50))
        {
          boolean spawned = false;
          int arrayLen2 = sList.size();
          for (int j = 0; j< arrayLen2; j++)
          {
            statement stmt2 = sList.get(j);
            if (!(stmt2.getX() + stmt2.getWidth() > 200
            && stmt2.getX() < 200 + 100
            && stmt2.getY() + stmt2.getHeight() > 25
            && stmt2.getY() < 25 + 50))
            {
              spawned = true;
            } else
            {
              spawned = false;
              break;
            }
          }
          if (spawned)
          {
            sList.add(new ifStatement(200, 25));
          }
        } else if (stmt instanceof whileStatement && 
        !(mouseX + stmt.getWidth() > 320
        && mouseX < 320 + 100
        && mouseY + stmt.getHeight() > 25
        && mouseY < 25 + 50))
        {
          boolean spawned = false;
          int arrayLen2 = sList.size();
          for (int j = 0; j< arrayLen2; j++)
          {
            statement stmt2 = sList.get(j);
            if (!(stmt2.getX() + stmt2.getWidth() > 320
            && stmt2.getX() < 320 + 100
            && stmt2.getY() + stmt2.getHeight() > 25
            && stmt2.getY() < 25 + 50)
            && !(stmt2.getX() + stmt2.getWidth() > 440
            && stmt2.getX() < 440 + 100
            && stmt2.getY() + stmt2.getHeight() > 25
            && stmt2.getY() < 25 + 50))
            {
              spawned = true;
            } else
            {
              spawned = false;
              break;
            }
          }
          if (spawned)
          {
            whileStatement loop = new whileStatement(320,25);
            endStatement end = new endStatement(440, 25, loop);
            loop.setEnd(end);
            sList.add(end);
            sList.add(loop);
          }
        } else if (stmt instanceof endStatement && 
        !(mouseX + stmt.getWidth() > 440
        && mouseX < 440 + 100
        && mouseY + stmt.getHeight() > 25
        && mouseY < 25 + 50))
        {
          boolean spawned = false;
          int arrayLen2 = sList.size();
          for (int j = 0; j< arrayLen2; j++)
          {
            statement stmt2 = sList.get(j);
            if (!(stmt2.getX() + stmt2.getWidth() > 440
            && stmt2.getX() < 440 + 100
            && stmt2.getY() + stmt2.getHeight() > 25
            && stmt2.getY() < 25 + 50)
            && !(stmt2.getX() + stmt2.getWidth() > 320
            && stmt2.getX() < 320 + 100
            && stmt2.getY() + stmt2.getHeight() > 25
            && stmt2.getY() < 25 + 50))
            {
              spawned = true;
            } else
            {
              spawned = false;
              break;
            }
          }
          if (spawned)
          {
            whileStatement loop = new whileStatement(320,25);
            endStatement end = new endStatement(440, 25, loop);
            loop.setEnd(end);
            sList.add(end);
            sList.add(loop);
          }
        }
      }
    }
  }
}

void renderLevels()
{
  if (gameLevel == 1)
  {
    //platform
    fill(0);
    rect(375, 475, 750, 50);
    //target
    fill(255, 255, 0);
    rect(725, 250, 50, 500);
    //green pipe
    fill(0, 200, 0);
    rect(25, 425, 50, 50);
    rect(45, 425, 15, 60);
  } else if (gameLevel == 2)
  {
    //platform
    fill(0);
    rect(300, 150, 600, 50);
    rect(450, 350, 600, 50);
    //target
    fill(255, 255, 0);
    rect(375, 475, 750, 50);
    //green pipe
    fill(0, 200, 0);
    rect(25, 100, 50, 50);
    rect(45, 100, 15, 60);
  } else if (gameLevel == 3)
  {
    //platform
    fill(0);
    rect(650, 125, 200, 50);
    rect(100, 125, 200, 50);
    rect(375, 250, 500, 50);
    rect(650, 375, 200, 50);
    rect(100, 375, 200, 50);
    //target
    fill(255, 255, 0);
    rect(375, 475, 750, 50);
    //green pipe
    fill(0, 200, 0);
    rect(100, 25, 50, 50);
    rect(100, 45, 60, 15);
  } else if (gameLevel == 4)
  {
    //platform
    fill(0);
    rect(250, 150, 500, 50);
    rect(675, 150, 150, 50);
    rect(375, 350, 250, 50);
    rect(75, 350, 150, 50);
    rect(475, 425, 50, 150);
    //target
    fill(255, 255, 0);
    rect(225, 475, 450, 50);
    //green pipe
    fill(0, 200, 0);
    rect(25, 100, 50, 50);
    rect(45, 100, 15, 60);
  } else if (gameLevel == 5)
  {
    //platform
    fill(0);
    rect(525, 150, 450, 50);
    rect(100, 150, 200, 50);
    rect(550, 275, 200, 50);
    rect(225, 275, 250, 50);
    rect(325, 400, 50, 200);
    rect(550, 450, 200, 150);
    rect(100, 450, 200, 150);
    //target
    fill(255, 255, 0);
    rect(250, 475, 100, 50);
    rect(400, 475, 100, 50);
    rect(700, 475, 100, 50);
    //green pipe
    fill(0, 200, 0);
    rect(25, 100, 50, 50);
    rect(45, 100, 15, 60);
  }
}

void platformHitbox()
{
  if (started)
  {
    if (gameLevel == 1)
    {
      for (block blk : bList) //hitbox for the platforms
      {
        if (blk.getX() <= 775 &&
          blk.getY() <= 475 &&
          blk.getY() + 50 >= 475) //platform floor hitbox
        {
          blk.move();
        } else {
          blk.fall();
        }
      }
    } else if (gameLevel == 2)
    {
      for (block blk : bList)
      {
        if (blk.getX() <= 625 &&
          blk.getY() <= 150 &&
          blk.getY() + 50 >= 150 ||
          blk.getX() >= 125 &&
          blk.getY() <= 350 &&
          blk.getY() + 50 >= 350)
        {
          blk.move();
        } else {
          blk.fall();
        }
      }
    } else if (gameLevel == 3)
    {
      for (block blk : bList)
      {
        if (blk.getX() <= 225 &&
          blk.getY() <= 125 &&
          blk.getY() + 50 >= 125 ||
          blk.getX() >= 525 &&
          blk.getY() <= 125 &&
          blk.getY() + 50 >= 125 ||
          blk.getX() >= 100 &&
          blk.getX() <= 650 &&
          blk.getY() <= 250 &&
          blk.getY() + 50 >= 250 ||
          blk.getX() <= 225 &&
          blk.getY() <= 375 &&
          blk.getY() + 50 >= 375 ||
          blk.getX() >= 525 &&
          blk.getY() <= 375 &&
          blk.getY() + 50 >= 375)
        {
          blk.move();
        } else {
          blk.fall();
        }
      }
    } else if (gameLevel == 4)
    {
      for (block blk : bList)
      {
        if (blk.getX() <= 525 &&
          blk.getY() <= 150 &&
          blk.getY() + 50 >= 150 ||
          blk.getX() >= 575 &&
          blk.getY() <= 150 &&
          blk.getY() + 50 >= 150 ||
          blk.getX() <= 175 &&
          blk.getY() <= 350 &&
          blk.getY() + 50 >= 350 ||
          blk.getX() >= 225 &&
          blk.getX() <= 525 &&
          blk.getY() <= 350 &&
          blk.getY() + 50 >= 350 ||
          blk.getY() >= 475)
        {
          blk.move();
        } else
        {
          if (blk.getY() <= 475)
          {
            blk.fall();
          }
        }
        if (blk.getX() <= 525 &&
          blk.getX() + 50 >= 525 &&
          blk.getY() >= 325) //platform wall hitbox
        {
          blk.stop();
        }
      }
    } else if (gameLevel == 5)
    {
      for (block blk : bList)
      {
        if (blk.getX() <= 225 &&
          blk.getY() <= 150 &&
          blk.getY() + 50 >= 150 ||
          blk.getX() >= 275 &&
          blk.getY() <= 150 &&
          blk.getY() + 50 >= 150 ||
          blk.getX() >= 75 &&
          blk.getX() <= 375 &&
          blk.getY() <= 275 &&
          blk.getY() + 50 >= 275 ||
          blk.getX() >= 425 &&
          blk.getX() <= 675 &&
          blk.getY() <= 275 &&
          blk.getY() + 50 >= 275 ||
          blk.getX() <= 225 &&
          blk.getY() <= 400 &&
          blk.getY() + 50 >= 400 ||
          blk.getX() >= 425 &&
          blk.getX() <= 675 &&
          blk.getY() <= 400 &&
          blk.getY() + 50 >= 400)
        {
          blk.move();
        } else {
          blk.fall();
        }
        if (blk.getX() <= 375 &&
          blk.getX() + 50 >= 375 &&
          blk.getY() >= 300 ||
          blk.getX() + 50 >= 325 &&
          blk.getX() <= 325 &&
          blk.getY() >= 300) //platform wall hitbox
        {
          blk.stop();
        }
      }
    }
  }
}

int randomShape()
{
  int shape = round(random(1, 4));
  while (shape == 2)
  {
    shape = round(random(1, 4));
  }
  return shape;
}

String randomColour()
{
  int num = round(random(1,3));
  if (num == 1)
  {
    return "red";
  } else if (num == 2)
  {
    return "green";
  } else
  {
    return "blue";
  }
}

void spawnBlocks()
{
  for (int i = 1; i <= random(8, 12); i++)
  {
    int x = 0, y = 0;
    int shape = randomShape();
    String colour = randomColour();
    //x and y
    if (gameLevel == 1)
    {
      x = i*-round(random(100, 200));
      y = 425;
    } else if (gameLevel == 2)
    {
      x = i*-round(random(100, 200));
      y = 100;
    } else if (gameLevel == 4 || gameLevel == 5)
    {
      x = i*-round(random(100, 200));
      y = 100;
    } else if (gameLevel == 3)
    {
      x = 100;
      y = i*-round(random(100, 200));
    }
    
    if (bList.size() != 0)
    { //remove duplicates
      boolean duplicate = false;
      for (block blk: bList)
      {
        if (shape == blk.getSides() &&
        colour == blk.getColour())
        {
          duplicate = true;
          break;
        }
        duplicate = false;
      }
      if (!duplicate)
      {
        bList.add(new block(x, y, shape, colour));
      }
    } else
    {
      bList.add(new block(x, y, shape, colour));
    }
  }
}

void pickBlocks()
{
  ArrayList<block> clonedBlocks = (ArrayList<block>)bList.clone();
  for (int i = 0; i < 3; i++)
  {
    while (true)
    {
      try
      {
        block rand = clonedBlocks.get((int)random(0,10));
        block clone = new block(rand, 725, 25);
        clone.setSize(25);
        if (gameLevel == 1)
        {
          if (i > 0) break;
        } else if (gameLevel == 2)
        {
          clone.setX(25);
          clone.setY(475);
          if (i > 0) break;
        } else if (gameLevel == 3 || gameLevel == 4)
        {
          clone.setX(25 + (50 * i));
          clone.setY(475);
          if (i > 1) break;
        } else if (gameLevel == 5)
        {
          if (i == 0)
          {
            clone.setX(250);
          } else if (i == 1)
          {
            clone.setX(400);
          } else if (i == 2)
          {
            clone.setX(700);
          }
          clone.setY(475);
        }
        chosenBlocks.add(clone);
        clonedBlocks.remove(rand);
        break;
      }
      catch(Exception e)
      {
        println("Block already chosen");
      }
    }
  }
}

void spawnStatements()
{
  if (gameLevel >= 1)
  {
    sList.add(new ifStatement(200, 25));
  } 
  if (gameLevel >= 3)
  {
    whileStatement loop = new whileStatement(320,25);
    endStatement end = new endStatement(440, 25, loop);
    loop.setEnd(end);
    sList.add(end);
    sList.add(loop);
  }
}

void newLevel()
{
  started = false;
  win = false;
  bList.clear();
  sList.clear();
  chosenBlocks.clear();
  spawnBlocks();
  pickBlocks();
  spawnStatements();
}

void blockHitSides()
{
  for (block blk : bList)
  {
    blk.render();
    if (blk.getChanged() &&
      blk.getX() < 25 ||
      blk.getX() > 725)
    {
      blk.stop();
    }
  }
}

void statementCollision()
{
  for (statement stmt: sList)
  {
    for (block blk : bList)
    {
      if (blk.getX() <= 75 + stmt.getX() &&
        blk.getX() + 75 >= stmt.getX() && 
        blk.getY() <= 50 + stmt.getY() &&
        blk.getY() + 50 >= stmt.getY())
      {
        if (stmt.getCond() == blk.getColour() || 
        stmt.getCond() == "1 side" && blk.getSides() == 1 ||
        stmt.getCond() == "3 sides" && blk.getSides() == 3 ||
        stmt.getCond() == "4 sides" && blk.getSides() == 4)
        {
          if (stmt.getRes() == "change")
          {
            blk.changeDir();
            if (blk.getSpeed() < 0)
            {
              blk.setX(stmt.getX()-stmt.getWidth());
              blk.setY(stmt.getY());
            } else if (blk.getSpeed() > 0)
            {
              blk.setX(stmt.getX()+stmt.getWidth());
              blk.setY(stmt.getY());
            }
          } else if (stmt.getRes() == "break")
          {
            if (blk.isLooping())
            {
              blk.setLoop(false);
              blk.setX(blk.getLoop().getEnd().getX());
              blk.setY(blk.getLoop().getEnd().getY());
            }
          }
        } else if (stmt.getRes() == "pass")
        {
          blk.stop();
          if (blk.getY() <= stmt.getY() - 40)
          { //blocks move on top of statement
            blk.stopFall();
            blk.move(); //neutralises the stop()
            blk.move(); //actually moves
          }
        } else if (stmt.getCond() == "looping")
        {
          blk.setLoop(true, stmt);
        } else if (stmt.getCond() == "startAgain")
        {
          if (blk.isLooping())
          {
            blk.setX(stmt.getLoop().getX());
            blk.setY(stmt.getLoop().getY());
          }
        }
      }
    }
  }
}

void blockHitTarget()
{
  boolean wrong = false;
  Iterator<block> iter = bList.iterator(); //iterator to remove while iterating
  while (iter.hasNext())
  {
    block blk = iter.next();
    Iterator<block> iter2 = chosenBlocks.iterator();
    while (iter2.hasNext())
    {
      block blk2 = iter2.next();
      if (gameLevel == 1 && blk.getX() >= 675 ||
      gameLevel == 2 && blk.getY() >= 425 ||
      gameLevel == 3 && blk.getY() >= 425 ||
      gameLevel == 4 && blk.getY() >= 425 && blk.getX() < 475)
      {
        if (blk.getSides() == blk2.getSides() &&
        blk.getColour() == blk2.getColour())
        {
          iter.remove();
          iter2.remove();
          wrong = false;
          break; //when chosen block has reached the bottom, break loop
        }
        wrong = true; //wrong block reached the bottom
      } else if (gameLevel == 5 && blk.getY() >= 425)
      {
        if (blk.getX() >= 200 && blk.getX() <= 300)
        {
          if (blk.getSides() == chosenBlocks.get(0).getSides() &&
          blk.getColour() == chosenBlocks.get(0).getColour())
          {
            if (blk2 == chosenBlocks.get(0))
            {
              iter.remove();
              iter2.remove();
              wrong = false;
              break;
            } 
          }
          wrong = true;
        } else if (blk.getX() >= 350 && blk.getX() <= 450)
        {
          int index = chosenBlocks.size()-2;
          if (chosenBlocks.size() == 1)
          {
            index = 0;
          }
          if (blk.getSides() == chosenBlocks.get(index).getSides() &&
          blk.getColour() == chosenBlocks.get(index).getColour())
          {
            if (blk2 == chosenBlocks.get(index))
            {
              iter.remove();
              iter2.remove();
              wrong = false;
              break;
            } 
          }
          wrong = true;
        } else if (blk.getX() >= 650 && blk.getX() <= 750)
        {
          int index = chosenBlocks.size()-1;
          if (blk.getSides() == chosenBlocks.get(index).getSides() &&
          blk.getColour() == chosenBlocks.get(index).getColour())
          {
            if (blk2 == chosenBlocks.get(index))
            {
              iter.remove();
              iter2.remove();
              wrong = false;
              break;
            } 
          }
          wrong = true;
        }
      }
    }
  }
  
  if (wrong)
  {
    gamePage = gamePages.OVER;
  }
  
  if (chosenBlocks.size() == 0)
  {
    if (unlockedLevel < 5 &&
    unlockedLevel == gameLevel) 
    {
      unlockedLevel = gameLevel + 1;
    }
    gamePage = gamePages.OVER;
    win = true;
  }
}

void clearStatements()
{
  Iterator<statement> iter = sList.iterator();
  while (iter.hasNext())
  {
    statement stmt = iter.next();
    if (started) //remove any unused or null statements
    {
      if (stmt.getY() == 25 && stmt.getX() == 200
      || stmt.getY() == 25 && stmt.getX() == 320
      || stmt.getY() == 25 && stmt.getX() == 440)
      {
        iter.remove();
      } else if (stmt.getCond() == null || stmt.getRes() == null)
      {
        if (stmt instanceof ifStatement)
        {
          iter.remove();
        }
      }
    }
    stmt.render();
  }
  
  //remove any lone while or end statements
  Iterator<statement> iter2 = sList.iterator();
  while (iter2.hasNext())
  {
    statement stmt2 = iter2.next();
    if (started)
    {
      if (stmt2 instanceof whileStatement)
      {
        if (stmt2.getEnd().getX() == 440)
        {
          iter2.remove();
        }
      } else if (stmt2 instanceof endStatement)
      {
        if (stmt2.getLoop().getX() == 320)
        {
          iter2.remove();
        }
      }
    }
  }
}
