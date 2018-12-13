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

public static final float ACCELERATION_AMOUNT = 0.20f;
public static final float DECCELERATION_AMOUNT = 0.25f;
public static final float ROUNDING_AMOUNT = 0.25f;
public static final float CORRECTION_SPEED = 0.15f;

ArrayList <Asteroid> r = new ArrayList <Asteroid> ();
ArrayList <Bullet> b = new ArrayList <Bullet> ();
Star[] s;

Spaceship Player = new Spaceship();
boolean wIsPressed, aIsPressed, dIsPressed, zIsPressed, spaceIsPressed = false;
boolean canPressZ = true;
boolean canPressSpace = true;
int canShoot = 0;

public void setup() {
    
    Player.setmaxSpeed(16.0f);
    Player.setColor(0,0,0);
    Player.setX(width/2);
    Player.setY(height/2);

    for(int i = 0; i < (int)(Math.random()*20+25); i++) {
        r.add(new Asteroid());
    }  

    s = new Star[500];
    for(int i = 0; i < s.length; i++) {
        s[i] = new Star();
        s[i].setStroke((float)(Math.random()*2+1));
    }
}

public void draw() {
    background(240);

    if(spaceIsPressed) {
        if(canShoot == 3) {
            b.add(new Bullet(10*(Math.cos(Player.getPointDirection()*(Math.PI/180))), 10*(Math.sin(Player.getPointDirection()*(Math.PI/180))), Player.getX(), Player.getY(), (int)Player.getPointDirection()));
            canShoot = 0;
        } else {
            canShoot++;
        }
    }

    for(int i = 0; i < s.length; i++) {
        s[i].show();
    }

    if (zIsPressed && canPressZ) {
        Player.setX((int)(Math.random()*width));
        Player.setY((int)(Math.random()*height));
        Player.turn((int)(Math.random()*361));
        canPressZ = false;
    }

    for(int i = 0; i < b.size(); i++) {
        b.get(i).show();
        b.get(i).move();
    }

    Player.show();
    Player.move();
    movement();

    for(Asteroid entry : r) {
        entry.show();
        entry.move();
        entry.turn(entry.getRotationSpeed());
    }

    for(int i = 0; i < r.size(); i++) {
        if (dist(Player.getX(), Player.getY(), r.get(i).getX(), r.get(i).getY()) < 12) {
            r.remove(i);
        } else {
            for(int j = 0; j < b.size(); j++) {
                if (dist(b.get(j).getX(), b.get(j).getY(), r.get(i).getX(), r.get(i).getY()) < 12) { 
                    r.remove(i); 
                }
            }
        }  
    }

    for(int i = 0; i < b.size(); i++) {
        if(b.get(i).getY() > height) {    
            b.remove(i);   
        } else if (b.get(i).getY() < 0){     
            b.remove(i);     
        } else if(b.get(i).getX() > width) {     
            b.remove(i); 
        } else if (b.get(i).getX() <0) {     
            b.remove(i);  
        }
    }
}

