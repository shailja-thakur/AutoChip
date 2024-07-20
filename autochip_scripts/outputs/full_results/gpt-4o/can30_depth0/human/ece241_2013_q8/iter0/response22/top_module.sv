module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// State declaration
	typedef enum logic[1:0] {
		S0, // Initial state
		S1, // First '1' detected
		S2  // '10' detected
	} state_t;
	
	state_t state, next_state;

	// State transition logic (Mealy-type FSM)
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn)
			state <= S0; // Asynchronous reset
		else
			state <= next_state;
	end

	// Next state logic and output logic combined
	always @(*) begin
		case(state)
			S0: begin
				z = 0;
				if (x)
					next_state = S1;
				else
					next_state = S0;
			end
			S1: begin
				z = 0;
				if (x)
					next_state = S1;
				else
					next_state = S2;
			end
			S2: begin
				if (x) begin
					z = 1;
					next_state = S1;
				end else begin
					z = 0;
					next_state = S0;
				end
			end
			default: begin
				z = 0;
				next_state = S0;
			end
		endcase
	end

endmodule
