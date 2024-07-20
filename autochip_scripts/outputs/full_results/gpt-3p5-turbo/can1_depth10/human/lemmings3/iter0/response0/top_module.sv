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

// State definitions
parameter S_IDLE = 2'b00;
parameter S_WALK_LEFT = 2'b01;
parameter S_WALK_RIGHT = 2'b10;

// Output definitions
assign walk_left = (state == S_WALK_LEFT);
assign walk_right = (state == S_WALK_RIGHT);
assign aaah = (state == S_FALL);
assign digging = dig;

// Define the state register
reg [1:0] state;

// Define the next state logic
always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= S_WALK_LEFT;
	end else begin
		case (state)
			S_IDLE:
				if (ground) begin
					if (bump_left || bump_right) begin
						state <= S_WALK_RIGHT;
					end else if (dig) begin
						state <= S_WALK_LEFT;
					end else begin
						state <= S_IDLE;
					end
				end else if (dig) begin
					state <= S_WALK_LEFT;
				end else begin
					state <= S_IDLE;
				end
			S_WALK_LEFT:
				if (bump_right) begin
					state <= S_WALK_RIGHT;
				end else if (!ground) begin
					state <= S_FALL;
				end else if (dig) begin
					state <= S_WALK_LEFT;
				end else begin
					state <= S_IDLE;
				end
			S_WALK_RIGHT:
				if (bump_left) begin
					state <= S_WALK_LEFT;
				end else if (!ground) begin
					state <= S_FALL;
				end else if (dig) begin
					state <= S_WALK_RIGHT;
				end else begin
					state <= S_IDLE;
				end
			S_FALL:
				if (ground) begin
					if (bump_left || bump_right) begin
						state <= S_WALK_RIGHT;
					end else if (dig) begin
						state <= S_WALK_LEFT;
					end else begin
						state <= S_IDLE;
					end
				end else if (dig) begin
					state <= S_WALK_LEFT;
				end else begin
					state <= S_FALL;
				end
		endcase
	end
end

endmodule
