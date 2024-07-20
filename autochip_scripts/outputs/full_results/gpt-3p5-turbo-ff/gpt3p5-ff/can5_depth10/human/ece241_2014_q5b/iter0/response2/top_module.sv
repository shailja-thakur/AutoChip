module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	
	reg [1:0] state, next_state;
	
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= 2'b00; // Reset state A
		else
			state <= next_state;
	end
	
	always @(state or x) begin
		case (state)
			2'b00: begin // State A
				if (x)
					next_state = 2'b01; // Transition to state B if x is 1
				else
					next_state = 2'b00; // Remain in state A if x is 0
				
				z = 1'b0; // Output z is always 0 in state A
			end
			
			2'b01: begin // State B
				if (x)
					next_state = 2'b00; // Transition to state A if x is 1
				else
					next_state = 2'b01; // Remain in state B if x is 0
				
				z = 1'b1; // Output z is always 1 in state B
			end
		endcase
	end
	
endmodule
