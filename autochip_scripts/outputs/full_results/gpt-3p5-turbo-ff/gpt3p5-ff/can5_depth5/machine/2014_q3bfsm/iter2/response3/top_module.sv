module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);
	
	reg [2:0] state;
	reg [2:0] next_state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b000; // Initialize state to A
		else
			state <= next_state;
	end
	
	always @(state, x) begin
		case(state)
			3'b000: // State A
				if (x)
					next_state = 3'b001; // Transition to state B
				else
					next_state = 3'b000; // Remain in state A
			3'b001: // State B
				if (x)
					next_state = 3'b100; // Transition to state E
				else
					next_state = 3'b001; // Remain in state B
			3'b010: // State C
				if (x)
					next_state = 3'b001; // Transition to state B
				else
					next_state = 3'b010; // Remain in state C
			3'b011: // State D
				if (x)
					next_state = 3'b010; // Transition to state C
				else
					next_state = 3'b011; // Remain in state D
			3'b100: // State E
				if (x)
					next_state = 3'b100; // Remain in state E
				else
					next_state = 3'b011; // Transition to state D
			default:
				next_state = 3'b000; // Default to state A
		endcase
	end
	
	always @(state) begin
		if (state == 3'b011 || state == 3'b100)
			z <= 1'b1; // Output z is high when state is D or E
		else
			z <= 1'b0;
	end
endmodule
