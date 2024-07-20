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

	reg [1:0] state; // state variable

	always @(posedge clk or posedge areset)
	begin
		if (areset)
			state <= 2'b00;
		else
		begin
			case (state)
				2'b00: // walking left state
				begin
					if (ground == 1'b0)
						state <= 2'b10; // falling state
					else if (bump_right == 1'b1)
						state <= 2'b01; // walking right state
					else
						state <= 2'b00; // remain in walking left state
				end

				2'b01: // walking right state
				begin
					if (ground == 1'b0)
						state <= 2'b10; // falling state
					else if (bump_left == 1'b1)
						state <= 2'b00; // walking left state
					else
						state <= 2'b01; // remain in walking right state
				end

				2'b10: // falling state
				begin
					if (ground == 1'b1)
						state <= state[1:0]; // resume previous direction
					else
						state <= 2'b10; // remain in falling state
				end
			endcase
		end
	end

	always @(state)
	begin
		case (state)
			2'b00: // walking left output
			begin
				walk_left = 1'b1;
				walk_right = 1'b0;
				aaah = 1'b0;
			end

			2'b01: // walking right output
			begin
				walk_left = 1'b0;
				walk_right = 1'b1;
				aaah = 1'b0;
			end

			2'b10: // falling output
			begin
				walk_left = 1'b0;
				walk_right = 1'b0;
				aaah = 1'b1;
			end
		endcase
	end

endmodule
