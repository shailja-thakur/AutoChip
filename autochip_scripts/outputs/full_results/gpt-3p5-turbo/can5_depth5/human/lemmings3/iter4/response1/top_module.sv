module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	input dig,
	output reg walk_left,
	output reg walk_right,
	output reg aaah,
	output reg digging
);

reg [1:0] state;
reg [1:0] next_state;

// Define states
parameter [1:0]
	IDLE = 2'b00,
	WALK_LEFT = 2'b01,
	WALK_RIGHT = 2'b10;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= IDLE;
		walk_left <= 1'b1;
		walk_right <= 1'b0;
		aaah <= 1'b0;
		digging <= 1'b0;
	end else begin
		state <= next_state;
		case (state)
			IDLE:
				if (bump_left) begin
					next_state = WALK_RIGHT;
					walk_right <= 1'b1;
				end else if (bump_right) begin
					next_state = WALK_LEFT;
					walk_left <= 1'b1;
				end else if (!ground && !dig) begin
					next_state = IDLE;
				end else if (!ground && dig) begin
					next_state = IDLE;
				end else begin
					next_state = IDLE;
				end
			WALK_LEFT:
				if (bump_right) begin
					next_state = WALK_RIGHT;
					walk_right <= 1'b1;
				end else if (!ground) begin
					next_state = IDLE;
					aaah <= 1'b1;
				end else if (dig) begin
					next_state = IDLE;
				end else begin
					next_state = WALK_LEFT;
					walk_left <= 1'b1;
				end
			WALK_RIGHT:
				if (bump_left) begin
					next_state = WALK_LEFT;
					walk_left <= 1'b1;
				end else if (!ground) begin
					next_state = IDLE;
					aaah <= 1'b1;
				end else if (dig) begin
					next_state = IDLE;
				end else begin
					next_state = WALK_RIGHT;
					walk_right <= 1'b1;
				end
		endcase
	end
end

endmodule
