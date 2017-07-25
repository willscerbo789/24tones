Triad triad = new Triad(0, 1, 0, 0);

float[][] points = new float[24][2];

void settings() {
   noSmooth();

   size(750, 250); 
}

void setup() {
  background(255);
  //C
  points[0][0] = 6*50;
  points[0][1] = 3*50;
  //C+
  points[1][0] = 3*50;
  points[1][1] = 2*50;
  //C#
  points[2][0] = 13*50;
  points[2][1] = 2*50;
  //Dd
  points[3][0] = 10*50;
  points[3][1] = 50;
  //D
  points[4][0] = 11*50;
  points[4][1] = 4*50;
  //D+
  points[5][0] = 8*50;
  points[5][1] = 3*50;
  //Eb
  points[6][0] = 5*50;
  points[6][1] = 2*50;
  //Ed
  points[7][0] = 2*50;
  points[7][1] = 50;
  //E
  points[8][0] = 3*50;
  points[8][1] = 4*50;
  //Fd
  points[9][0] = 0;
  points[9][1] = 3*50;
  //F
  points[10][0] = 10*50;
  points[10][1] = 3*50;
  //F+
  points[11][0] = 7*50;
  points[11][1] = 2*50;
  //F#
  points[12][0] = 4*50;
  points[12][1] = 50;
  //Gd
  points[13][0] = 5*50;
  points[13][1] = 4*50;
  //G
  points[14][0] = 2*50;
  points[14][1] = 3*50;
  //G+
  points[15][0] = 12*50;
  points[15][1] = 3*50;
  //G#
  points[16][0] = 9*50;
  points[16][1] = 2*50;
  //Ad
  points[17][0] = 6*50;
  points[17][1] = 50;
  //A
  points[18][0] = 7*50;
  points[18][1] = 4*50;
  //A+
  points[19][0] = 4*50;
  points[19][1] = 3*50;
  //A#
  points[20][0] = 50;
  points[20][1] = 2*50;
  //Bd
  points[21][0] = 11*50;
  points[21][1] = 2*50;
  //B
  points[22][0] = 8*50;
  points[22][1] = 50;
  //B+
  points[23][0] = 9*50;
  points[23][1] = 4*50;
  strokeWeight(3);
    line(points[triad.getRoot()][0], points[triad.getRoot()][1], points[triad.getThird()][0], points[triad.getThird()][1]);
   line(points[triad.getThird()][0], points[triad.getThird()][1], points[triad.getFifth()][0], points[triad.getFifth()][1]);
   line(points[triad.getFifth()][0], points[triad.getFifth()][1], points[triad.getRoot()][0], points[triad.getRoot()][1]);


  
}

void keyPressed() {  
    background(255);
  if (key == 'p' || key == 'P') {
    println("P");
    triad.parallel();    
    println(triad.getRoot());
    println(triad.getThird());
    println(triad.getFifth());
  } else if (key == 'l' || key == 'L') {
    println("L");
    triad.leadingTone();    
    println(triad.getRoot());
    println(triad.getThird());
    println(triad.getFifth());
  } else if (key == 'r' || key == 'R') {
    println("R");
    triad.relative(); 
    println(triad.getRoot());
    println(triad.getThird());
    println(triad.getFifth());
  } else if (key == 'm' || key == 'M') {
    println("M");
    triad.microShift1(1);
    println(triad.getRoot());
    println(triad.getThird());
    println(triad.getFifth());
  } else if (key == 'n' || key == 'N') {
    println("N");
    triad.microShift2(1);    
    println(triad.getRoot());
    println(triad.getThird());
    println(triad.getFifth());
  }
  println("--------------------");
   line(points[triad.getRoot()][0], points[triad.getRoot()][1], points[triad.getThird()][0], points[triad.getThird()][1]);
   line(points[triad.getThird()][0], points[triad.getThird()][1], points[triad.getFifth()][0], points[triad.getFifth()][1]);
   line(points[triad.getFifth()][0], points[triad.getFifth()][1], points[triad.getRoot()][0], points[triad.getRoot()][1]);
}

void draw() {
  
   strokeWeight(10);
   for (int i = 0; i < 24; i++) {
     point(points[i][0], points[i][1]);
   }
   strokeWeight(3);
    
}

class Loop {
  
  public int startingPosition;
  public int lengthh;
  
  public Loop(int startingPosition, int lengthh) {
    this.startingPosition = startingPosition;
    this.lengthh = lengthh;    
  }
  
  public int getPos() {
    return this.startingPosition;
  }
  public void setPos(int p) {
    this.startingPosition = p;
  }
  public int getL() {
    return this.lengthh;    
  }
  public void setL(int l) {
    this.lengthh = l;
  }
  
}

public Loop loopCheckSubroutine(int[][] chords, int pos, Triad tr) {
  
  int loopPos = 0;
  for (int j = 0; j < pos - 1; j++) {
    if ((chords[j][0] == tr.getRoot()) && (chords[j][1] == tr.getThird()) && (chords[j][2] == tr.getFifth())) {
       loopPos = j;
    }
    
  }
  Loop q = new Loop(loopPos, pos - loopPos);  
  return q;
}


public int loopCheck(int numTries) {
  
  Triad tr = new Triad(0, 1, 1, -1);
  int[][] chords = new int[numTries][3];
  
  chords[0][0] = tr.getRoot();
  chords[0][1] = tr.getThird();
  chords[0][2] = tr.getFifth();
  
  int loopLength = 0;
  int loopPosition = 0;
  
  for (int i = 0; i < (numTries); i++) {
    tr.leadingTone();
    tr.microShift1(1);
    chords[i][0] = tr.getRoot();
    chords[i][1] = tr.getThird();
    chords[i][2] = tr.getFifth();
    Loop test = loopCheckSubroutine(chords, i, tr);
    if (test.getL() != 0) {
      loopLength = test.getL();
      loopPosition = test.getPos();
      
    }
        
  }
  println("Loop Starting Position");
  println(loopPosition);
  println(chords[loopPosition][0]);
  println(chords[loopPosition][1]);
  println(chords[loopPosition][2]);
  return loopLength;
}