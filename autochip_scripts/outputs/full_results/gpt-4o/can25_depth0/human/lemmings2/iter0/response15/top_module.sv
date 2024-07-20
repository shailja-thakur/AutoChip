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

	reg [1:0] state, next_state;
	
	parameter LEFT = 2'b00, RIGHT = 2'b01, FALLING_LEFT = 2'b10, FALLING_RIGHT = 2'b11;

	always @ (posedge clk or posedge areset) begin
		if (areset)
			state <= LEFT;
		else
			state <= next_state;
	end

	always @ (*) begin
		case (state)
			LEFT: begin
				if (!ground)
					next_state = FALLING_LEFT;
				else if (bump_left)
					next_state = RIGHT;
				else
					next_state = LEFT;
			end
			RIGHT: begin
				if (!ground)
					next_state = FALLING_RIGHT;
				else if (bump_right)
					next_state = LEFT;
				else
					next_state = RIGHT;
			end
			FALLING_LEFT: begin
				if (ground)
					next_state = LEFT;
				else
					next_state = FALLING_LEFT;
			end
			FALLING_RIGHT: begin
				if (ground)
					next_state = RIGHT;
				else
					next_state = FALLING_RIGHT;
			end
			default: next_state = LEFT;
		endcase
	end

	assign walk_left = (state == LEFT);
	assign walk_right = (state == RIGHT);
	assign aaah = (state == FALLING_LEFT) || (state == FALLING_RIGHT);
	
endmodule
