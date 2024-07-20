module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	input dig,
	output walk_left,
	output walk_right,
	output aaah,
	output digging
);

	reg [4:0] state;

	// State assignments
	parameter [4:0]
		WALK_LEFT = 0,
		WALK_RIGHT = 1,
		FALL = 2,
		DIG = 3,
		SPLATTER = 4;
	
	// Outputs assignments
	assign walk_left = (state == WALK_LEFT);
	assign walk_right = (state == WALK_RIGHT || state == FALL);
	assign aaah = (state == FALL || state == SPLATTER);
	assign digging = (state == DIG);

	// Next state logic
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= WALK_LEFT;
		else begin
			case(state)
				WALK_LEFT: begin
					if (bump_right)
						state <= WALK_RIGHT;
					else if (!ground)
						state <= FALL;
					else if (dig)
						state <= DIG;
				end
				WALK_RIGHT: begin
					if (bump_left)
						state <= WALK_LEFT;
					else if (!ground)
						state <= FALL;
					else if (dig)
						state <= DIG;
				end
				FALL, SPLATTER: begin
					if (ground)
						state <= WALK_LEFT;
					else if (state == FALL && state_counter == 20)
						state <= SPLATTER;
					else if (state_counter < 20)
						state <= FALL;
				end
				DIG: begin
					if (!ground)
						state <= FALL;
					else if (dig)
						state <= DIG;
					else
						state <= WALK_LEFT;
				end
			endcase
		end
	end

endmodule
