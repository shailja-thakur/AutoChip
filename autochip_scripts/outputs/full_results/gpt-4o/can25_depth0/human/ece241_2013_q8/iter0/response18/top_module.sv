module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// State Encoding
	typedef enum reg [1:0] {
		S0 = 2'b00, // Initial state
		S1 = 2'b01, // State after seeing '1'
		S2 = 2'b10  // State after seeing '10'
	} state_t;
	
	state_t state, next_state;

	// State Transition Logic
	always @(*) begin
		case (state)
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

	// Output Logic
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn) begin
			state <= S0;
			z <= 1'b0;
		end else begin
			state <= next_state;
			z <= (state == S2) && x;
		end
	end

endmodule
