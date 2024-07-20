module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	input dig,
	output reg walk_left,
	output reg walk_right,
	output reg aaah,
	output reg digging
);

reg [4:0] state;

parameter FALL_LIMIT = 20;

always @(posedge clk or posedge areset)
begin

	if (areset)
	begin
		state <= 5'b00000;
		walk_left <= 1;
		walk_right <= 0;
		aaah <= 0;
		digging <= 0;
	end
	else
	begin
		case (state)

			5'b00000: // Walking left
			begin
				if (bump_right)
					state <= 5'b00001; // Switching direction
				else if (!ground)
					state <= 5'b00010; // Falling
				else if (dig)
					state <= 5'b00011; // Digging
				else 
					state <= 5'b00000; // Continue walking
			end

			5'b00001: // Switching direction
			begin
				if (bump_right && bump_left)
					state <= 5'b00001; // Still switching direction
				else if (!bump_right && !bump_left)
					state <= 5'b00000; // Finished switching direction, start walking left
				else if (bump_right)
					state <= 5'b00010; // Start falling to the right
				else if (bump_left)
					state <= 5'b00010; // Start falling to the left
			end

			5'b00010: // Falling
			begin
				if (!ground)
					state <= 5'b00010; // Keep falling
				else
					state <= 5'b00000; // Hit the ground, start walking left again
			end

			5'b00011: // Digging
			begin
				if (!ground)
					state <= 5'b00010; // Start falling
				else if (!dig)
					state <= 5'b00000; // Stop digging, start walking left again
				else
					state <= 5'b00011; // Keep digging
			end

			default: state <= 5'b00000;

		endcase

		case (state)

			5'b00000: // Walking left
			begin
				walk_left <= 1;
				walk_right <= 0;
				aaah <= 0;
				digging <= 0;
			end

			5'b00001: // Switching direction
			begin
				walk_left <= 0;
				walk_right <= 1;
				aaah <= 0;
				digging <= 0;
			end

			5'b00010: // Falling
			begin
				walk_left <= 0;
				walk_right <= 0;
				aaah <= 1;
				digging <= 0;
			end

			5'b00011: // Digging
			begin
				walk_left <= 0;
				walk_right <= 0;
				aaah <= 0;
				digging <= 1;
			end

			default: // Default state
			begin
				walk_left <= 1;
				walk_right <= 0;
				aaah <= 0;
				digging <= 0;
			end

		endcase
	end
end

endmodule
