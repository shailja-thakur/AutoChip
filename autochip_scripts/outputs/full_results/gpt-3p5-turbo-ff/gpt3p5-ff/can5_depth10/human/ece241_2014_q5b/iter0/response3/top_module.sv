module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	// Declare states
	reg [1:0] state, next_state;
	
	// Declare output
	reg z_output;
	
	// Assign initial state
	always @(posedge clk or posedge areset)
		if (areset)
			state <= 2'b00;  // State A
		else
			state <= next_state;  // Proceed to next state
	
	// Assign next state and output based on current state and input
	always @(*)
		case (state)
			2'b00: begin  // State A
				if (x)
					next_state = 2'b01;  // Transition to state B
				else
					next_state = 2'b00;  // Remain in state A
					
				z_output = 1'b0;  // Output is 0
			end
			
			2'b01: begin  // State B
				if (x)
					next_state = 2'b10;  // Remain in state B
				else
					next_state = 2'b01;  // Remain in state B
					
				z_output = 1'b1;  // Output is 1
			end
			
			2'b10: begin  // State B
				if (x)
					next_state = 2'b10;  // Remain in state B
				else
					next_state = 2'b01;  // Remain in state B
					
				z_output = 1'b1;  // Output is 1
			end
		endcase
	
	// Assign output
	assign z = z_output;
endmodule
