public static final float ACCELERATION_AMOUNT = 0.20;
public static final float DECCELERATION_AMOUNT = 0.25;
public static final float ROUNDING_AMOUNT = 0.25;
public static final float CORRECTION_SPEED = 0.15;

Star[] s;

Spaceship Player = new Spaceship();
boolean wIsPressed, aIsPressed, dIsPressed, zIsPressed = false;
boolean canPress = true;

Asteroid[] r;

public void setup() {
    size(500, 500);
    Player.setmaxSpeed(16.0);
    Player.setColor(0,0,0);
    Player.setX(width/2);
    Player.setY(height/2);

    r = new Asteroid[(int)(Math.random()*10+15)];
    for(int i = 0; i < r.length; i++) {
        r[i] = new Asteroid();
        r[i].setX((int)(Math.random()*width));
        r[i].setY((int)(Math.random()*height));
        r[i].setDirectionX((Math.random()*10-5)/5);
        r[i].setDirectionY((Math.random()*10-5)/5);
    } 

    s = new Star[500];
    for(int i = 0; i < s.length; i++) {
        s[i] = new Star();
        s[i].setStroke((float)(Math.random()*2+1));
    } 
}

public void draw() {
    background(240);
    for(int i = 0; i < s.length; i++) {
        s[i].show();
    }
    for(int i = 0; i < r.length; i++) {
        r[i].show();
        r[i].move();
    } 
    Player.show();
    Player.move();
    movement();

    if (zIsPressed && canPress) {
        Player.setX((int)(Math.random()*width));
        Player.setY((int)(Math.random()*height));
        Player.turn((int)(Math.random()*361));
        canPress = false;
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
void keyPressed() {
    if ( key == 'w' || keyCode == UP ) { wIsPressed = true; } else 
    if ( key == 'a' || keyCode == LEFT ) { aIsPressed = true; } else
    if ( key == 'd' || keyCode == RIGHT ) { dIsPressed = true; } else
    if ( key == 'z' ) { 
        zIsPressed = true; 
    }
}

void keyReleased() {
    if ( key == 'w' || keyCode == UP ) { wIsPressed = false; } else 
    if ( key == 'a' || keyCode == LEFT ) { aIsPressed = false; } else
    if ( key == 'd' || keyCode == RIGHT ) { dIsPressed = false; } else
    if ( key == 'z' ) { 
        zIsPressed = false;  
        canPress = true;
    }
}