// player movement
public void movement() {
    double playerAngle = Player.getPointDirection()*(Math.PI/180);
    
     /* debug stuff
    for(int i = 0; i < 6; i++) {System.out.println("");}
    System.out.println("angle (radians): " + playerAngle); // angle (radians)
    System.out.println("max x: " + Player.getMaxSpeedX() + ",  max y: " + Player.getMaxSpeedY()); // converted top speeds
    System.out.println("speed x: " + Player.getDirectionX() + ",  speed y: " + Player.getDirectionY()); // actual speeds
     */
    
    // angles cannot go over 2PI radians
    if (playerAngle > Math.PI*2) {
        Player.setPointDirection(0);
    }
    if (playerAngle < -Math.PI*2) {
        Player.setPointDirection(0);
    }
    
    // turn conditionals
    if (aIsPressed) { Player.turn(-5); }
    if (dIsPressed) { Player.turn(5); }
    
    // accelerate and deccelerate conditionals
    if (wIsPressed) { 
        // based on angle, accelerate in the correct direction
        if (playerAngle < Math.PI/2 && playerAngle > -Math.PI/2 || 
        playerAngle < 2*Math.PI && playerAngle > 3*Math.PI/2 ||
        playerAngle < -3*Math.PI/2 && playerAngle > -2*Math.PI) {
            if (Player.getDirectionX() < Player.getMaxSpeedX()) {
                Player.accelerate(ACCELERATION_AMOUNT, "x");
            }
        }
        if (playerAngle < 3*Math.PI/2 && playerAngle > Math.PI/2 || 
        playerAngle < -Math.PI/2 && playerAngle > -3*Math.PI/2) {
            if (Player.getDirectionX() > -Player.getMaxSpeedX()) {
                Player.accelerate(ACCELERATION_AMOUNT, "x");
            }
        }
        if (playerAngle > Math.PI && playerAngle < 2*Math.PI ||
        playerAngle > -Math.PI && playerAngle < 0) {
            if (Player.getDirectionY() > -Player.getMaxSpeedY()) {
                Player.accelerate(ACCELERATION_AMOUNT, "y");
            }
        }
        if (playerAngle > 0 && playerAngle < Math.PI ||
        playerAngle > -2*Math.PI && playerAngle < -Math.PI) {
            if (Player.getDirectionY() < Player.getMaxSpeedY()) {
                Player.accelerate(ACCELERATION_AMOUNT, "y");
            }
        }
        // check for overspeed + rounding
        if(abs((float)Player.getDirectionX()) > Player.getMaxSpeedX()) { // correct directionX to maxSpeed
            if (Player.getDirectionX() > 0) {
                Player.setDirectionX(Player.getDirectionX() - CORRECTION_SPEED);
            } else if (Player.getDirectionX() < 0) {
                Player.setDirectionX(Player.getDirectionX() + CORRECTION_SPEED);
            }
            // round directionX to max speed
            if(abs((float)Player.getDirectionX()) > Player.getMaxSpeedX()-ROUNDING_AMOUNT && 
            abs((float)Player.getDirectionX()) < Player.getMaxSpeedX()+ROUNDING_AMOUNT) {
                if (Player.getDirectionX() > 0) {
                    Player.setDirectionX(Player.getMaxSpeedX());
                } else if (Player.getDirectionX() < 0) {
                    Player.setDirectionX(-Player.getMaxSpeedX());
                }
            }
        }
        if(abs((float)Player.getDirectionY()) > Player.getMaxSpeedY()) { // correct directionY to maxSpeed
            if (Player.getDirectionY() > 0) {
                Player.setDirectionY(Player.getDirectionY() - CORRECTION_SPEED);
            } else if (Player.getDirectionY() < 0) {
                Player.setDirectionY(Player.getDirectionY() + CORRECTION_SPEED);
            }
            // round directionY to max speed
            if(abs((float)Player.getDirectionY()) > Player.getMaxSpeedY()-ROUNDING_AMOUNT && 
            abs((float)Player.getDirectionY()) < Player.getMaxSpeedY()+ROUNDING_AMOUNT) {
                if (Player.getDirectionY() > 0) {
                    Player.setDirectionY(Player.getMaxSpeedY());
                } else if (Player.getDirectionX() < 0) {
                    Player.setDirectionY(-Player.getMaxSpeedY());
                }
            }
        }
    } else if (!wIsPressed) {
        Player.decelerate(DECCELERATION_AMOUNT); // deccelerate player
        // round speed to 0
        if (Player.getDirectionX() > -ROUNDING_AMOUNT && Player.getDirectionX() < ROUNDING_AMOUNT) {
            Player.setDirectionX(0);
        }
        if (Player.getDirectionY() > -ROUNDING_AMOUNT && Player.getDirectionY() < ROUNDING_AMOUNT) {
            Player.setDirectionY(0);
        }
    }
}

// keypressed and released stuff
public void keyPressed() {
    if ( key == 'w' || keyCode == UP ) { wIsPressed = true; } else 
    if ( key == 'a' || keyCode == LEFT ) { aIsPressed = true; } else
    if ( key == 'd' || keyCode == RIGHT ) { dIsPressed = true; } else
    if ( key == 'z' ) { zIsPressed = true; } else 
    if ( keyCode == 32 ) { spaceIsPressed = true; }
}

