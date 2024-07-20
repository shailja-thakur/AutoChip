module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);
	reg [2:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b000; // Initializing state to A
		else begin
			case (state)
				3'b000: // State A
					if (x)
						state <= 3'b001; // Transition to state B if x is high
					else
						state <= 3'b000; // Remain in state A if x is low
				3'b001: // State B
					if (x)
						state <= 3'b100; // Transition to state E if x is high
					else
						state <= 3'b001; // Remain in state B if x is low
				3'b010: // State C
					if (x)
						state <= 3'b001; // Transition to state B if x is high
					else
						state <= 3'b010; // Remain in state C if x is low
				3'b011: // State D
					if (x)
						state <= 3'b010; // Transition to state C if x is high
					else
						state <= 3'b010; // Remain in state D if x is low
				3'b100: // State E
					if (x)
						state <= 3'b100; // Remain in state E if x is high
					else
						state <= 3'b011; // Transition to state D if x is low
				default:
					state <= 3'b000; // Default to state A
			endcase
		end
	end
	
	always @(state) begin
		if (state == 3'b011 || state == 3'b100) // Output is high when state is D or E
			z <= 1'b1;
		else
			z <= 1'b0;
	end
endmodule
