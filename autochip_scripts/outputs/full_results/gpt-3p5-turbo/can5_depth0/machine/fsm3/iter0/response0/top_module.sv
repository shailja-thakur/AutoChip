module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	reg [1:0] state, next_state;
	
	always @(posedge clk) begin
		if (areset)
			state <= 2'b00; // Reset to state A
		else
			state <= next_state; // Update state
			
		case (state)
			2'b00: // State A
				if (in)
					next_state = 2'b01; // Next state B if input signal is 1
				else
					next_state = 2'b00; // Next state A if input signal is 0
			2'b01: // State B
				if (in)
					next_state = 2'b01; // Next state B if input signal is 1
				else
					next_state = 2'b10; // Next state C if input signal is 0
			2'b10: // State C
				if (in)
					next_state = 2'b11; // Next state D if input signal is 1
				else
					next_state = 2'b00; // Next state A if input signal is 0
			2'b11: // State D
				if (in)
					next_state = 2'b01; // Next state B if input signal is 1
				else
					next_state = 2'b10; // Next state C if input signal is 0
		endcase
	end
	
	assign out = (state == 2'b11) ? 1'b1 : 1'b0; // Set out to 1 if state is D, else 0
	
endmodule
