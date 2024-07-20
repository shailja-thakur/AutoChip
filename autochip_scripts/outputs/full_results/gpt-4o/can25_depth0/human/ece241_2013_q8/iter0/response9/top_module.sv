module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// State encoding
	typedef enum reg [1:0] {
		S0 = 2'b00, // Initial state
		S1 = 2'b01, // State after observing '1'
		S2 = 2'b10  // State after observing '10'
	} state_t;

	state_t state, next_state;

	// Mealy FSM next state logic and output logic
	always @(*) begin
		z = 1'b0; // Default output
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
				if (x) begin
					next_state = S1;
					z = 1'b1; // Detected "101"
				} else 
					next_state = S0;
			end
		endcase
	end

	// State transition on positive clock edge or negative reset
	always @(negedge aresetn or posedge clk) begin
		if (!aresetn)
			state <= S0;
		else
			state <= next_state;
		end
endmodule
