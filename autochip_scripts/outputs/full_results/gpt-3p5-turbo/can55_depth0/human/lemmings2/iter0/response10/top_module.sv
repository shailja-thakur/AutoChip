module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	output walk_left,
	output walk_right,
	output aaah
);

reg [1:0] state;
reg walk_left;
reg walk_right;
reg aaah;

parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;
parameter FALLING = 2'b10;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= WALK_LEFT;
		walk_left <= 1'b1;
		walk_right <= 1'b0;
		aaah <= 1'b0;
	end else begin
		case(state)
			WALK_LEFT: begin
				if (bump_right) begin
					state <= WALK_RIGHT;
					walk_left <= 1'b0;
					walk_right <= 1'b1;
					aaah <= 1'b0;
				end else if (bump_left) begin
					state <= WALK_LEFT;
					walk_left <= 1'b1;
					walk_right <= 1'b0;
					aaah <= 1'b0;
				end else if (!ground) begin
					state <= FALLING;
					walk_left <= 1'b0;
					walk_right <= 1'b0;
					aaah <= 1'b1;
				end
			end
			
			WALK_RIGHT: begin
				if (bump_left) begin
					state <= WALK_LEFT;
					walk_left <= 1'b1;
					walk_right <= 1'b0;
					aaah <= 1'b0;
				end else if (bump_right) begin
					state <= WALK_RIGHT;
					walk_left <= 1'b0;
					walk_right <= 1'b1;
					aaah <= 1'b0;
				end else if (!ground) begin
					state <= FALLING;
					walk_left <= 1'b0;
					walk_right <= 1'b0;
					aaah <= 1'b1;
				end
			end
			
			FALLING: begin
				state <= WALK_LEFT;
				if (!ground) begin
					walk_left <= 1'b0;
					walk_right <= 1'b0;
					aaah <= 1'b1;
				end else begin
					walk_left <= 1'b1;
					walk_right <= 1'b0;
					aaah <= 1'b0;
				end
			end
			
			default: begin
				state <= WALK_LEFT;
				walk_left <= 1'b1;
				walk_right <= 1'b0;
				aaah <= 1'b0;
			end
		endcase
	end
end

endmodule
