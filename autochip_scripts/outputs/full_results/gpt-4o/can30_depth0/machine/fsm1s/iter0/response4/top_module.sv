module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// Define states as parameters for better readability
	parameter A = 1'b0, B = 1'b1;
	
	// Parameterized register to store the current state
	reg state, next_state;
	
	// Combinational logic block to determine the next state
	always @(*) begin
		case (state)
			A: begin
				if (in) 
					next_state = A;
				else 
					next_state = B;
			end
			
			B: begin
				if (in) 
					next_state = B;
				else 
					next_state = A;
			end
			
			default: next_state = A; // Default case to avoid latches
		endcase
	end
	
	// Sequential logic block to update the state register on the rising edge of clk
	always @(posedge clk or posedge reset) begin
		if (reset) 
			state <= B; // State resets to B
		else 
			state <= next_state;
	end
	
	// Output logic
	always @(state) begin
		if (state == B) 
			out = 1'b1; // Output high when state is B
		else 
			out = 1'b0; // Output low when state is A
	end
	
endmodule
