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
	
	// State declaration
	enum {LEFT, RIGHT, FALL, DIG} state;

	// Next state logic
	always @(posedge clk, negedge areset) begin
		if (areset) begin
			state <= LEFT;
		end
		else begin
			case(state)
				LEFT: begin
					if (bump_right && !bump_left)
						state <= RIGHT;
					else if (ground == 0)
						state <= FALL;
					else if (dig)
						state <= DIG;
				end
				RIGHT: begin
					if (bump_left && !bump_right)
						state <= LEFT;
					else if (ground == 0)
						state <= FALL;
					else if (dig)
						state <= DIG;
				end
				FALL: begin
					if (ground)
						state <= state == LEFT ? RIGHT : LEFT;
				end
				DIG: begin
					if (!ground)
						state <= FALL;
				end
			endcase
		end
	end
	
	// Output logic
	always @(state) begin
		case(state)
			LEFT: begin
				walk_left = 1;
				walk_right = 0;
				aaah = 0;
				digging = 0;
			end
			RIGHT: begin
				walk_left = 0;
				walk_right = 1;
				aaah = 0;
				digging = 0;
			end
			FALL: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 1;
				digging = 0;
			end
			DIG: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 0;
				digging = 1;
			end
		endcase
	end

endmodule
