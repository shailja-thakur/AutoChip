module top_module(
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q);
          
  // Create a 16x16 grid
  reg [15:0] qGrid [15:0];
  
  // Assign initial state of qGrid during load
  always @ (posedge clk) begin
    if (load) begin
      // Assign each row of qGrid from data input
      for (integer row = 0; row < 16; row = row + 1)
        qGrid[row] <= data[(row*16)+:16];
    end
  end
  
  // Calculate the game state at each clock cycle
  always @ (posedge clk) begin
    // Create a new 16x16 grid to store the next state
    reg [15:0] nextGrid [15:0];
    
    // Iterate through each cell and update its state
    for (integer row = 0; row < 16; row = row + 1) begin
      for (integer col = 0; col < 16; col = col + 1) begin
        // Count the number of neighbors for each cell
        integer neighbors = 0;
        
        // Check the eight neighboring cells and handle toroid wrapping
        if (qGrid[(row-1+16)%16][col]) neighbors = neighbors + 1; // Top
        if (qGrid[row][(col+1)%16]) neighbors = neighbors + 1; // Right
        if (qGrid[(row+1)%16][col]) neighbors = neighbors + 1; // Bottom
        if (qGrid[row][(col-1+16)%16]) neighbors = neighbors + 1; // Left
        if (qGrid[(row-1+16)%16][(col+1)%16]) neighbors = neighbors + 1; // Top-Right
        if (qGrid[(row+1)%16][(col+1)%16]) neighbors = neighbors + 1; // Bottom-Right
        if (qGrid[(row+1)%16][(col-1+16)%16]) neighbors = neighbors + 1; // Bottom-Left
        if (qGrid[(row-1+16)%16][(col-1+16)%16]) neighbors = neighbors + 1; // Top-Left
        
        // Update the cell state based on the number of neighbors
        if (neighbors <= 1) begin // Rule 1
          nextGrid[row][col] = 0;
        end else if (neighbors == 2) begin // Rule 2
          nextGrid[row][col] = qGrid[row][col];
        end else if (neighbors == 3) begin // Rule 3
          nextGrid[row][col] = 1;
        end else if (neighbors >= 4) begin // Rule 4
          nextGrid[row][col] = 0;
        end
      end
    end
    
    // Assign the next state to qGrid
    qGrid <= nextGrid;
  end
  
  // Assign q from qGrid
  always @ (*) begin
    for (integer row = 0; row < 16; row = row + 1) begin
      q[(row*16)+:16] = qGrid[row];
    end
  end
  
endmodule
