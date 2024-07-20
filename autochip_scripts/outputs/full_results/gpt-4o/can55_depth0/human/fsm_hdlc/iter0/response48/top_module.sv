module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

	// State encoding
	typedef enum reg [2:0] {
		S0, // Initial state (previous input is 0)
		S1, // Saw 1
		S11, // Saw 11
		S111, // Saw 111
		S1111, // Saw 1111
		S11111, // Saw 11111
		S111110, // Saw 111110 (Signal disc needs to be discarded)
		S111111, // Saw 111111 (Waiting to check for the 7th 1 for error)
		ERROR, // Error state
		FLAG // Flag state
	} state_t;

	state_t state, next_state;

	// Sequential logic (state transitions)
	always @(posedge clk) begin
		if (reset) begin
			state <= S0;
		end else begin
			state <= next_state;
		end
	end

	// Combinational logic (next state logic)
	always @(*) begin
		// Default assignments
		next_state = state;
		disc = 0;
		flag = 0;
		err = 0;

		case (state)
			S0: begin
				if (in) next_state = S1;
			end
			S1: begin
				if (in) next_state = S11;
				else next_state = S0;
			end
			S11: begin
				if (in) next_state = S111;
				else next_state = S0;
			end
			S111: begin
				if (in) next_state = S1111;
				else next_state = S0;
			end
			S1111: begin
				if (in) next_state = S11111;
				else next_state = S0;
			end
			S11111: begin
				if (in) next_state = S111111;
				else next_state = S111110;
			end
			S111110: begin
				disc = 1; // Discard bit
				next_state = S0;
			end
			S111111: begin
				if (in) next_state = ERROR;
				else next_state = FLAG;
			end
			FLAG: begin
				flag = 1; // Flag state
				next_state = S0;
			end
			ERROR: begin
				err = 1; // Error state
				next_state = ERROR; // Stay in error until reset
			end
			default: next_state = S0;
		endcase
	end
endmodule
