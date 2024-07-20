module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);

  reg [1:0] state;
  reg walk_left;
  reg walk_right;
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= 2'b01; // start in walk_right state
      walk_left <= 0;
      walk_right <= 1;
    end else begin
      case (state)
        2'b00: // current state is walk_left
          if (bump_left && !bump_right) begin
            state <= 2'b01; // switch to walk_right state
            walk_left <= 0;
            walk_right <= 1;
          end else if (!bump_left && bump_right) begin
            state <= 2'b00; // stay in walk_left state
            walk_left <= 1;
            walk_right <= 0;
          end else if (bump_left && bump_right) begin
            state <= 2'b01; // switch to walk_right state
            walk_left <= 0;
            walk_right <= 1;
          end
        2'b01: // current state is walk_right
          if (!bump_left && bump_right) begin
            state <= 2'b00; // switch to walk_left state
            walk_left <= 1;
            walk_right <= 0;
          end else if (bump_left && !bump_right) begin
            state <= 2'b01; // stay in walk_right state
            walk_left <= 0;
            walk_right <= 1;
          end else if (bump_left && bump_right) begin
            state <= 2'b00; // switch to walk_left state
            walk_left <= 1;
            walk_right <= 0;
          end
      endcase
    end
  end

endmodule
