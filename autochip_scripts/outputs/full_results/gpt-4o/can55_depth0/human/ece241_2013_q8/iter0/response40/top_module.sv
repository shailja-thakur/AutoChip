module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// State encoding
	typedef enum reg [1:0] {
		S0 = 2'b00, // Initial state
		S1 = 2'b01, // Detected '1'
		S2 = 2'b10  // Detected '10'
	} state_t;
	
	state_t current_state, next_state;
	
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			current_state <= S0;
		else
			current_state <= next_state;
	end
	
	always @(*) begin
		// Default next state
		next_state = current_state;
		// Default output
		z = 0;
		case (current_state)
			S0: begin
				if (x)
					next_state = S1;
			end
			S1: begin
				if (!x)
					next_state = S2;
				else
					next_state = S1;
			end
			S2: begin
				if (x) begin
					next_state = S1;
					z = 1;
				end
				else
					next_state = S0;
			end
		endcase
	end

endmodule
