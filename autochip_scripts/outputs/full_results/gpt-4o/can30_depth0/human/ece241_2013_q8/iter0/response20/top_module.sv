module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// State encoding
	typedef enum logic [1:0] {
		S0 = 2'b00, // Initial state
		S1 = 2'b01, // State after detecting '1'
		S2 = 2'b10  // State after detecting '10'
	} state_t;
	
	state_t current_state, next_state;

	// State transition
	always_ff @(posedge clk or negedge aresetn) begin
		if (!aresetn) begin
			current_state <= S0;
		end else begin
			current_state <= next_state;
		end
	end

	// Next state logic
	always_comb begin
		case (current_state)
			S0: begin
				if (x)
					next_state = S1;
				else
					next_state = S0;
			end
			S1: begin
				if (x)
					next_state = S1;
				else
					next_state = S2;
			end
			S2: begin
				if (x)
					next_state = S1;
				else
					next_state = S0;
			end
			default: next_state = S0;
		endcase
	end

	// Output logic
	always_ff @(posedge clk or negedge aresetn) begin
		if (!aresetn) begin
			z <= 0;
		end else begin
			case (current_state)
				S0: z <= 0;
				S1: z <= 0;
				S2: z <= x; // Output z is 1 when current_state is S2 and input x is 1 (detects '101')
				default: z <= 0;
			endcase
		end
	end

endmodule
