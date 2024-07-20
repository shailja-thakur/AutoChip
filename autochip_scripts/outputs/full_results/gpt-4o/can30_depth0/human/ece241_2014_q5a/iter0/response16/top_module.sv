module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// State encoding
	typedef enum logic [1:0] {
		S0, // Initial State
		S1, // Invert bits
		S2  // Add 1 (Carry Propagation)
	} state_t;

	state_t state, next_state;
	reg carry;

	// State transition logic
	always_ff @(posedge clk, posedge areset) begin
		if (areset) begin
			state <= S0;
		end else begin
			state <= next_state;
		end
	end

	// Next state logic and output logic
	always_comb begin
		// Default values
		next_state = state;
		z = 0;

		case (state)
			S0: begin
				if (x)
					next_state = S1;  // If the input is 1
				else
					next_state = S2;  // If the input is 0
			end
			S1: begin
				z = ~x;  // Output is the inverted input
				next_state = S1;
			end
			S2: begin
				if (x) begin
					z = ~x;
					next_state = S1;  // Transition to S1 to handle carry
				end else begin
					z = ~x + carry;
					next_state = S2;  // Remain in S2 if no carry is generated
				end
			end
			default: next_state = S0;
		endcase
	end

	// Carry generation logic
	always_ff @(posedge clk or posedge areset) begin
		if (areset)
			carry <= 1'b1; // Start with carry 1 for 2's complement
		else if (state == S0)
			carry <= 1'b1; // Initialize carry for every new number
		else if (state == S1 && x == 1'b1)
			carry <= 1'b0; // Reset carry if 1 is encountered
	end

endmodule
