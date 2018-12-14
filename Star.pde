class Star { //note that this class does NOT extend Floater
    private float starX, starY, strokeSize;

    public Star() {
        starX = (int)(Math.random()*width+1);
        starY = (int)(Math.random()*height+1);
        strokeSize = 1;
    }

    public void show() {
        fill(0,0,0,10);
        stroke(0,0,0);
        strokeWeight(strokeSize);
        point(starX, starY);
    }

    public void setStroke(float size) {
        strokeSize = size;
    }
}
