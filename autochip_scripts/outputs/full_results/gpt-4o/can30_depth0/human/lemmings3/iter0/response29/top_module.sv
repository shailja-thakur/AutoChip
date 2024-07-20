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

	reg [2:0] state, next_state;

	// State encoding
	localparam LEFT        = 3'b000;
	localparam RIGHT       = 3'b001;
	localparam FALL_LEFT   = 3'b010;
	localparam FALL_RIGHT  = 3'b011;
	localparam DIG_LEFT    = 3'b100;
	localparam DIG_RIGHT   = 3'b101;

	// State transition
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= LEFT; // On reset, start walking left
		else
			state <= next_state;
	end

	always @(*) begin
		case (state)
			LEFT: begin
				if (!ground)
					next_state = FALL_LEFT;
				else if (dig)
					next_state = DIG_LEFT;
				else if (bump_left)
					next_state = RIGHT;
				else
					next_state = LEFT;
			end

			RIGHT: begin
				if (!ground)
					next_state = FALL_RIGHT;
				else if (dig)
					next_state = DIG_RIGHT;
				else if (bump_right)
					next_state = LEFT;
				else
					next_state = RIGHT;
			end

			FALL_LEFT: begin
				if (ground)
					next_state = LEFT;
				else
					next_state = FALL_LEFT;
			end

			FALL_RIGHT: begin
				if (ground)
					next_state = RIGHT;
				else
					next_state = FALL_RIGHT;
			end

			DIG_LEFT: begin
				if (!ground)
					next_state = FALL_LEFT;
				else
					next_state = DIG_LEFT;
			end

			DIG_RIGHT: begin
				if (!ground)
					next_state = FALL_RIGHT;
				else
					next_state = DIG_RIGHT;
			end

			default: next_state = LEFT; // Default state
		endcase
	end

	assign walk_left = (state == LEFT);
	assign walk_right = (state == RIGHT);
	assign aaah = (state == FALL_LEFT) || (state == FALL_RIGHT);
	assign digging = (state == DIG_LEFT) || (state == DIG_RIGHT);

endmodule
