module top_module (
	input clk,
	input in,
	input reset,
	output out
);
	
	// Define the states
	localparam A = 1'b0;
	localparam B = 1'b1;
	
	// State register
	reg state, next_state;
	
	// Combinational logic block to determine next state
	always @(*) begin
		case (state)
			A: if (in) next_state = A; else next_state = B;
			B: if (in) next_state = B; else next_state = A;
			default: next_state = A;  // Default to state A to handle unspecified cases
		endcase
	end
	
	// Sequential logic block to update state
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= B;  // Reset state is B
		else
			state <= next_state;
	end
	
	// Output logic
	assign out = (state == B);
	
endmodule
