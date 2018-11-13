Spaceship Player = new Spaceship();
boolean wIsPressed, aIsPressed, dIsPressed = false;

public void setup() {
    size(500, 500);
    Player.setmaxSpeed(15.0);
    Player.setColor(235,235,235);
}

public void draw() {
    background(10);
    Player.show();
    Player.move();
    accelerate();
}

public void accelerate() {
    double playerAngle = Player.getPointDirection()*(Math.PI/180);
    // debug stuff
    for(int i = 0; i < 6; i++) {System.out.println("");}
    System.out.println("angle (radians): " + playerAngle); // angle (radians)
    System.out.println("max x: " + Player.getMaxSpeedX() + ",  max y: " + Player.getMaxSpeedY()); // converted top speeds
    System.out.println("speed x: " + Player.getDirectionX() + ",  speed y: " + Player.getDirectionY()); // actual speeds
    
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
                Player.accelerate(0.15, "x");
            }
        }
        if (playerAngle < 3*Math.PI/2 && playerAngle > Math.PI/2 || 
            playerAngle < -Math.PI/2 && playerAngle > -3*Math.PI/2) {
            if (Player.getDirectionX() > -Player.getMaxSpeedX()) {
                Player.accelerate(0.15, "x");
            }
        }
        if (playerAngle > Math.PI && playerAngle < 2*Math.PI ||
            playerAngle > -Math.PI && playerAngle < 0) {
            if (Player.getDirectionY() > -Player.getMaxSpeedY()) {
                Player.accelerate(0.15, "y");
            }
        }
        if (playerAngle > 0 && playerAngle < Math.PI ||
            playerAngle > -2*Math.PI && playerAngle < -Math.PI) {
            if (Player.getDirectionY() < Player.getMaxSpeedY()) {
                Player.accelerate(0.15, "y");
            }
        }
        // check for overspeed + rounding
        if(abs((float)Player.getDirectionX()) > Player.getMaxSpeedX()) {
            if (Player.getDirectionX() > 0) {
                Player.setDirectionX(Player.getDirectionX() - 0.1);
            } else if (Player.getDirectionX() < 0) {
                Player.setDirectionX(Player.getDirectionX() + 0.1);
            }
            if(abs((float)Player.getDirectionX()) > Player.getMaxSpeedX()-0.15 && abs((float)Player.getDirectionX()) < Player.getMaxSpeedX()+0.25) {
                if (Player.getDirectionX() > 0) {
                    Player.setDirectionX(Player.getMaxSpeedX());
                } else if (Player.getDirectionX() < 0) {
                    Player.setDirectionX(-Player.getMaxSpeedX());
                }
            }
        }
        if(abs((float)Player.getDirectionY()) > Player.getMaxSpeedY()) {
            if (Player.getDirectionY() > 0) {
                Player.setDirectionY(Player.getDirectionY() - 0.1);
            } else if (Player.getDirectionY() < 0) {
                Player.setDirectionY(Player.getDirectionY() + 0.1);
            }
            if(abs((float)Player.getDirectionY()) > Player.getMaxSpeedY()-0.15 && abs((float)Player.getDirectionY()) < Player.getMaxSpeedY()+0.25) {
                if (Player.getDirectionY() > 0) {
                    Player.setDirectionY(Player.getMaxSpeedY());
                } else if (Player.getDirectionX() < 0) {
                    Player.setDirectionY(-Player.getMaxSpeedY());
                }
            }
        }
    } else if (!wIsPressed) {
        Player.decelerate(0.25); // deccelerate player
        // round speed to 0
        if (Player.getDirectionX() > -0.25 && Player.getDirectionX() < 0.25) {
            Player.setDirectionX(0);
        }
        if (Player.getDirectionY() > -0.25 && Player.getDirectionY() < 0.25) {
            Player.setDirectionY(0);
        }
    }
}

// keypressed and released stuff
void keyPressed() {
    if ( key == 'w' || keyCode == UP ) { wIsPressed = true; } else 
    if ( key == 'a' || keyCode == LEFT ) { aIsPressed = true; } else
    if ( key == 'd' || keyCode == RIGHT ) { dIsPressed = true; }
}

void keyReleased() {
    if ( key == 'w' || keyCode == UP ) { wIsPressed = false; } else 
    if ( key == 'a' || keyCode == LEFT ) { aIsPressed = false; } else
    if ( key == 'd' || keyCode == RIGHT ) { dIsPressed = false; }
}
