module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// State encoding
	typedef enum reg [1:0] {
		S0 = 2'b00, // Initial state
		S1 = 2'b01, // State after seeing '1'
		S2 = 2'b10  // State after seeing '10'
	} state_t;

	state_t state, next_state;

	// State transition
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			state <= S0;
		else
			state <= next_state;
		end

	// Next state logic
	always @(*) begin
		case (state)
			S0: begin
				if (x)
					next_state = S1; // Move to S1 on seeing '1'
				else
					next_state = S0; // Stay in S0
			end
			S1: begin
				if (x)
					next_state = S1; // Stay in S1 on seeing '1'
				else
					next_state = S2; // Move to S2 on seeing '0'
			end
			S2: begin
				if (x)
					next_state = S1; // Move to S1 on seeing '1'
				else
					next_state = S0; // Move to S0 on seeing '0'
			end
			default: next_state = S0;
		endcase
	end

	// Output logic
	always @(*) begin
		z = 1'b0;
		case (state)
			S0: z = 1'b0;
			S1: z = 1'b0;
			S2: if (x) z = 1'b1; // Assert z if the sequence '101' is detected
		endcase
	end

endmodule
