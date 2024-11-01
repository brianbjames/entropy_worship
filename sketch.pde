void setup() {
    size(800, 600);
}

void draw() {
    background(random(255), random(255), random(255));
    ellipse(mouseX, mouseY, 50, 50);
}
