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

	// State encoding
	parameter WALK_LEFT = 2'b00;
	parameter WALK_RIGHT = 2'b01;
	parameter FALL = 2'b10;

	// Output assignments
	assign walk_left = (state == WALK_LEFT);
	assign walk_right = (state == WALK_RIGHT);

	// State transitions and output assignments
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= WALK_LEFT;
			aaah <= 0;
		end else begin
			case(state)
				WALK_LEFT: begin
					if (bump_right) begin
						state <= WALK_RIGHT;
					end else if (ground == 0) begin
						state <= FALL;
						aaah <= 1;
					end
				end

				WALK_RIGHT: begin
					if (bump_left) begin
						state <= WALK_LEFT;
					end else if (ground == 0) begin
						state <= FALL;
						aaah <= 1;
					end
				end

				FALL: begin
					if (ground == 1) begin
						if (state == WALK_LEFT) begin
							walk_left <= 1;
						end else if (state == WALK_RIGHT) begin
							walk_right <= 1;
						end
						state <= (bump_left || bump_right) ? WALK_LEFT : WALK_RIGHT;
						aaah <= 0;
					end
				end
			endcase
		end
	end
endmodule
