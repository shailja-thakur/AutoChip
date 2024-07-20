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
			state <= 2'b10; // initial state, walking left
		end else begin
			case (state)
				2'b10: // walking left state
					begin
						if (bump_right) begin
							state <= 2'b01; // switch to walking right state
						end
					end
				2'b01: // walking right state
					begin
						if (bump_left) begin
							state <= 2'b10; // switch to walking left state
						end
					end
			endcase
		end
	end

	always @(state) begin
		case (state)
			2'b10: // walking left state
				begin
					walk_left = 1;
					walk_right = 0;
				end
			2'b01: // walking right state
				begin
					walk_left = 0;
					walk_right = 1;
				end
		endcase
	end

endmodule
