Spaceship Player = new Spaceship();
public void setup() {
    size(300, 300);
}

public void draw() {
    background(255);
    Player.show();
    Player.move();
    Player.accel();
}
