module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
    );
  
  reg [255:0] next_state; // next state of the game
  
  // always block to update the game state every clock cycle
  always @(posedge clk) begin
    if (load) // if load is high, load the initial state
      q <= data;
    else // else, update the game state according to the rules
      q <= next_state;
  end
  
  // always block to calculate the next state based on the current state
  always @* begin
    next_state = q; // initialize next_state with the current state
    
    for (integer i = 0; i < 16; i = i+1) begin
      for (integer j = 0; j < 16; j = j+1) begin
        integer neighbors = 0;
        
        // calculate the number of alive neighbors
        if (q[i*16 + ((j+15)%16)]) neighbors = neighbors + 1;
        if (q[i*16 + ((j+1)%16)]) neighbors = neighbors + 1;
        if (q[((i+15)%16)*16 + ((j+15)%16)]) neighbors = neighbors + 1;
        if (q[((i+15)%16)*16 + j]) neighbors = neighbors + 1;
        if (q[((i+15)%16)*16 + ((j+1)%16)]) neighbors = neighbors + 1;
        if (q[((i+1)%16)*16 + ((j+15)%16)]) neighbors = neighbors + 1;
        if (q[((i+1)%16)*16 + j]) neighbors = neighbors + 1;
        if (q[((i+1)%16)*16 + ((j+1)%16)]) neighbors = neighbors + 1;
        
        // update the cell state based on the number of neighbors
        if (neighbors < 2 || neighbors > 3)
          next_state[i*16 + j] = 0;
        else if (neighbors == 3)
          next_state[i*16 + j] = 1;
      end
    end
  end

endmodule
