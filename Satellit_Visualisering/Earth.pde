class Earth {
  PImage earth;
  PShape globe;

  void setup() {
    earth = loadImage("earth.jpg");

    noStroke();
    globe = createShape(SPHERE, r);
    globe.setTexture(earth);
  }

  void drawEarth() {
    clear();
    background(51);
    pushMatrix();
    translate(width*0.5, height*0.5);
    rotateY(angle);
    angle += 0.001;

    lights();
    fill(200);
    noStroke();
    shape(globe);

    popMatrix();
  }
}
