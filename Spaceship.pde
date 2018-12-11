class Spaceship extends Floater { 
    protected double myMaxSpeed;

    public Spaceship() {
        myMaxSpeed = 10.0;
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
