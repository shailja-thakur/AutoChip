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

parameter [1:0] WALK_LEFT = 2'b00;
parameter [1:0] WALK_RIGHT = 2'b01;
parameter [1:0] FALL = 2'b10;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= WALK_LEFT;
		walk_left <= 1'b1;
		walk_right <= 1'b0;
		aaah <= 1'b0;
	end else begin
		case(state)
			WALK_LEFT: begin
				if (bump_right && !bump_left) begin
					state <= WALK_RIGHT;
					walk_left <= 1'b0;
					walk_right <= 1'b1;
					aaah <= 1'b0;
				end else if (!ground) begin
					state <= FALL;
					walk_left <= 1'b0;
					walk_right <= 1'b0;
					aaah <= 1'b1;
				end
			end
			WALK_RIGHT: begin
				if (bump_left && !bump_right) begin
					state <= WALK_LEFT;
					walk_left <= 1'b1;
					walk_right <= 1'b0;
					aaah <= 1'b0;
				end else if (!ground) begin
					state <= FALL;
					walk_left <= 1'b0;
					walk_right <= 1'b0;
					aaah <= 1'b1;
				end
			end
			FALL: begin
				if (ground) begin
					if (state == WALK_LEFT) begin
						state <= WALK_LEFT;
						walk_left <= 1'b1;
						walk_right <= 1'b0;
						aaah <= 1'b0;
					end else if (state == WALK_RIGHT) begin
						state <= WALK_RIGHT;
						walk_left <= 1'b0;
						walk_right <= 1'b1;
						aaah <= 1'b0;
					end
				end
			end
		endcase
	end
end

endmodule
