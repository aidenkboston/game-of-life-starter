final int SPACING = 20; // each cell's width/height //<>// //<>//
final float DENSITY = 0.1; // how likely each cell is to be alive at the start
int[][] grid; // the 2D array to hold 0's and 1's

void setup() {
  size(800, 600); // adjust accordingly, make sure it's a multiple of SPACING
  background(0, 0, 0);
  noStroke(); // don't draw the edges of each cell
  frameRate(5); // controls speed of regeneration
  grid = new int[height / SPACING][width / SPACING];
  for (int i = 0; i < grid.length; i++) {
    for (int j = 0; j < grid[0].length; j++) {
      if (Math.random() < DENSITY) {
        grid[i][j] = 1;
      } else {
        grid[i][j] = 0;
      }
    }
  }
}

void draw() {
  showGrid();
  grid = calcNextGrid();
}

int[][] calcNextGrid() {
  int[][] nextGrid = new int[grid.length][grid[0].length];
  for (int i = 1; i < grid.length - 1; i++) {
    for (int j = 1; j < grid[0].length - 1; j++) {
      int neighbors = countNeighbors(i, j);
      if (grid[i][j] == 0 && neighbors == 3) {       
        nextGrid[i][j] = 1;
      } else if (neighbors == 2 || neighbors == 3) {
        nextGrid[i][j] = grid[i][j] + 1;
      } else {
        nextGrid[i][j] = 0;
      }
    }
  }
  return nextGrid;
}

int countNeighbors(int x, int y) {
  int n = 0;
  if (grid[x + 1][y] != 0) n++;
  if (grid[x + 1][y + 1] != 0) n++;
  if (grid[x][y + 1] != 0) n++;
  if (grid[x - 1][y - 1] != 0) n++;
  if (grid[x - 1][y] != 0) n++;
  if (grid[x][y - 1] != 0) n++;
  if (grid[x - 1][y + 1] != 0) n++;
  if (grid[x + 1][y - 1] != 0) n++;
  return n;
}

void showGrid() {
  for (int i = 0; i < grid.length; i++) {
    for (int j = 0; j < grid[0].length; j++) {
      square(j * SPACING - SPACING, i * SPACING, SPACING);
      if (grid[i][j] == 0) {
        fill(0, 0, 0);
      } else {
        fill(305 - 50 * grid[i][j], 0, -50 + 50 * grid[i][j]);
      }      
    }
  }  
}
