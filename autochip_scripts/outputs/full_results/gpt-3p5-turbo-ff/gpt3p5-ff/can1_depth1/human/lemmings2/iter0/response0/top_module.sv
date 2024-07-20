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

	reg state; // 0 is walk_left, 1 is walk_right, 2 is fall

	always @(posedge clk, posedge areset) begin
		if (areset) begin // Reset to walk_left
			state <= 0;
		end else begin
			case (state)
				0: begin // walk_left
					if (bump_right) begin
						state <= 1; // Change to walk_right
					end else if (~ground) begin
						state <= 2; // Change to fall
					end
				end
				1: begin // walk_right
					if (bump_left) begin
						state <= 0; // Change to walk_left
					end else if (~ground) begin
						state <= 2; // Change to fall
					end
				end
				2: begin // fall
					if (ground) begin
						if (state == 0) begin
							state <= 0; // Set back to walk_left
						end else if (state == 1) begin
							state <= 1; // Set back to walk_right
						end
					end
				end
			endcase
		end
	end

	always @(state) begin
		case (state)
			0: begin // walk_left
				walk_left = 1;
				walk_right = 0;
				aaah = 0;
			end
			1: begin // walk_right
				walk_left = 0;
				walk_right = 1;
				aaah = 0;
			end
			2: begin // fall
				walk_left = 0;
				walk_right = 0;
				aaah = 1;
			end
		endcase
	end

endmodule
