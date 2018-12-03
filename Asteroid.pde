class Asteroid extends Floater {
    protected int rotationSpeed;

    public Asteroid() {
        rotationSpeed = (int)(Math.random()*11-5);
        corners = (int)(Math.random()*4+3);
        int[] xS = {(int)myCenterX-(int)(Math.random()*10+5), (int)myCenterX-(int)(Math.random()*13+5), (int)myCenterX-(int)(Math.random()*10+5), 
                (int)myCenterX+(int)(Math.random()*10+5), (int)myCenterX+(int)(Math.random()*13+5), (int)myCenterX+(int)(Math.random()*10+5)};
        int[] yS = {(int)myCenterY-(int)(Math.random()*12+5), (int)myCenterY, (int)myCenterY+(int)(Math.random()*12+5),
                (int)myCenterY+(int)(Math.random()*12+5), (int)myCenterY, (int)myCenterY-(int)(Math.random()*12+5)}; 
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