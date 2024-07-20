module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	// State encoding
	typedef enum logic [1:0] {
		S0, // Initial state
		S1, // State after first '1'
		S2  // State after '10'
	} state_t;
	
	state_t current_state, next_state;

	// State transition logic
	always @(*) begin
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
	always @(*) begin
		z = 0;
		case (current_state)
			S2: if (x) z = 1;
		endcase
	end

	// State register
	always @(negedge aresetn or posedge clk) begin
		if (!aresetn)
			current_state <= S0;
		else
			current_state <= next_state;
		end
endmodule