public void keyReleased() {
    if ( key == 'w' || keyCode == UP ) { wIsPressed = false; } else 
    if ( key == 'a' || keyCode == LEFT ) { aIsPressed = false; } else
    if ( key == 'd' || keyCode == RIGHT ) { dIsPressed = false; } else
    if ( key == 'z' ) { 
        zIsPressed = false;  
        canPressZ = true;
    } else if (keyCode == 32) {
        spaceIsPressed = false;
    }
}
class Asteroid extends Floater {
    protected int rotationSpeed;
    protected int warpOvervalue;

    public Asteroid() {
        warpOvervalue = 20;
        rotationSpeed = (int)(Math.random()*4-3);
        corners = 6; //(int)(Math.random()*4+3);
        int[] xS = {(int)myCenterX-(int)(Math.random()*10+5), (int)myCenterX-(int)(Math.random()*13+5), (int)myCenterX-(int)(Math.random()*10+5), 
                (int)myCenterX+(int)(Math.random()*10+5), (int)myCenterX+(int)(Math.random()*13+5), (int)myCenterX+(int)(Math.random()*10+5)};
        int[] yS = {(int)myCenterY-(int)(Math.random()*12+5), (int)myCenterY, (int)myCenterY+(int)(Math.random()*12+5),
                (int)myCenterY+(int)(Math.random()*12+5), (int)myCenterY, (int)myCenterY-(int)(Math.random()*12+5)}; 
        xCorners = xS;
        yCorners = yS;
        myCenterX = (int)(Math.random()*width);
        myCenterY = (int)(Math.random()*height);
        myDirectionX = (Math.random()*10-5)/5;
        myDirectionY = (Math.random()*10-5)/5;
    }
    
    public void move () { //move the floater in the current direction of travel
        //change the x and y coordinates by myDirectionX and myDirectionY       
        myCenterX += myDirectionX;    
        myCenterY += myDirectionY;     

        //wrap around screen    
        if(myCenterX > width + warpOvervalue) {     
            myCenterX = 0 - warpOvervalue;    
        } else if (myCenterX < 0 - warpOvervalue) {     
            myCenterX = width + warpOvervalue;    
        }    
        
        if(myCenterY > height + warpOvervalue) {    
          myCenterY = 0 - warpOvervalue;    
        } else if (myCenterY < 0 - warpOvervalue){     
          myCenterY = height + warpOvervalue;    
        }   
    }   

    public void setColor(int r, int g, int b) {myColor = color(r, g, b);}  
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
    public int getRotationSpeed() {return rotationSpeed;}
}
class Bullet extends Floater {

    public Bullet(double xDir, double yDir, int centerX, int centerY, int angle) {
        corners = 6; //(int)(Math.random()*4+3);
        int[] xS = {3, 4, 3, -3, -4, -3};
        int[] yS = {1, 0, -1, -1, 0, 1}; 
        xCorners = xS;
        yCorners = yS;
        myDirectionX = xDir;
        myDirectionY = yDir;
        myCenterX = centerX;
        myCenterY = centerY;
        myColor = 0xfff44242;
        myPointDirection = angle;
    }

    public void move () { //move the floater in the current direction of travel
        //change the x and y coordinates by myDirectionX and myDirectionY       
        myCenterX += myDirectionX;    
        myCenterY += myDirectionY;     

    }

    public void setColor(int r, int g, int b) {myColor = color(r, g, b);}  
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
}
abstract class Floater { //Do NOT modify the Floater class! Make changes in the Spaceship class 
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
    public void accelerate (double dAmount) {          
        //convert the current direction the floater is pointing to radians    
        double dRadians = myPointDirection*(Math.PI/180);
        //change coordinates of direction of travel
            myDirectionX += ((dAmount) * Math.cos(dRadians));
            myDirectionY += ((dAmount) * Math.sin(dRadians)); 
    } 

    public void turn (int nDegreesOfRotation)   {     
        //rotates the floater by a given number of degrees    
        myPointDirection+=nDegreesOfRotation;
    } 

