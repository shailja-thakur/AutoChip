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
	parameter RESUME_WALK = 2'b11;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= WALK_LEFT;
			walk_left <= 1'b1;
			walk_right <= 1'b0;
			aaah <= 1'b0;
		end else begin
			case (state)
				WALK_LEFT: begin
					if (bump_right || (bump_left && bump_right))
						state <= WALK_RIGHT;
					else if (aaah)
						state <= FALL;
				end
				WALK_RIGHT: begin
					if (bump_left || (bump_left && bump_right))
						state <= WALK_LEFT;
					else if (aaah)
						state <= FALL;
				end
				FALL: begin
					if (ground)
						state <= RESUME_WALK;
				end
				RESUME_WALK: begin
					if (state == WALK_LEFT)
						state <= WALK_LEFT;
					else if (state == WALK_RIGHT)
						state <= WALK_RIGHT;
				end
			endcase
			
			case (state)
				WALK_LEFT: begin
					walk_left <= 1'b1;
					walk_right <= 1'b0;
					aaah <= 1'b0;
				end
				WALK_RIGHT: begin
					walk_left <= 1'b0;
					walk_right <= 1'b1;
					aaah <= 1'b0;
				end
				FALL: begin
					walk_left <= 1'b0;
					walk_right <= 1'b0;
					aaah <= 1'b1;
				end
				RESUME_WALK: begin
					walk_left <= 1'b1;
					walk_right <= 1'b0;
					aaah <= 1'b0;
				end
			endcase
		end
	end

endmodule
