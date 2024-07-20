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

	// State encoding
	typedef enum logic [2:0] {
		LEFT = 3'b000,
		RIGHT = 3'b001,
		FALL_LEFT = 3'b010,
		FALL_RIGHT = 3'b011,
		DIG_LEFT = 3'b100,
		DIG_RIGHT = 3'b101,
		SPLATTER = 3'b110
	} state_t;
	
	state_t state, next_state;
	logic [4:0] fall_counter;

	// Output logic
	assign walk_left = (state == LEFT);
	assign walk_right = (state == RIGHT);
	assign aaah = (state == FALL_LEFT) || (state == FALL_RIGHT);
	assign digging = (state == DIG_LEFT) || (state == DIG_RIGHT);

	// State transition logic
	always @(*) begin
		next_state = state; // Default state stays the same
		case (state)
			LEFT: begin
				if (!ground) next_state = FALL_LEFT;
				else if (dig) next_state = DIG_LEFT;
				else if (bump_left || bump_right) next_state = RIGHT;
			end
			RIGHT: begin
				if (!ground) next_state = FALL_RIGHT;
				else if (dig) next_state = DIG_RIGHT;
				else if (bump_left || bump_right) next_state = LEFT;
			end
			FALL_LEFT, FALL_RIGHT: begin
				if (ground) next_state = (state == FALL_LEFT) ? LEFT : RIGHT;
			end
			DIG_LEFT, DIG_RIGHT: begin
				if (!ground) next_state = (state == DIG_LEFT) ? FALL_LEFT : FALL_RIGHT;
			end
			SPLATTER: begin
				// Remain in SPLATTER state forever
			end
		endcase
	end

	// Fall counter logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			fall_counter <= 0;
		end else if (state == FALL_LEFT || state == FALL_RIGHT) begin
			if (ground) fall_counter <= 0;
			else if (fall_counter == 20) fall_counter <= fall_counter;
			else fall_counter <= fall_counter + 1;
		end else begin
			fall_counter <= 0;
		end
	end

	// State register
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= LEFT;
		end else if (fall_counter == 21) begin
			state <= SPLATTER;
		end else begin
			state <= next_state;
		end
	end

endmodule
