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
reg fall;
reg next_fall;

parameter [1:0]
	IDLE = 2'b00,
	LEFT = 2'b01,
	RIGHT = 2'b10;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= IDLE;
		walk_left <= 1'b0;
		walk_right <= 1'b1;
		aaah <= 1'b0;
		digging <= 1'b0;
		fall <= 1'b0;
	end else begin
		state <= next_state;
		walk_left <= walk_left;
		walk_right <= walk_right;
		aaah <= aaah;
		digging <= digging;
		fall <= next_fall;
	end
end

always @* begin
	next_state = state;
	next_fall = fall;

	case (state)
		IDLE:
			if (bump_left) begin
				next_state = RIGHT;
				walk_left = 1'b0;
				walk_right = 1'b1;
				aaah = 1'b0;
				digging = 1'b0;
			end else if (bump_right) begin
				next_state = LEFT;
				walk_left = 1'b1;
				walk_right = 1'b0;
				aaah = 1'b0;
				digging = 1'b0;
			end else if (!ground) begin
				next_state = IDLE;
				walk_left = walk_left;
				walk_right = walk_right;
				aaah = 1'b1;
				digging = 1'b0;
			end else if (dig) begin
				next_state = IDLE;
				walk_left = walk_left;
				walk_right = walk_right;
				aaah = aaah;
				digging = 1'b1;
			end
		LEFT:
			if (!ground) begin
				next_state = IDLE;
				walk_left = walk_left;
				walk_right = walk_right;
				aaah = 1'b1;
				digging = 1'b0;
				next_fall = 1'b1;
			end else if (bump_right) begin
				next_state = RIGHT;
				walk_left = 1'b0;
				walk_right = 1'b1;
				aaah = aaah;
				digging = 1'b0;
			end else if (dig) begin
				next_state = IDLE;
				walk_left = walk_left;
				walk_right = walk_right;
				aaah = aaah;
				digging = 1'b1;
			end
		RIGHT:
			if (!ground) begin
				next_state = IDLE;
				walk_left = walk_left;
				walk_right = walk_right;
				aaah = 1'b1;
				digging = 1'b0;
				next_fall = 1'b1;
			end else if (bump_left) begin
				next_state = LEFT;
				walk_left = 1'b1;
				walk_right = 1'b0;
				aaah = aaah;
				digging = 1'b0;
			end else if (dig) begin
				next_state = IDLE;
				walk_left = walk_left;
				walk_right = walk_right;
				aaah = aaah;
				digging = 1'b1;
			end
	endcase
end

endmodule
