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
	// Define the states for the finite state machine
	enum {WALK_LEFT, WALK_RIGHT, FALL, DIG, SPLATTER} state, next_state;
	reg [4:0] timer;
	
	// Initialize the outputs
	assign walk_left = (state == WALK_LEFT);
	assign walk_right = (state == WALK_RIGHT);
	assign aaah = (state == FALL);
	assign digging = (state == DIG);
	
	// Define the state transitions
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= WALK_LEFT;
		else
			state <= next_state;
	end
	
	// Define the next state logic
	always @* begin
		case (state)
			WALK_LEFT: begin
				if (bump_right)
					next_state = WALK_RIGHT;
				else if (!ground)
					next_state = FALL;
				else if (dig)
					next_state = DIG;
				else
					next_state = WALK_LEFT;
			end
			WALK_RIGHT: begin
				if (bump_left)
					next_state = WALK_LEFT;
				else if (!ground)
					next_state = FALL;
				else if (dig)
					next_state = DIG;
				else
					next_state = WALK_RIGHT;
			end
			FALL: begin
				if (ground)
					next_state = WALK_LEFT;
				else if (timer == 20)
					next_state = SPLATTER;
				else
					next_state = FALL;
			end
			DIG: begin
				if (!ground)
					next_state = FALL;
				else
					next_state = DIG;
			end
			SPLATTER: begin
				// Stay in the splatter state forever
				next_state = SPLATTER;
			end
		endcase
	end
	
	// Define the timer logic
	always @(posedge clk or posedge areset) begin
		if (areset || state != FALL)
			timer <= 0;
		else if (!ground)
			timer <= timer + 1;
	end
endmodule
