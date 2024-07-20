module top_module (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  output reg walk_left,
  output reg walk_right
);

  // Define the states WL and WR
  parameter WL = 0;
  parameter WR = 1;

  // Define the state register
  reg state;

  // Update the state machine on the rising edge of the clk signal
  always @(posedge clk) begin
    // Reset the state to WL on the rising edge of the areset signal
    if (areset)
      state <= WL;
    else begin
      // Determine the next state based on the current state and inputs
      if (state == WL)
        state <= bump_left ? WR : WL;
      else if (state == WR)
        state <= bump_right ? WL : WR;
    end
  end

  // Assign the walk_left and walk_right outputs based on the state
  always @* begin
    walk_left = (state == WL) ? 1'b1 : 1'b0;
    walk_right = (state == WR) ? 1'b1 : 1'b0;
  end

endmodule
