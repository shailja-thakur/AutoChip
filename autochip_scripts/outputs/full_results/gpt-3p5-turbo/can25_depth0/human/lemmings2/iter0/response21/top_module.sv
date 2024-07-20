module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	output reg walk_left,
	output reg walk_right,
	output reg aaah
);

reg [1:0] state;

parameter S_WALK_LEFT = 2'b00;
parameter S_WALK_RIGHT = 2'b01;
parameter S_FALL = 2'b10;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= S_WALK_LEFT;
		walk_left <= 1;
		walk_right <= 0;
		aaah <= 0;
	end else begin
		case (state)
			S_WALK_LEFT: begin
				if (bump_right) begin
					state <= S_WALK_RIGHT;
					walk_left <= 0;
					walk_right <= 1;
					aaah <= 0;
				end else if (ground == 0) begin
					state <= S_FALL;
					walk_left <= 1;
					walk_right <= 0;
					aaah <= 1;
				end
			end
			S_WALK_RIGHT: begin
				if (bump_left) begin
					state <= S_WALK_LEFT;
					walk_left <= 1;
					walk_right <= 0;
					aaah <= 0;
				end else if (ground == 0) begin
					state <= S_FALL;
					walk_left <= 0;
					walk_right <= 1;
					aaah <= 1;
				end
			end
			S_FALL: begin
				if (ground == 1) begin
					state <= walk_left ? S_WALK_LEFT : S_WALK_RIGHT;
					walk_left <= state == S_WALK_LEFT ? 1 : 0;
					walk_right <= state == S_WALK_RIGHT ? 1 : 0;
					aaah <= 0;
				end
			end
		endcase
	end
end

endmodule
