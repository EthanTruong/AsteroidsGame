Spaceship Player = new Spaceship();
boolean wIsPressed, aIsPressed, dIsPressed = false;

public void setup() {
    size(500, 500);
    Player.setTopSpeed(15.0);
}

public void draw() {
    background(255);
    Player.show();
    Player.move();
    accelerate();
}

public void accelerate() {
    // DEBUG
    for(int i = 0; i < 6; i++) {System.out.println("");}
    System.out.println("angle (radians): " + Player.getPointDirection()*(Math.PI/180)); // angle (radians)
    System.out.println("max x: " + Player.getTopSpeedX() + ",  max y: " + Player.getTopSpeedY()); // converted top speeds
    System.out.println("speed x: " + Player.getDirectionX() + ",  speed y: " + Player.getDirectionY()); // actual speeds
    
    
    // angles cannot go over 2PI radians
    if (Player.myPointDirection*(Math.PI/180) > Math.PI*2) {
        Player.setPointDirection(0);
    }
    if (Player.myPointDirection*(Math.PI/180) < -Math.PI*2) {
        Player.setPointDirection(0);
    }
    
    if (aIsPressed) { Player.turn(-5); }
    if (dIsPressed) { Player.turn(5); }
    
    if (wIsPressed) {
        if (((Player.getPointDirection()*(Math.PI/180)) < Math.PI/2 && (Player.getPointDirection()*(Math.PI/180)) > -Math.PI/2) || 
            ((Player.getPointDirection()*(Math.PI/180)) < 2*Math.PI && (Player.getPointDirection()*(Math.PI/180)) > (3*Math.PI)/2)) {
            if (Player.getDirectionX() < Player.getTopSpeedX()) {
                Player.accelerate(0.15, "x");
            }
        }
        if (((Player.getPointDirection()*(Math.PI/180)) < 3*Math.PI/2 && (Player.getPointDirection()*(Math.PI/180)) > Math.PI/2) || 
            ((Player.getPointDirection()*(Math.PI/180)) < -Math.PI/2 && (Player.getPointDirection()*(Math.PI/180)) > -Math.PI)) {
            if (Player.getDirectionX() > -Player.getTopSpeedX()) {
                Player.accelerate(0.15, "x");
            }
        }
        if (((Player.getPointDirection()*(Math.PI/180)) > Math.PI && (Player.getPointDirection()*(Math.PI/180)) < 2*Math.PI) ||
            ((Player.getPointDirection()*(Math.PI/180)) > -Math.PI && (Player.getPointDirection()*(Math.PI/180)) < 0)) {
            if (Player.getDirectionY() > -Player.getTopSpeedY()) {
                Player.accelerate(0.15, "y");
            }
        }
        if (((Player.getPointDirection()*(Math.PI/180)) > 0 && (Player.getPointDirection()*(Math.PI/180)) < Math.PI) ||
            ((Player.getPointDirection()*(Math.PI/180)) > -2*Math.PI && (Player.getPointDirection()*(Math.PI/180)) < -Math.PI)) {
            if (Player.getDirectionY() < Player.getTopSpeedY()) {
                Player.accelerate(0.15, "y");
            }
        }
    } else if (!wIsPressed) {
        if (Player.getDirectionX() > 0) {
            Player.accelerate(-0.25, "x");
        } else if (Player.getDirectionX() < 0) {
            Player.accelerate(-0.25 , "x2");
        }
        if (Player.getDirectionY() > 0) {
            Player.accelerate(-0.25 , "y");
        } else if (Player.getDirectionY() < 0) {
            Player.accelerate(0.25 , "y2");
        }
        if (Player.getDirectionY() > -0.2 && Player.getDirectionY() < 0.2) {
            Player.setDirectionY(0);
        }
        if (Player.getDirectionX() > -0.2 && Player.getDirectionX() < 0.2) {
            Player.setDirectionX(0);
        }
    }
}

void keyPressed() {
    if ( key == 'w' ) { wIsPressed = true; } else 
    if ( key == 'a' ) { aIsPressed = true; } else
    if ( key == 'd' ) { dIsPressed = true; }
}

void keyReleased() {
    if ( key == 'w' ) { wIsPressed = false; } else 
    if ( key == 'a' ) { aIsPressed = false; } else
    if ( key == 'd' ) { dIsPressed = false; }
}
