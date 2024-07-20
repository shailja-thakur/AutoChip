module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	// Define states using parameter
	parameter S = 2'b00;
	parameter S1 = 2'b01;
	parameter S10 = 2'b10;
	
	// Declare state and next_state variables
	reg [1:0] state, next_state;
	
	// Assign initial state
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn)
			state <= S; // Initial state is S when aresetn is low
		else
			state <= next_state; // Update state based on next_state value
	end
	
	// Assign next_state based on input x and current state
	always @(state, x) begin
		case ({state, x})
			2'b0_0: next_state <= S;   // when the input x is 0, and the state is S, the state next is S
			2'b0_1: next_state <= S1;  // when the input x is 1, and the state is S, the state next is S1
			2'b1_0: next_state <= S10; // when the input x is 0, and the state is S1, the state next is S10
			2'b1_1: next_state <= S1;  // when the input x is 1, and the state is S1, the state next is S1
			2'b10_0: next_state <= S;  // when the input x is 0, and the state is S10, the state next is S
			2'b10_1: next_state <= S1; // when the input x is 1, and the state is S10, the state next is S1
			default: next_state <= S;  // Default case to handle any invalid inputs
		endcase
	end
	
	// Assign output z based on current state
	always @(state) begin
		case (state)
			S: z <= 1'b0;  // when the input state is S, the output z is 0
			S1: z <= 1'b0; // when the input state is S1, the output z is 0
			S10: z <= x;  // when the input state is S10, the output z is the input x
			default: z <= 1'b0; // Default case to handle any invalid states
		endcase
	end
	
endmodule
