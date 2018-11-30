class Asteroid extends Floater {
    protected int rotationSpeed;

    public Asteroid() {
        rotationSpeed = (int)(Math.random()*11-5);
        corners = (int)(Math.random()*4+3);
        int[] xS = {-8, 12, -8, -2, 12, 0};
        int[] yS = {-8, 0, 8, 0, -5, 7};
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
}