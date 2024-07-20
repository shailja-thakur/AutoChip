module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// State encoding
	typedef enum reg [1:0] {
		S0 = 2'b00, // Initial state
		S1 = 2'b01, // State after receiving '1'
		S2 = 2'b10  // State after receiving '10'
	} state_t;

	state_t state, next_state;

	// State transition logic
	always @(*) begin
		case (state)
			S0: begin
				if (x == 1'b1) 
					next_state = S1;
				else 
					next_state = S0;
			end
			
			S1: begin
				if (x == 1'b0)
					next_state = S2;
				else
					next_state = S1;
			end
			
			S2: begin
				if (x == 1'b1) 
					next_state = S1;
				else 
					next_state = S0;
			end
			
			default: next_state = S0;
		endcase
	end

	// State register with asynchronous reset
	always @(negedge aresetn or posedge clk) begin
		if (!aresetn)
			state <= S0;
		else
			state <= next_state;
	end

	// Output logic
	always @(posedge clk) begin
		if (state == S2 && x == 1'b1)
			z <= 1'b1;
		else
			z <= 1'b0;
	end

endmodule
