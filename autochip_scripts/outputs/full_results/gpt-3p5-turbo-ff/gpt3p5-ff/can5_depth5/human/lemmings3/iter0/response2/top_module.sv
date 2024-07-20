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

reg [1:0] state;
reg walk_left;
reg walk_right;
reg aaah;
reg digging;

parameter IDLE = 2'b00;
parameter WALK_LEFT = 2'b01;
parameter WALK_RIGHT = 2'b10;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= IDLE;
		walk_left <= 1;
		walk_right <= 0;
		aaah <= 0;
		digging <= 0;
	end else begin
		case(state)
			IDLE:
				if (ground == 0) begin
					state <= WALK_LEFT;
					walk_left <= 1;
					walk_right <= 0;
					aaah <= 1;
					digging <= 0;
				end else if (bump_left == 1) begin
					state <= WALK_RIGHT;
					walk_left <= 0;
					walk_right <= 1;
					aaah <= 0;
					digging <= 0;
				end else if (dig == 1 && ground == 1) begin
					state <= IDLE;
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 0;
					digging <= 1;
				end
			WALK_LEFT:
				if (ground == 0) begin
					state <= WALK_LEFT;
					walk_left <= 1;
					walk_right <= 0;
					aaah <= 1;
					digging <= 0;
				end else if (bump_left == 1) begin
					state <= WALK_RIGHT;
					walk_left <= 0;
					walk_right <= 1;
					aaah <= 0;
					digging <= 0;
				end else if (bump_right == 1) begin
					state <= WALK_RIGHT;
					walk_left <= 0;
					walk_right <= 1;
					aaah <= 0;
					digging <= 0;
				end else if (dig == 1 && ground == 1) begin
					state <= IDLE;
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 0;
					digging <= 1;
				end
			WALK_RIGHT:
				if (ground == 0) begin
					state <= WALK_RIGHT;
					walk_left <= 0;
					walk_right <= 1;
					aaah <= 1;
					digging <= 0;
				end else if (bump_right == 1) begin
					state <= WALK_LEFT;
					walk_left <= 1;
					walk_right <= 0;
					aaah <= 0;
					digging <= 0;
				end else if (bump_left == 1) begin
					state <= WALK_LEFT;
					walk_left <= 1;
					walk_right <= 0;
					aaah <= 0;
					digging <= 0;
				end else if (dig == 1 && ground == 1) begin
					state <= IDLE;
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 0;
					digging <= 1;
				end
		endcase
	end
end

endmodule
