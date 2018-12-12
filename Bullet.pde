class Bullet extends Floater {

    public Bullet(double xDir, double yDir, int centerX, int centerY) {
        corners = 6; //(int)(Math.random()*4+3);
        int[] xS = {1, 0, -1, -1, 0, 1};
        int[] yS = {3, 4, 3, -3, -4, -3}; 
        xCorners = xS;
        yCorners = yS;
        myDirectionX = xDir;
        myDirectionY = yDir;
        myCenterX = centerX;
        myCenterY = centerY;
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