    public void move () { //move the floater in the current direction of travel
        //change the x and y coordinates by myDirectionX and myDirectionY       
        myCenterX += myDirectionX;    
        myCenterY += myDirectionY;     

        //wrap around screen    
        if(myCenterX >width) {     
            myCenterX = 0;    
        } else if (myCenterX<0) {     
            myCenterX = width;    
        }    
        
        if(myCenterY >height) {    
          myCenterY = 0;    
        } else if (myCenterY < 0){     
          myCenterY = height;    
        }   
    }   
      
    public void show () {  //Draws the floater at the current position            
        fill(myColor);   
        stroke(myColor);    
        strokeWeight(0);
        
        //translate the (x,y) center of the ship to the correct position
        translate((float)myCenterX, (float)myCenterY);

        //convert degrees to radians for rotate()     
        float dRadians = (float)(myPointDirection*(Math.PI/180));
        
        //rotate so that the polygon will be drawn in the correct direction
        rotate(dRadians);
        
        //draw the polygon
        beginShape();
        for (int nI = 0; nI < corners; nI++) {
            vertex(xCorners[nI], yCorners[nI]);
        }
        endShape(CLOSE);

        //"unrotate" and "untranslate" in reverse order
        rotate(-1*dRadians);
        translate(-1*(float)myCenterX, -1*(float)myCenterY);
    }   
} 
class Spaceship extends Floater { 
    protected double myMaxSpeed;

    public Spaceship() {
        myMaxSpeed = 10.0f;
        corners = 4;
        int[] xS = {-8, 12, -8, -2};
        int[] yS = {-8, 0, 8, 0};
        xCorners = xS;
        yCorners = yS;
    }

    public void accelerate (double dAmount, String direction) {          
        //convert the current direction the floater is pointing to radians    
        double dRadians = myPointDirection*(Math.PI/180);
        //change coordinates of direction of travel
        if (direction == "x") {
            myDirectionX += ((dAmount) * Math.cos(dRadians));
        }
        if (direction == "y") {
            myDirectionY += ((dAmount) * Math.sin(dRadians)); 
        }   
    } 

    //Deccelerates the floater from xDirection and yDirection
    public void decelerate (double dAmount) {          
        //convert the current direction the floater is pointing to radians    
        double dRadians = myPointDirection*(Math.PI/180);

        // convert movement into angle
        double getAngleX = Math.acos(abs((float)(myDirectionX / Math.sqrt(Math.pow((float)myDirectionY,2) + Math.pow((float)myDirectionX,2)))));
        double getAngleY = Math.asin(abs((float)(myDirectionY / Math.sqrt(Math.pow((float)myDirectionY,2) + Math.pow((float)myDirectionX,2)))));

        //change coordinates of direction of travel
        if (myDirectionX < 0) {
            myDirectionX += dAmount * Math.cos(getAngleX);
        } 
        if (myDirectionX > 0) {
            myDirectionX -= dAmount * Math.cos(getAngleX);
        }
        if (myDirectionY < 0) {
            myDirectionY += dAmount * Math.sin(getAngleY);
        }
        if (myDirectionY > 0) {
            myDirectionY -= dAmount * Math.sin(getAngleY);
        }
    }  
    
    public void setColor(int r, int g, int b) {myColor = color(r, g, b);}  
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
    public void setmaxSpeed(double maxSpeed) {myMaxSpeed = maxSpeed;}
    public double getMaxSpeedX() {return abs((float)(myMaxSpeed * Math.cos(myPointDirection*(Math.PI/180))));}
    public double getMaxSpeedY() {return abs((float)(myMaxSpeed * Math.sin(myPointDirection*(Math.PI/180))));}
}
class Star { //note that this class does NOT extend Floater
    private float starX, starY, stroke;

    public Star() {
        starX = (int)(Math.random()*width+1);
        starY = (int)(Math.random()*height+1);
        stroke = 1;
    }

    public void show() {
        fill(0,0,0,10);
        stroke(0,0,0);
        strokeWeight(stroke);
        point(starX, starY);
    }

    public void setStroke(float size) {
        stroke = size;
    }
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
