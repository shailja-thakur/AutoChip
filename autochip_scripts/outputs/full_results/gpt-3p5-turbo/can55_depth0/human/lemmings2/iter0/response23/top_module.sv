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

parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;
parameter FALL = 2'b10;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= WALK_LEFT;
		walk_left <= 1'b1;
		walk_right <= 1'b0;
		aaah <= 1'b0;
	end else begin
		case (state)
			WALK_LEFT:
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
			
			WALK_RIGHT:
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
			
			FALL:
				if (ground) begin
					if (state == WALK_LEFT) begin
						state <= WALK_LEFT;
						walk_left <= 1'b1;
						walk_right <= 1'b0;
						aaah <= 1'b0;
					end else begin
						state <= WALK_RIGHT;
						walk_left <= 1'b0;
						walk_right <= 1'b1;
						aaah <= 1'b0;
					end
				end
		endcase
	end
end

endmodule
