import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined
private int NUM_ROWS = 20;
private int NUM_COLS = 20;

void setup ()
{
    size(400, 400);
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
    
    
    setBombs(20);
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
            System.out.println(row + ", " + col);
            num++;
        }
    }

    // for(int i =0; i<10;i++)
    // {
    //     int row = (int)(Math.random()*NUM_ROWS);
    //     int col = (int)(Math.random()*NUM_COLS);
    //     if(!(bombs.contains(buttons[row][col])))
    //     {
    //         bombs.add(buttons[row][col]);
    //         System.out.println(row + ", " + col);
    //     }
    // }

}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
}
public void displayWinningMessage()
{
    //your code here
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
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
        clicked = true;
        if(keyPressed == true)
        {
            marked = !marked;
            if(marked)
                clicked = false;
        }
        else if(bombs.contains(this))
            displayLosingMessage();
        else if(countBombs(r,c) > 0)
            setLabel("" + countBombs(r, c) + "");
        else {
            if(isValid(r-1, c-1) == true && buttons[r-1][c-1].isClicked() == true);
                buttons[r-1][c-1].mousePressed();
        }
        
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(r <= NUM_ROWS && c <= NUM_COLS)
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



