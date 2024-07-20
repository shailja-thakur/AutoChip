module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	input dig,
	output walk_left,
	output walk_right,
	output aaah,
	output digging
);

reg [4:0] state;
// Define constants for the states
parameter walking_left = 4'b00001;
parameter walking_right = 4'b00010;
parameter falling = 4'b00100;
parameter digging_state = 4'b01000;
parameter splatter = 4'b10000;

// Define the outputs
assign walk_left = (state == walking_left) ? 1 : 0;
assign walk_right = (state == walking_right) ? 1 : 0;
assign aaah = (state == falling || state == splatter) ? 1 : 0;
assign digging = (state == digging_state) ? 1 : 0;

// Define the next state logic
always @(posedge clk or posedge areset) begin
  if (areset) begin
    state <= walking_left;
  end else begin
    case (state)
      walking_left: begin
        if (bump_right) begin
          state <= walking_right;
        end else if (ground == 0) begin
          state <= falling;
        end else if (dig) begin
          state <= digging_state;
        end
      end
      walking_right: begin
        if (bump_left) begin
          state <= walking_left;
        end else if (ground == 0) begin
          state <= falling;
        end else if (dig) begin
          state <= digging_state;
        end
      end
      falling: begin
        if (ground == 1) begin
          state <= (bump_left || bump_right) ? walking_left : state;
        end else if (state[4]) begin
          state <= splatter;
        end
      end
      digging_state: begin
        if (!ground || state[4]) begin
          state <= falling;
        end
      end
      default: state <= walking_left;
    endcase
  end
end

endmodule
