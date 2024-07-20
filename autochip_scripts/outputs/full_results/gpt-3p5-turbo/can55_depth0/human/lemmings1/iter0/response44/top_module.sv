module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);

	reg [1:0] state;
	reg walk_left;
	reg walk_right;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b00; // Reset to walk left state
			walk_left <= 1;
			walk_right <= 0;
		end else begin
			case(state)
				2'b00: begin
					// State = Walking left
					if (bump_right == 1 && bump_left == 0)
						state <= 2'b01; // Switch to walking right state
				end
				2'b01: begin
					// State = Walking right
					if (bump_left == 1 && bump_right == 0)
						state <= 2'b00; // Switch to walking left state
				end
			endcase
		end
	end

	always @(state) begin
		case (state)
			2'b00: begin
				// Walking left state
				walk_left <= 1;
				walk_right <= 0;
			end
			2'b01: begin
				// Walking right state
				walk_left <= 0;
				walk_right <= 1;
			end
		endcase
	end

endmodule
