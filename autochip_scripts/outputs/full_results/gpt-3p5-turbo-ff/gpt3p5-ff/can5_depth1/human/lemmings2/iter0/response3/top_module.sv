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

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 0;
			walk_left <= 1;
			walk_right <= 0;
			aaah <= 0;
		end else begin
			case (state)
				0: begin // walking left
					if (bump_left && !bump_right && !ground) begin
						state <= 1; // switch to walking right
						walk_left <= 0;
						walk_right <= 1;
						aaah <= 0;
					end else if (bump_left && bump_right && !ground) begin
						state <= 1; // switch to walking right
						walk_left <= 0;
						walk_right <= 1;
						aaah <= 0;
					end else if (!bump_left && !bump_right && !ground) begin
						state <= 2; // fall
						walk_left <= 0;
						walk_right <= 0;
						aaah <= 1;
					end
				end
				1: begin // walking right
					if (!bump_left && bump_right && !ground) begin
						state <= 0; // switch to walking left
						walk_left <= 1;
						walk_right <= 0;
						aaah <= 0;
					end else if (bump_left && bump_right && !ground) begin
						state <= 0; // switch to walking left
						walk_left <= 1;
						walk_right <= 0;
						aaah <= 0;
					end else if (!bump_left && !bump_right && !ground) begin
						state <= 2; // fall
						walk_left <= 0;
						walk_right <= 0;
						aaah <= 1;
					end
				end
				2: begin // falling
					if (ground) begin
						state <= 0; // resume walking in same direction
						if (walk_left) begin
							walk_left <= 1;
							walk_right <= 0;
							aaah <= 0;
						end else begin
							walk_left <= 0;
							walk_right <= 1;
							aaah <= 0;
						end
					end
				end
			endcase
		end
	end

endmodule
