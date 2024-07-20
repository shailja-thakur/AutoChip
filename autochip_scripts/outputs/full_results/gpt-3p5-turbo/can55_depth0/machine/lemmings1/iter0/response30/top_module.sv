module top_module (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  output reg walk_left,
  output reg walk_right
);

  // Define the states
  parameter WL = 0;
  parameter WR = 1;
  
  // Define the state register
  reg [1:0] state;
  
  always @(posedge clk) begin
    if (areset) begin
      state <= WL; // Reset the state to WL when areset is high
    end else begin
      // Update the state based on the current state and inputs
      if (state == WL) begin
        state <= bump_left ? WR : WL;
      end else if (state == WR) begin
        state <= bump_right ? WL : WR;
      end
    end
  end
  
  always @(*) begin
    // Assign the outputs based on the current state
    walk_left = (state == WL);
    walk_right = (state == WR);
  end

endmodule
