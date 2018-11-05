class Spaceship extends Floater { 
    protected double myTopSpeed;

    public Spaceship() {
        myTopSpeed = 10.0;
        corners = 4;
        int[] xS = {-8, 16, -8, -2};
        int[] yS = {-8, 0, 8, 0};
        xCorners = xS;
        yCorners = yS;
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
    public void setTopSpeed(double topSpeed) {myTopSpeed = topSpeed;}
    public double getTopSpeedX() {return abs((float)(myTopSpeed * Math.cos(myPointDirection*(Math.PI/180))));}
    public double getTopSpeedY() {return abs((float)(myTopSpeed * Math.sin(myPointDirection*(Math.PI/180))));}
}
