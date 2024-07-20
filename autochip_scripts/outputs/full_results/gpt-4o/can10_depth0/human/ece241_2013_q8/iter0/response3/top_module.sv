module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// State encoding
	typedef enum reg [1:0] {
		S0, // Initial state / reset state
		S1, // State after seeing '1'
		S2  // State after seeing '10'
	} state_t;
	
	state_t state, next_state;

	// State transition logic (combinational)
	always @(*) begin
		case (state)
			S0: if (x) next_state = S1; else next_state = S0;
			S1: if (x) next_state = S1; else next_state = S2;
			S2: if (x) next_state = S1; else next_state = S0;
			default: next_state = S0; // This should never happen
		endcase
	end

	// State register (sequential)
	always @(negedge clk or negedge aresetn) begin
		if (!aresetn)
			state <= S0;
		else
			state <= next_state;
	end

	// Output logic
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			z <= 0;
		else begin
			if (state == S2 && x == 1)
				z <= 1;
			else
				z <= 0;
		end
	end

endmodule
