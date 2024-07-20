module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output out
);
	always_comb begin
		next_state = state;   // Initialize next_state with state value
		
		case (state)
			2'b00: begin
				if (in == 1'b1)
					next_state = 2'b01;   // Transition from A to B
				// else next_state = 2'b00;   // Transition from A to A (unchanged state)
			end
			
			2'b01: begin
				if (in == 1'b1) 
					next_state = 2'b01;   // Transition from B to B (unchanged state)
				else
					next_state = 2'b10;   // Transition from B to C
			end
			
			2'b10: begin
				if (in == 1'b1)
					next_state = 2'b11;   // Transition from C to D
				else
					next_state = 2'b00;   // Transition from C to A
			end
			
			2'b11: begin
				if (in == 1'b1)
					next_state = 2'b01;   // Transition from D to B
				else
					next_state = 2'b10;   // Transition from D to C
			end
		endcase
	end
	
	assign out = (state == 2'b11) ? 1'b1 : 1'b0;   // Set out to 1 when state is D, otherwise set it to 0
	
endmodule
