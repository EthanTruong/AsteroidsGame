class Spaceship extends Floater { 
    public Spaceship() {
        corners = 4;
        int[] xS = {-8, 16, -8, -2};
        int[] yS = {-8, 0, 8, 0};
        xCorners = xS;
        yCorners = yS;
    }
    public void accel() {
        if (keyPressed && key == 'w') {
            accelerate(0.15, 'x');
        } else if (myDirectionX > 0) {
            accelerate(-0.25, 'x');
        } 
        if (keyPressed && key == 'w') {
            accelerate(0.15, 'y');
        } else if (myDirectionX > 0) {
            accelerate(-0.25, 'y');
        } 
        if (myDirectionX < 0) {
            myDirectionX = 0;
        }
        if (myDirectionY < 0) {
          myDirectionY = 0;
        }
        if (keyPressed && key == 'd') {
            turn(5);
        } else if (keyPressed && key == 'a') {
            turn(-5);
        }
        System.out.println(myDirectionX);
        //System.out.println(myDirectionY);
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
}
