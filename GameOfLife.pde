final static int GRIDHEIGHT = 16;
final static int GRIDWIDTH = 16;

float cellHeight;
float cellWidth;

boolean paused = false;

int[][] cells = new int[GRIDWIDTH][GRIDHEIGHT];

void setup() {
  size(600, 600);
  background(0);
  frameRate(20);
  ellipseMode(CORNERS);
  cellHeight = height/GRIDHEIGHT;
  cellWidth = width/GRIDWIDTH;
  init(cells);
  for(int i = 0; i < GRIDWIDTH; i++) {
    cells[i] = new int[GRIDHEIGHT];
    for(int j = 0; j < GRIDHEIGHT; j++) {
      if (random(100) < 50) {
        cells[i][j] = 1;
      }
    }
  }
}    

void draw() {
  if (!paused) {
  background(0);
  
  int[][] newcells = new int[GRIDWIDTH][GRIDHEIGHT];
  for(int i = 0; i < GRIDWIDTH; i++) {
    newcells[i] = new int[GRIDHEIGHT];
    for(int j = 0; j < GRIDHEIGHT; j++) {
      int neighbors = neighbors(cells, i, j);
      //println( neighbors );
      if (cells[i][j] > 0) {
        if (neighbors < 2) {
          newcells[i][j] = 0;
        } else if ( (2 == neighbors) || (3 == neighbors) ) {
          newcells[i][j] = cells[i][j] + 1;
        } else if ( neighbors > 3 ) {
          newcells[i][j] = 0;
        }
      } else if (cells[i][j] == 0) {
        if (3 == neighbors) {
          newcells[i][j] = 1;
        }
      }
      
      fill(cells[i][j]*32, 0, cells[i][j]*128);
      ellipse((i + 0.2)*cellWidth, (j + 0.2)*cellHeight,
          (i + 0.8)*cellWidth, (j + 0.8)*cellHeight);
    }
  }
  if (random(100) < 20) {
    for( int i = 0; i < 10; i++ ) {
      newcells[floor(random(GRIDWIDTH))][floor(random(GRIDHEIGHT))] += 1;
    }
  }
  deepCopy(newcells, cells);
  } 
}

void deepCopy(int[][] fromArr, int[][] toArr) {
  for( int i = 0; i < fromArr.length; i++) {
    arraycopy(fromArr, 0, toArr, 0, fromArr[i].length);
  }
}

int neighbors(int[][] arr, int x, int y) {
  int sum = 0;
  for( int i = x - 1; i <= x + 1; i++) {
    //if (( x == 1) && (1 == y)) print( " i " + i);
    for( int j = y - 1; j <= y + 1; j++) {
      //if (( x == 1) && (1 == y)) print( " j " + j);
      int index, jndex;
      if (i < 0) {
        index = arr.length - 1;
      } else if (i == arr.length) {
        index = 0; 
      } else {
        index = i;
      }
      if (j < 0) {
        jndex = arr[index].length - 1;
      } else if (j == arr[index].length) {
        jndex = 0; 
      } else {
        jndex = j;
      }
      if (arr[index][jndex] > 0){
        sum += 1;
      }
    } 
  } 
  if (arr[x][y] > 0) {
    sum -= 1;
  }      

  //if (( x == 1) && (1 == y)) println( " sum " + sum );
  return sum;
}
void init(int[][] arr) {
  for(int i = 0; i < arr.length; i++) {
    cells[i] = new int[GRIDHEIGHT];
    for(int j = 0; j < arr[i].length; j++) {
      if (random(100) < 50) {
        arr[i][j] = 1;
      }
    }
  }

}

void keyPressed() {
 // if paused == true make it false
  init(cells); 
}   
