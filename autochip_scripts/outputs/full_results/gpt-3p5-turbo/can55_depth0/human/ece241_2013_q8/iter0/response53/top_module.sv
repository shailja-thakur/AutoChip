module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	reg [2:0] state; // Define 3-bit state variable
	
	always @(posedge clk or negedge aresetn) // Synchronous reset
	begin
		if (!aresetn) // Negative asynchronous reset
			state <= 3'b000; // Reset to initial state
		else
		begin
			case (state) // State transition logic
				3'b000: // State 0
					if (x == 1'b1) // Input signal is high
						state <= 3'b001; // Transition to state 1
					else
						state <= 3'b000; // Stay in state 0
				3'b001: // State 1
					if (x == 1'b0) // Input signal is low
						state <= 3'b010; // Transition to state 2
					else if (x == 1'b1) // Input signal is high
						state <= 3'b001; // Stay in state 1
				3'b010: // State 2
					if (x == 1'b1) // Input signal is high
						state <= 3'b011; // Transition to state 3
					else
						state <= 3'b000; // Transition to state 0
				3'b011: // State 3
					if (x == 1'b0) // Input signal is low
						state <= 3'b000; // Transition to state 0
					else
						state <= 3'b011; // Stay in state 3
				default:
					state <= 3'b000; // Default transition to initial state
			endcase
		end
	end
	
	always @(state, x) // Output logic
	begin
		case (state)
			3'b001: // In state 1
				if (x == 1'b0) // Input signal is low
					z <= 1'b0; // Output signal is low
				else
					z <= 1'b1; // Output signal is high
			default:
				z <= 1'b0; // Output signal is low for all other states
		endcase
	end
endmodule
