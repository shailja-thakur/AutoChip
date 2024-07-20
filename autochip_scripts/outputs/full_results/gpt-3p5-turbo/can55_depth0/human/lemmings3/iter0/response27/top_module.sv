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
	// Define the states
	typedef enum logic [1:0] {
		WALK_LEFT,
		WALK_RIGHT,
		FALL,
		DIG
	} state_t;
	
	// Define the state register and next state
	reg [1:0] state_reg, state_next;
	
	// Define the outputs
	assign aaah = (state_reg == FALL);
	assign digging = (state_reg == DIG);
	
	// Define the state transition logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state_reg <= WALK_LEFT;  // Reset to initial state: walk_left
		end else begin
			state_reg <= state_next;  // Update the state using the next state
		end
	end
	
	// Define the state and output logic
	always @(state_reg or bump_left or bump_right or ground or dig) begin
		case (state_reg)
			WALK_LEFT: begin
				if (bump_right || (bump_left && bump_right))
					state_next = WALK_RIGHT;
				else if (!ground)
					state_next = FALL;
				else if (dig)
					state_next = DIG;
				else
					state_next = state_reg;
			end
			WALK_RIGHT: begin
				if (bump_left || (bump_left && bump_right))
					state_next = WALK_LEFT;
				else if (!ground)
					state_next = FALL;
				else if (dig)
					state_next = DIG;
				else
					state_next = state_reg;
			end
			FALL: begin
				if (ground)
					state_next = state_reg;
				else
					state_next = FALL;
			end
			DIG: begin
				if (ground)
					state_next = state_reg;
				else
					state_next = FALL;
			end
			default: state_next = state_reg;
		endcase
	end
	
	// Define the output logic
	always @(state_reg) begin
		case (state_reg)
			WALK_LEFT: begin
				walk_left = 1;
				walk_right = 0;
			end
			WALK_RIGHT: begin
				walk_left = 0;
				walk_right = 1;
			end
			FALL, DIG: begin
				walk_left = 0;
				walk_right = 0;
			end
			default: begin
				walk_left = 0;
				walk_right = 0;
			end
		endcase
	end
	
endmodule
