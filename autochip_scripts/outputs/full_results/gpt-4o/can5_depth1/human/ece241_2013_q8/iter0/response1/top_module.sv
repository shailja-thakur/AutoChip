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

	// Sequential logic for state transition
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			state <= S0;
		else
			state <= next_state;
	end

	// Combinational logic for next state and output logic
	always @(*) begin
		case (state)
			S0: begin
				z = 0;
				if (x)
					next_state = S1;   // Move to S1 on seeing '1'
				else
					next_state = S0;   // Stay in S0 if '0' is seen
			end

			S1: begin
				z = 0;
				if (x)
					next_state = S1;   // Stay in S1 if another '1' is seen
				else
					next_state = S2;   // Move to S2 on seeing '0'
			end

			S2: begin
				if (x) begin
					z = 1;              // Detecting '101'
					next_state = S1;    // Move to S1 to allow overlapping sequence
				end
				else begin
					z = 0;
					next_state = S0;   // Move back to S0 if '0' is seen
				end
			end

			default: begin
				z = 0;
				next_state = S0;
			end
		endcase
	end

endmodule
