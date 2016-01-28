int resolutionX = 600;
int resolutionY = 700;
int a, b, c;
//PVector first, b, c;
//int refreshRate = 200;
boolean bStop = true;
int stopStartTime;
int globalNum;
int[] bools = new int[8];
//binary matrix of whole graph
int[][] points = new int[resolutionX][resolutionY];

void setup() {
  size(600, 700);
    stroke(255);
    globalNum = (int)random(255);
    increment();
    // int r = int(rand);
    //made it up to 64 binary so far
    // bools[0] = 1;
    // bools[1] = 1;
    // bools[2] = 0;
    // bools[3] = 1;
    // bools[4] = 0;
    // bools[5] = 1;
    // bools[6] = 1;
    // bools[7] = 1;

    //first = new PVector(resolutionX/2, 0);
    //stopStartTime = millis();
    //background(0);
    loop();
}

void draw() {
  background(0);
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

void render() {
  //initializes all points with 0
  for (int y=0; y<resolutionY; y++) {
    for (int x=0; x<resolutionX; x++)
      points[x][y] = 0;
  }
  points[resolutionX/2][0] = 1;
  point(resolutionX/2, 0);
  for (int y=0; y<resolutionY-1; y++) {
    // delay(250);
    for (int x=1; x<resolutionX-2; x++) {
      a = points[x-1][y];
      b = points[x][y];
      c = points[x+1][y];

      if (addPt(a, b, c)==1) {
        points[x][y+1] = 1;
        point(x, y+1);
      }
    }
  }
  //next rule, if key down pressed, add row
  //next next rule, check 4 lines at a time
  // // println("Binary value: " + String.valueOf(bools[0])+
  // // 	String.valueOf(bools[1])+String.valueOf(bools[2])+
  // // 	String.valueOf(bools[3])+String.valueOf(bools[4])+
  // // 	String.valueOf(bools[5])+String.valueOf(bools[6])+
  // // 	String.valueOf(bools[7]) + "\n");
  //
  // save(String.valueOf(bools[0])+String.valueOf(bools[1])+
  // 		String.valueOf(bools[2])+String.valueOf(bools[3])+
  // 		String.valueOf(bools[4])+String.valueOf(bools[5])+
  // 		String.valueOf(bools[6])+String.valueOf(bools[7])+
  // 		"Piramid.tif");
  bStop = true;
  // noLoop();
}

int addPt(int a, int b, int c) {
  //binary system for yes/no make point
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
  if (a==0 && b==0 && c==0)
    return bools[7];
  //it should never get here
  return 0;
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
