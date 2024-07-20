module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);
  
  // parameter defines the two states of the state machine
  parameter WL = 0;
  parameter WR = 1;
  
  // register to store the current state of the state machine
  reg state;
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= WL; // reset the state machine to the initial state
    end else begin
      if (state == WL) begin
        if (bump_left) begin
          state <= WR; // transition to WR state if bump_left is high
        end else begin
          state <= WL; // stay in WL state if bump_left is low
        end
      end else begin
        if (bump_right) begin
          state <= WL; // transition to WL state if bump_right is high
        end else begin
          state <= WR; // stay in WR state if bump_right is low
        end
      end
    end
  end
  
  // assign outputs based on the current state of the state machine
  assign walk_left = (state == WL) ? 1'b1 : 1'b0;
  assign walk_right = (state == WR) ? 1'b1 : 1'b0;
  
endmodule
