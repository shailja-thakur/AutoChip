module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	typedef enum logic [1:0] {
		S0 = 2'b00,  // Initial state
		S1 = 2'b01,  // Inverting bits
		S2 = 2'b10   // Adding 1
	} state_t;

	state_t state, next_state;

	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= S0;
			z <= 1'b0;
		end else begin
			state <= next_state;
		end
	end

	always_comb begin
		next_state = state;
		case (state)
			S0: begin
				z = x; // Pass through the input when in initial state
				if (~areset) begin
					next_state = S1;
				end
			end
			S1: begin
				z = ~x; // Invert the input bits
				next_state = S1;  // Continue inverting until areset is asserted
				if (x == 1'b1) begin
					next_state = S2; // Move to next state for adding 1 only when we get first '1'
				end
			end
			S2: begin
				z = ~x + 1'b1; // Add 1 to the LSB
				next_state = S2; // Remain in S2 till we get areset
			end
		endcase
	end

endmodule
