module top_module (
	input clk,
	input in,
	input reset,
	output out
);
	// Declare the states
	reg [1:0] state;
	
	// Declare the output
	reg out;
	
	// Declare the next state
	reg [1:0] next_state;
	
	// Synchronous reset
	always @(posedge clk) begin
		if (reset)
			state <= 2'b10; // reset state B
		else
			state <= next_state;
	end
	
	// State transition and output logic
	always @(state, in) begin
		case(state)
			2'b10: begin // State B
				if (in)
					next_state <= 2'b10; // Stay in state B
				else
					next_state <= 2'b01; // Transition to state A
				out <= 1'b1;
			end
			2'b01: begin // State A
				if (in)
					next_state <= 2'b01; // Stay in state A
				else
					next_state <= 2'b10; // Transition to state B
				out <= 1'b0;
			end
			default: begin
				next_state <= 2'b10; // Default to reset state B
				out <= 1'b1; // Default output is 1
			end
		endcase
	end
	
endmodule
