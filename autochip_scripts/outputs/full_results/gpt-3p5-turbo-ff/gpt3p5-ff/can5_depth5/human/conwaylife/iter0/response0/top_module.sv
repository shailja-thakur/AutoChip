module top_module(
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q);
  
  reg [255:0] q_next; // Next state of the game
  
  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      q <= q_next;
    end
  end
  
  // Game logic
  always @* begin
    for (integer i = 0; i < 256; i = i + 16) begin
      for (integer j = 0; j < 16; j = j + 1) begin
        integer cell_index = i + j;
        integer left_index, right_index, top_index, bottom_index;
        
        // Calculate indices for neighboring cells (toroid grid)
        if (j == 0) begin
          left_index = i + 15;
        end else begin
          left_index = cell_index - 1;
        end
        
        if (j == 15) begin
          right_index = i;
        end else begin
          right_index = cell_index + 1;
        end
        
        if (i == 0) begin
          top_index = cell_index + 240;
        end else begin
          top_index = cell_index - 16;
        end
        
        if (i == 240) begin
          bottom_index = cell_index - 240;
        end else begin
          bottom_index = cell_index + 16;
        end
        
        // Count the number of neighboring cells that are alive
        integer num_alive_neighbours = q[left_index] + q[right_index] + q[top_index] + q[bottom_index] +
          q[left_index + 16] + q[right_index + 16] + q[top_index + 16] + q[bottom_index + 16];
        
        // Determine the next state of the current cell based on the number of alive neighbors
        if (num_alive_neighbours < 2 || num_alive_neighbours > 3) begin
          q_next[cell_index] = 0;
        end else if (num_alive_neighbours == 3) begin
          q_next[cell_index] = 1;
        end else begin
          q_next[cell_index] = q[cell_index];
        end
      end
    end
  end 
endmodule
