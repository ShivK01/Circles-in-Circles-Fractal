/*
 Circles in Circles Recursive Fractal
 Shiv Krishnaswamy
 March 9, 2020
 
 This program has a circle fractal pattern draw on the window. In particular, the program draws a certain number of circles on the screen that are
 tangent to each other and to the very outside circle while being as big as possible. If the user presses the right arrow key, the number of circles
 increases by one and the fractal is redrawn accordingly. Likewise, if the user presses the left arrow key, the number of circles decreases by one and 
 the fractal if redrawn accoringly. Also, the depth of recursion can be controlled by the up and down arrow keys. If the up arrow key is pressed, the 
 depth of recursion is increased by one and the stroke weight is increased slightly. If the down arrow key is pressed, the depth of recursion is decreased by one 
 and the stroke weight is decreased slightly. Lastly, if the mouse is clicked, the user can change the colour of the fractal (6 colours can be cycled through from an array).  
*/

//Variable that keps track of how many circles there should be. 
float numCirc;
//Variable that holds what depth of recursion to draw up to.
int recursiveDepth;
//Array that holds stroke colours.
color[] strokeColours = {/*White*/color(255, 255, 255), /*Orange*/color(255, 159, 69), /*Blue*/color(15, 233, 255), /*Yellow*/color(239, 242, 53), /*Pink*/color(255, 64, 115), /*Green*/color(164, 255, 46)};
//Variables that holds current colour position in strokeColours array and current stroke weight.
int curColour = 0;
float curWeight = 1;

void setup() {
  size(1000, 1000);
  background(0);
  //Set variables to a default number.
  numCirc = 2;
  recursiveDepth = 0;
}

void draw() {
  background(0);
  strokeWeight(curWeight);
  stroke(strokeColours[curColour]);
  //Draw basic outside circle of which fractal is contanied in.
  noFill();
  ellipse(width / 2, height / 2, width, height);
  //Call the function to draw the fractal.
  drawFractal(width / 2, width / 2, height / 2, recursiveDepth);
}

//Controls what happens to drawing if the arrow keys are pressed. 
//Right and left to increase/decrease circle number and up/down to increase and decrease fractal depth as well as stroke weight.
void keyPressed() {
  if (key == CODED) {
    if (keyCode == RIGHT) {
      numCirc = numCirc + 1;
    } else if (keyCode == LEFT) {
      if (numCirc > 1) {
        numCirc = numCirc - 1;
      }
    } else if (keyCode == UP) {
      recursiveDepth = recursiveDepth + 1;
      curWeight = curWeight + 0.3;
    } else if (keyCode == DOWN) {
      if (recursiveDepth > 0) {
        if (curWeight >= 0.5) {
          curWeight = curWeight - 0.3;
        }
        recursiveDepth = recursiveDepth - 1;
      }
    }
  }
}

//When the mouse is clicked, the colour of the entire fractal drawing is changed to the next colour in the array.
void mouseClicked() {
  if (curColour >= 5) {
    curColour = 0;
  } else {
    curColour = curColour + 1;
  }
}

void drawFractal(float enclosingRadius, float centerX, float centerY, int level) {
  //Variables that hold values which are required to draw the fractal and calculate the distance from the center of the circle to the center of the circle being drawn.
  float halfTriangleSegmentAngle = 180 / numCirc;
  float rotate = 360 / numCirc;
  float radiusOfCirc = (sin(radians(halfTriangleSegmentAngle)) * enclosingRadius) / (1 + sin(radians(halfTriangleSegmentAngle)));
  float distToCircCenter = enclosingRadius - radiusOfCirc;
  //Loop that draws the circles per one depth of recursion.
  for (float i = rotate; i <= 360; i = i + rotate) {
    //Convert the coordinates of the offset of the center of the circle from polar to cartesian.
    float xOffset = distToCircCenter * cos(radians(i));
    float yOffset = distToCircCenter * sin(radians(i));
    //Draw the circle.
    ellipse(centerX + xOffset, centerY + yOffset, radiusOfCirc * 2, radiusOfCirc * 2);
    //Recursively call the function to draw the rest fo the fractal. Happens recursionDepth amount of times.
    if (level > 0) {
      drawFractal(radiusOfCirc, centerX + xOffset, centerY + yOffset, level - 1);
    }
  }
}
