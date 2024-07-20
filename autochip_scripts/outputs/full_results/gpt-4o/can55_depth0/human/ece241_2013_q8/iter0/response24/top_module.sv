module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// State encoding
	typedef enum reg [1:0] {
		S0 = 2'b00,  // Initial state
		S1 = 2'b01,  // State after receiving '1'
		S2 = 2'b10   // State after receiving '10'
	} state_t;

	wire neg_edge_resetn = ~aresetn;
	state_t state, next_state;

	// Update state on the negative edge of clk or aresetn
	always @(negedge clk or posedge neg_edge_resetn) begin
		if (neg_edge_resetn) begin
			state <= S0;
		end else begin
			state <= next_state;
		end
	end

	// Compute next state and output based on current state and input
	always @(*) begin
		next_state = state; // Default to holding state unless matched
		z = 1'b0;           // Default output is 0

		case (state)
			S0: begin
				if (x) begin
					next_state = S1;
				end
			end
			S1: begin
				if (~x) begin
					next_state = S2;
				end else begin
					next_state = S1; // Stay in S1 on '1'
				end
			end
			S2: begin
				if (x) begin
					next_state = S1;
					z = 1'b1; // Sequence '101' detected
				end else begin
					next_state = S0; // No match, reset to initial state
				end
			end
		endcase
	end
endmodule
