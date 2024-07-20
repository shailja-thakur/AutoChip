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

	// Declare state variables
	reg [1:0] state;

	// Define states
	parameter [1:0] WALK_LEFT = 2'b00;
	parameter [1:0] WALK_RIGHT = 2'b01;
	parameter [1:0] FALLING = 2'b10;

	// Define default state
	initial begin
		state <= WALK_LEFT;
	end

	// Define state transitions and outputs
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= WALK_LEFT;
		end else begin
			case(state)
				WALK_LEFT: begin
					if (bump_left || (bump_left && bump_right))
						state <= WALK_RIGHT;
					else if (!ground)
						state <= FALLING;
					end
				WALK_RIGHT: begin
					if (bump_right || (bump_left && bump_right))
						state <= WALK_LEFT;
					else if (!ground)
						state <= FALLING;
				end
				FALLING: begin
					if (ground)
						state <= (state == WALK_LEFT) ? WALK_LEFT : WALK_RIGHT;
				end
			endcase
		end
	end

	// Define state outputs
	always @(state or ground) begin
		case(state)
			WALK_LEFT: begin
				walk_left <= 1;
				walk_right <= 0;
			end
			WALK_RIGHT: begin
				walk_left <= 0;
				walk_right <= 1;
			end
			FALLING: begin
				walk_left <= 0;
				walk_right <= 0;
			end
		endcase

		aaah <= (state == FALLING);
	end
endmodule
