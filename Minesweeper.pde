import de.bezier.guido.*;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined
private final static int NUM_ROWS = 20;
private final static int NUM_COLS = 20;
private int numberofbombs = 30;
private PImage img;
private boolean gameover = false;

void setup ()
{
    size(500, 500);
    textAlign(CENTER,CENTER);
    bombs = new ArrayList <MSButton>();
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int row = 0; row<NUM_ROWS;row++)
    {
        for(int col = 0; col<NUM_COLS;col++)
        {
           buttons[row][col] = new MSButton(row, col);
        }
    }
    
    
    setBombs(numberofbombs);
}
public void setBombs(int total)
{
    int num =0;
    while(num < total)
    {
        int row = (int)(Math.random()*NUM_ROWS);
        int col = (int)(Math.random()*NUM_COLS);
        if(!(bombs.contains(buttons[row][col])))
        {
            bombs.add(buttons[row][col]);
            // System.out.println(row + ", " + col);
            num++;
        }
    }

}

public void draw ()
{
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    int numbut =0;
    for(int ro = 0; ro < NUM_ROWS; ro++)
    {
        for(int co = 0; co < NUM_COLS; co++)
        {
            if(buttons[ro][co].isClicked() == false)
                numbut ++;
        }
    }
    if(numbut == numberofbombs)
    {
        return true;
    }
    return false;
}


public void displayLosingMessage()
{
    gameover = true;
    textSize(16);
    String lose = "SORRY! TRY AGAIN!";
    for(int co = 2; co < 19; co++)
    {
        buttons[9][co].setLabel(lose.substring(co-2, co-1));
    }


    for(int i = 0; i<bombs.size(); i++)
    {
        if(bombs.get(i).isClicked() == false)
            bombs.get(i).clicked = true;

    }
}
public void displayWinningMessage()
{
    gameover = true;
    String win = "Congrats! You won!";
    textSize(16);
    fill(255, 232, 0);
    for(int co =1; co<19; co++)
        buttons[9][co].setLabel(win.substring(co-1, co));

}

public void keyPressed()
{
    if(key == 'r')
    {
        gameover = false;
        buttons = new MSButton[NUM_ROWS][NUM_COLS];
        for(int row = 0; row<NUM_ROWS;row++)
        {
            for(int col = 0; col<NUM_COLS;col++)
            {
               buttons[row][col] = new MSButton(row, col);
            }
        }
        bombs = new ArrayList <MSButton>();
        setBombs(numberofbombs);
    }

}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 500/NUM_COLS;
        height = 500/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        if(keyPressed && clicked == false)
        {
            if(key == 'm' || key == 'M')
                marked = !marked;
        }
        else
        {
            clicked = true;
            if(bombs.contains(this))
                displayLosingMessage();
            else if(countBombs(r,c) > 0)
                setLabel("" + countBombs(r, c) + "");
            else{
                if(isValid(r-1, c-1) == true && buttons[r-1][c-1].isClicked() == false)
                    buttons[r-1][c-1].mousePressed();
                if(isValid(r-1, c) == true && buttons[r-1][c].isClicked() == false)
                    buttons[r-1][c].mousePressed();
                if(isValid(r-1, c+1) == true && buttons[r-1][c+1].isClicked() == false)
                    buttons[r-1][c+1].mousePressed();
                if(isValid(r, c-1) == true && buttons[r][c-1].isClicked() == false)
                    buttons[r][c-1].mousePressed();
                if(isValid(r, c+1) == true && buttons[r][c+1].isClicked() == false)
                    buttons[r][c+1].mousePressed();
                if(isValid(r+1, c-1) == true && buttons[r+1][c-1].isClicked() == false)
                    buttons[r+1][c-1].mousePressed();
                if(isValid(r+1, c) == true && buttons[r+1][c].isClicked() == false)
                    buttons[r+1][c].mousePressed();
                if(isValid(r+1, c+1) == true && buttons[r+1][c+1].isClicked() == false)
                    buttons[r+1][c+1].mousePressed();
            }
        }
    }

    public void draw () 
    {
        if (marked == true && clicked == false && gameover == false)
        {
            fill(253, 215, 76);
        }
        else if( clicked && bombs.contains(this) == true) 
            fill(253, 0, 35);
        else if(clicked)
            fill(255);
        else 
            fill(7, 128, 246);

        stroke(200);
        rect(x, y, width, height, 5);
        fill(100);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(0<= r && 0<=c && r < NUM_ROWS && c < NUM_COLS)
            return true;
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if(isValid(row-1, col-1) == true && bombs.contains(buttons[row-1][col-1]))
                numBombs++;
        if(isValid(row-1, col) == true && bombs.contains(buttons[row-1][col]))
                numBombs++;
        if(isValid(row-1, col+1) == true && bombs.contains(buttons[row-1][col+1]))
                numBombs++;
        if(isValid(row, col-1) == true && bombs.contains(buttons[row][col-1]))
                numBombs++;
        if(isValid(row, col+1) == true && bombs.contains(buttons[row][col+1]))
                numBombs++;
        if(isValid(row+1, col-1) == true && bombs.contains(buttons[row+1][col-1]))
                numBombs++;
        if(isValid(row+1, col) == true && bombs.contains(buttons[row+1][col]))
                numBombs++;
        if(isValid(row+1, col+1) == true && bombs.contains(buttons[row+1][col+1]))
                numBombs++;
        return numBombs;
    }
}



