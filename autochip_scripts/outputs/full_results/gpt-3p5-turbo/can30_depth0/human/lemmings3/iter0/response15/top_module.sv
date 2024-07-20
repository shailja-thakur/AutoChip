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

reg walk_left;
reg walk_right;
reg aaah;
reg digging;

enum {LEFT, RIGHT} state;
reg [1:0] next_state;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= LEFT;
	end else begin
		state <= next_state;
	end
end

always @(state or bump_left or bump_right or ground or dig) begin
	next_state = state;
	walk_left = 0;
	walk_right = 0;
	aaah = 0;
	digging = 0;
	
	case (state)
		LEFT:
			if (bump_left) begin
				next_state = RIGHT;
			end else begin
				if (dig && ground) begin
					next_state = LEFT;
					digging = 1;
				end else if (!ground) begin
					next_state = LEFT;
					aaah = 1;
				else begin
					next_state = LEFT;
					walk_left = 1;
				end
			end
		RIGHT:
			if (bump_right) begin
				next_state = LEFT;
			end else begin
				if (dig && ground) begin
					next_state = RIGHT;
					digging = 1;
				end else if (!ground) begin
					next_state = RIGHT;
					aaah = 1;
				else begin
					next_state = RIGHT;
					walk_right = 1;
				end
			end
	endcase
end

endmodule
