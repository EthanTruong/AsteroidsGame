class Star { //note that this class does NOT extend Floater
    private float starX, starY, stroke;

    public Star() {
        starX = (int)(Math.random()*width+1);
        starY = (int)(Math.random()*height+1);
        stroke = 1;
    }

    public void show() {
        fill(0,0,0,10);
        strokeWeight(stroke);
        point(starX, starY);
    }

    public void setStroke(float size) {
        stroke = size;
    }
}
