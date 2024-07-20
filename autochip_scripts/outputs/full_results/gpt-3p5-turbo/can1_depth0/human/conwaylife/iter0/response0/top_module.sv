module top_module(
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q);

  reg [255:0] next_q;  // Next state of the game

  integer i, j;  // Loop variables

  always @(posedge clk) begin
    if (load) begin
      // Load initial state
      q <= data;
    end else begin
      // Update game state
      for (i = 0; i < 16; i = i + 1) begin
        for (j = 0; j < 16; j = j + 1) begin
          // Calculate number of neighbors
          integer num_neighbors = q[((i-1)&15)*16+((j-1)&15)] +
                                  q[((i-1)&15)*16+(j&15)] +
                                  q[((i-1)&15)*16+((j+1)&15)] +
                                  q[(i*16+((j-1)&15))] +
                                  q[(i*16+((j+1)&15))] +
                                  q[((i+1)&15)*16+((j-1)&15)] +
                                  q[((i+1)&15)*16+(j&15)] +
                                  q[((i+1)&15)*16+((j+1)&15)];
          // Update cell state based on number of neighbors
          if (num_neighbors == 3) begin
            next_q[i*16+j] = 1;  // Cell becomes alive
          end else if (num_neighbors < 2 || num_neighbors >= 4) begin
            next_q[i*16+j] = 0;  // Cell becomes dead
          end else begin
            next_q[i*16+j] = q[i*16+j];  // Cell state does not change
          end
        end
      end
      q <= next_q;  // Update current state
    end
  end

endmodule
