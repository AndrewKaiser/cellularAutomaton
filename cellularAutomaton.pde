int resolutionX = 600;
int resolutionY = 700;
int globalNum;
int[] bools = new int[8];
//binary matrix of whole graph
int[][] points;

color white = color(255,255,255);
color black = color(0,0,0);


void setup() {
  size(600, 700);
  //made it up to 64 binary so far
  globalNum = (int)random(255);
  // the grid that dictates the logic of the points that are drawn
  points = new int[width][height];

  loadPixels();
  background(0);
  loop();
}

void draw() {
  setBackgroundColor(black);
  render();
  increment();
  delay(1000);
}

void increment() {
  globalNum ++;
  if (globalNum > 255) {
    globalNum = 0;
  }
  int bin = binConvert(globalNum);
  for(int x=bools.length-1; x>0; --x) {
    bools[x] = bin%10;
    bin = bin/10;
  }
}

/**
* the previous render() function drew every point individually
* this was very process intensive,
* the array pixels instead loads the grid like an image
* doing a single draw per loop instead of 600*700 draws
*
* determining drawing the point using 3 previous points
* allows us to have 255 different combinations,
* this is because there needs to be 9 digits in the array to cover all possibilites
* eg. 3 pixels, 9 total possibilites, needs 255 bit numbers like this 11111111
*/

void render() {
  //initializes all points with 0
  for (int y=0; y<resolutionY; y++) {
    for (int x=0; x<resolutionX; x++)
      points[x][y] = 0;
  }
  // the cascading starting point
  points[resolutionX/2][0] = 1;
  for (int y=0; y<resolutionY-1; y++) {
    for (int x=1; x<resolutionX-2; x++) {
      int a = points[x-1][y];
      int b = points[x][y];
      int c = points[x+1][y];

      // if the binary automata rule returns true then we draw a pixel
      if (addPt(a, b, c)==1) {
        points[x][y+1] = 1;
        int position = width*y+x;
        pixels[position] = white;

        // point(x, y+1);
      }
    }
  }
  // the processing function that draws the pixels[] grid
  updatePixels();
}

void setBackgroundColor(color background) {
  for (int i=0; i<width*height; ++i) {
    pixels[i] = background;
  }
  updatePixels();
}

int addPt(int a, int b, int c) {
  //binary system for yes/no to draw the point point
  if (a==1 && b==1 && c==1)
    return bools[0];
  if (a==1 && b==1 && c==0)
    return bools[1];
  if (a==1 && b==0 && c==1)
    return bools[2];
  if (a==1 && b==0 && c==0)
    return bools[3];
  if (a==0 && b==1 && c==1)
    return bools[4];
  if (a==0 && b==1 && c==0)
    return bools[5];
  if (a==0 && b==0 && c==1)
    return bools[6];
  // if (a==0 && b==0 && c==0)
  return bools[7];
}

int binConvert(int num) {
  if (num == 0) {
    return 0;
  }
  else {
    return (num%2 + 10*binConvert(num/2));
  }
}


// void keyPressed() {
//   if (key == 's')
//     save(String.valueOf(bools[0])+String.valueOf(bools[1])+
//     	String.valueOf(bools[2])+String.valueOf(bools[3])+
//     	String.valueOf(bools[4])+String.valueOf(bools[5])+
//     	String.valueOf(bools[6])+String.valueOf(bools[7])+
//     	"Piramid.tif");
// }
