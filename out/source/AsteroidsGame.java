import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class AsteroidsGame extends PApplet {

Spaceship Player = new Spaceship();
boolean wIsPressed, aIsPressed, dIsPressed = false;

public void setup() {
    
    Player.setTopSpeed(15.0f);
}

public void draw() {
    background(255);
    Player.show();
    Player.move();
    accelerate();
}

public void accelerate() {
    // DEBUG
    System.out.println("angle (radians): " + Player.getPointDirection()*(Math.PI/180)); // angle (radians)
    System.out.println("max x: " + Player.getTopSpeedX() + ",  max y: " + Player.getTopSpeedX()); // converted top speeds
    System.out.println("speed x: " + Player.getDirectionX() + ",  speed y: " + Player.getDirectionY()); // actual speeds
    
    
    // angles cannot go over 2PI radians
    if (Player.myPointDirection*(Math.PI/180) > Math.PI*2) {
        Player.setPointDirection(0);
    }
    if (Player.myPointDirection*(Math.PI/180) < -Math.PI*2) {
        Player.setPointDirection(0);
    }
    
    if (aIsPressed) { Player.turn(-5); }
    if (dIsPressed) { Player.turn(5); }
    
    if (wIsPressed) {
        if (((Player.getPointDirection()*(Math.PI/180)) < Math.PI/2 && (Player.getPointDirection()*(Math.PI/180)) > -Math.PI/2) || 
            ((Player.getPointDirection()*(Math.PI/180)) < 2*Math.PI && (Player.getPointDirection()*(Math.PI/180)) > (3*Math.PI)/2)) {
            if (Player.getDirectionX() < Player.getTopSpeedX()) {
                Player.accelerate(0.15f, "x");
            }
        }
        if (((Player.getPointDirection()*(Math.PI/180)) < 3*Math.PI/2 && (Player.getPointDirection()*(Math.PI/180)) > Math.PI/2) || 
            ((Player.getPointDirection()*(Math.PI/180)) < -Math.PI/2 && (Player.getPointDirection()*(Math.PI/180)) > -Math.PI)) {
            if (Player.getDirectionX() > -Player.getTopSpeedX()) {
                Player.accelerate(0.15f, "x");
            }
        }
        if (((Player.getPointDirection()*(Math.PI/180)) > Math.PI && (Player.getPointDirection()*(Math.PI/180)) < 2*Math.PI) ||
            ((Player.getPointDirection()*(Math.PI/180)) > -Math.PI && (Player.getPointDirection()*(Math.PI/180)) < 0)) {
            if (Player.getDirectionY() > -Player.getTopSpeedY()) {
                Player.accelerate(0.15f, "y");
            }
        }
        if (((Player.getPointDirection()*(Math.PI/180)) > 0 && (Player.getPointDirection()*(Math.PI/180)) < Math.PI) ||
            ((Player.getPointDirection()*(Math.PI/180)) > -2*Math.PI && (Player.getPointDirection()*(Math.PI/180)) < -Math.PI)) {
            if (Player.getDirectionY() < Player.getTopSpeedY()) {
                Player.accelerate(0.15f, "y");
            }
        }
    } else if (!wIsPressed) {
        if (Player.getDirectionX() > 0) {
            Player.accelerate(-0.25f, "x");
        } else if (Player.getDirectionX() < 0) {
            Player.accelerate(-0.25f , "x2");
        }
        if (Player.getDirectionY() > 0) {
            Player.accelerate(-0.25f , "y");
        } else if (Player.getDirectionY() < 0) {
            Player.accelerate(0.25f , "y2");
        }
        if (Player.getDirectionY() > -0.2f && Player.getDirectionY() < 0.2f) {
            Player.setDirectionY(0);
        }
        if (Player.getDirectionX() > -0.2f && Player.getDirectionX() < 0.2f) {
            Player.setDirectionX(0);
        }
    }
}

public void keyPressed() {
    if ( key == 'w' ) { wIsPressed = true; } else 
    if ( key == 'a' ) { aIsPressed = true; } else
    if ( key == 'd' ) { dIsPressed = true; }
}

public void keyReleased() {
    if ( key == 'w' ) { wIsPressed = false; } else 
    if ( key == 'a' ) { aIsPressed = false; } else
    if ( key == 'd' ) { dIsPressed = false; }
}
abstract class Floater //Do NOT modify the Floater class! Make changes in the Spaceship class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount, String direction)
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians = myPointDirection*(Math.PI/180);
    //change coordinates of direction of travel
        if (direction == "x") {
            myDirectionX += ((dAmount) * Math.cos(dRadians));
        }
        if (direction == "y") {
            myDirectionY += ((dAmount) * Math.sin(dRadians)); 
        }  
        if (direction == "x2") {
            myDirectionX += ((dAmount) * Math.cos(-dRadians)); 
        }     
        if (direction == "y2") {
            myDirectionY += ((dAmount) * Math.sin(-dRadians)); 
        }     
  }   
  public void turn (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    } 
    
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    
    //translate the (x,y) center of the ship to the correct position
    translate((float)myCenterX, (float)myCenterY);

    //convert degrees to radians for rotate()     
    float dRadians = (float)(myPointDirection*(Math.PI/180));
    
    //rotate so that the polygon will be drawn in the correct direction
    rotate(dRadians);
    
    //draw the polygon
    beginShape();
    for (int nI = 0; nI < corners; nI++)
    {
      vertex(xCorners[nI], yCorners[nI]);
    }
    endShape(CLOSE);

    //"unrotate" and "untranslate" in reverse order
    rotate(-1*dRadians);
    translate(-1*(float)myCenterX, -1*(float)myCenterY);
  }   
} 
class Spaceship extends Floater { 
    protected double myTopSpeed;

    public Spaceship() {
        myTopSpeed = 10.0f;
        corners = 4;
        int[] xS = {-8, 16, -8, -2};
        int[] yS = {-8, 0, 8, 0};
        xCorners = xS;
        yCorners = yS;
    }
    
    public void setX(int x) {myCenterX = x;}  
    public int getX() {return (int)myCenterX;}   
    public void setY(int y) {myCenterY = y;}   
    public int getY() {return (int)myCenterY;}   
    public void setDirectionX(double x) {myDirectionX = x;}   
    public double getDirectionX() {return myDirectionX;}
    public void setDirectionY(double y) {myDirectionY = y;}
    public double getDirectionY() {return myDirectionY;}
    public void setPointDirection(int degrees) {myPointDirection = degrees;}   
    public double getPointDirection() {return myPointDirection;}
    public void setTopSpeed(double topSpeed) {myTopSpeed = topSpeed;}
    public double getTopSpeedX() {return abs((float)(myTopSpeed * Math.cos(myPointDirection*(Math.PI/180))));}
    public double getTopSpeedY() {return abs((float)(myTopSpeed * Math.sin(myPointDirection*(Math.PI/180))));}
}
class Star //note that this class does NOT extend Floater
{
  //your code here
}
  public void settings() {  size(500, 500); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "AsteroidsGame" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
