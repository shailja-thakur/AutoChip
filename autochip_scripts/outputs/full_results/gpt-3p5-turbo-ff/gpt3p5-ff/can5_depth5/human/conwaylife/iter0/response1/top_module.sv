module top_module(
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q);

  reg [255:0] next_q; // Next state of the game

  always@(posedge clk) begin
    if (load) begin
      q <= data; // Load initial state
    end else begin
      // Calculate next state
      for (integer i=0; i<256; i=i+1) begin
        reg count; // Number of neighbors
        
        case(i)
        // Top left corner cell
        0: count = q[15] + q[255] + q[240] + q[1] + q[31] + q[16] + q[17] + q[30];
        // Top right corner cell
        15: count = q[14] + q[239] + q[224] + q[0] + q[30] + q[31] + q[29] + q[238];
        // Bottom left corner cell
        240: count = q[224] + q[15] + q[0] + q[16] + q[14] + q[239] + q[15] + q[1];
        // Bottom right corner cell
        255: count = q[240] + q[14] + q[238] + q[254] + q[239] + q[255] + q[254] + q[0];
        // Top row cells
        1 to 14: count = q[i-1] + q[i+15] + q[i+16] + q[i+17] + q[i] + q[i-15] + q[i-16] + q[i-17];
        // Bottom row cells
        241 to 254: count = q[i-1] + q[i+15] + q[i-16] + q[i-17] + q[i] + q[i-15] + q[i+16] + q[i+15];
        // Left column cells
        16 to 240 by 16: count = q[i+15] + q[i+16] + q[i+1] + q[i+17] + q[i-15] + q[i-16] + q[i] + q[i-1];
        // Right column cells
        31 to 255 by 16: count = q[i+14] + q[i+16] + q[i-1] + q[i+15] + q[i-17] + q[i-15] + q[i] + q[i-16];
        // All other cells
        default: count = q[i-1] + q[i+1] + q[i+15] + q[i+16] + q[i+17] + q[i-15] + q[i-16] + q[i-17];
        endcase
        
        if (count == 0 || count == 1 || count >= 4) begin
          next_q[i] <= 0; // Cell becomes 0
        end else if (count == 3) begin
          next_q[i] <= 1; // Cell becomes 1
        end else begin
          next_q[i] <= q[i]; // Cell state does not change
        end
      end
      
      q <= next_q; // Update game state
    end
  end
endmodule
