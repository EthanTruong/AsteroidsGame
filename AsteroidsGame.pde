Spaceship Player = new Spaceship();
boolean wIsPressed, aIsPressed, dIsPressed = false;

public void setup() {
    size(500, 500);
    Player.setTopSpeed(15.0);
    Player.setColor(0,0,0);
}

public void draw() {
    noStroke();
    translate(0, 0);
    fill(255, 255, 255, 200);
    rect(0, 0, width, height);
    Player.show();
    Player.move();
    accelerate();
}

public void accelerate() {
    double playerAngle = Player.getPointDirection()*(Math.PI/180);
    // debug stuff
    for(int i = 0; i < 6; i++) {System.out.println("");}
    System.out.println("angle (radians): " + playerAngle); // angle (radians)
    System.out.println("max x: " + Player.getTopSpeedX() + ",  max y: " + Player.getTopSpeedY()); // converted top speeds
    System.out.println("speed x: " + Player.getDirectionX() + ",  speed y: " + Player.getDirectionY()); // actual speeds
    
    // angles cannot go over 2PI radians
    if (playerAngle > Math.PI*2) {
        Player.setPointDirection(0);
    }
    if (playerAngle < -Math.PI*2) {
        Player.setPointDirection(0);
    }
    
    // turn
    if (aIsPressed) { Player.turn(-5); }
    if (dIsPressed) { Player.turn(5); }
    
    // accel and deccel
    if (wIsPressed) {
        if (playerAngle < Math.PI/2 && playerAngle > -Math.PI/2 || 
            playerAngle < 2*Math.PI && playerAngle > 3*Math.PI/2 ||
            playerAngle < -3*Math.PI/2 && playerAngle > -2*Math.PI) {
            if (Player.getDirectionX() < Player.getTopSpeedX()) {
                Player.accelerate(0.15, "x");
            }
        }
        if (playerAngle < 3*Math.PI/2 && playerAngle > Math.PI/2 || 
            playerAngle < -Math.PI/2 && playerAngle > -3*Math.PI/2) {
            if (Player.getDirectionX() > -Player.getTopSpeedX()) {
                Player.accelerate(0.15, "x");
            }
        }
        if (playerAngle > Math.PI && playerAngle < 2*Math.PI ||
            playerAngle > -Math.PI && playerAngle < 0) {
            if (Player.getDirectionY() > -Player.getTopSpeedY()) {
                Player.accelerate(0.15, "y");
            }
        }
        if (playerAngle > 0 && playerAngle < Math.PI ||
            playerAngle > -2*Math.PI && playerAngle < -Math.PI) {
            if (Player.getDirectionY() < Player.getTopSpeedY()) {
                Player.accelerate(0.15, "y");
            }
        }
    } else if (!wIsPressed) {
        /*if (Player.getDirectionX() > 0) {
            //Player.accelerate(-0.25, "x");
            Player.setDirectionX(Player.getDirectionX() - 0.25);
        } else if (Player.getDirectionX() < 0) {
            //Player.accelerate(-0.25 , "x2");
            Player.setDirectionX(Player.getDirectionX() + 0.25);
        }
        if (Player.getDirectionY() > 0) {
            //Player.accelerate(-0.25 , "y");
            Player.setDirectionY(Player.getDirectionY() - 0.25);
        } else if (Player.getDirectionY() < 0) {
            //Player.accelerate(0.25 , "y2");
            Player.setDirectionY(Player.getDirectionY() + 0.25);
        }*/
        if (playerAngle < Math.PI/2 && playerAngle > -Math.PI/2 || 
            playerAngle < 2*Math.PI && playerAngle > 3*Math.PI/2 ||
            playerAngle < -3*Math.PI/2 && playerAngle > -2*Math.PI) {
            if (Player.getDirectionX() > 0) {
                Player.accelerate(-0.25, "x");
            } else if (Player.getDirectionX() < 0) {
                Player.accelerate(0.25 , "x2");
            }
        }
        if (playerAngle < 3*Math.PI/2 && playerAngle > Math.PI/2 || 
            playerAngle < -Math.PI/2 && playerAngle > -3*Math.PI/2) {
            if (Player.getDirectionX() < 0) {
                Player.accelerate(0.25 , "x2");
            } else if (Player.getDirectionX() > 0) {
                Player.accelerate(-0.25, "x");
            }
        }
        if (playerAngle > Math.PI && playerAngle < 2*Math.PI ||
            playerAngle > -Math.PI && playerAngle < 0) {
            if (Player.getDirectionY() > 0) {
                Player.accelerate(-0.25 , "y");
            } else if (Player.getDirectionY() < 0) {
                Player.accelerate(0.25 , "y2");
            }
        }
        if (playerAngle > 0 && playerAngle < Math.PI ||
            playerAngle > -2*Math.PI && playerAngle < -Math.PI) {
            if (Player.getDirectionY() < 0) {
                Player.accelerate(0.25 , "y2");
            } else if (Player.getDirectionY() > 0) {
                Player.accelerate(-0.25 , "y");
            }
        }
        if (Player.getDirectionY() > -0.2 && Player.getDirectionY() < 0.2) {
            Player.setDirectionY(0);
        }
        if (Player.getDirectionX() > -0.2 && Player.getDirectionX() < 0.2) {
            Player.setDirectionX(0);
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
