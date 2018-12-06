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
