module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	reg [1:0] state, next_state;     // Declare state variables as registers
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= 2'b00;         // Reset to initial state A
		else
			state <= next_state;     // Update state based on next_state signal
	end

	always @(state, in) begin
		// Define next_state and output based on current state and input
		case (state)
			2'b00: begin      // State A
				if (in)
					next_state = 2'b11;  // Next state is D
				else
					next_state = 2'b01;  // Next state is B
				out = 1'b0;         // Output is 0 in state A
			end
			2'b01: begin      // State B
				if (in)
					next_state = 2'b01;  // Next state is B
				else
					next_state = 2'b10;  // Next state is C
				out = 1'b0;         // Output is 0 in state B
			end
			2'b10: begin      // State C
				if (in)
					next_state = 2'b11;  // Next state is D
				else
					next_state = 2'b00;  // Next state is A
				out = 1'b0;         // Output is 0 in state C
			end
			2'b11: begin      // State D
				if (in)
					next_state = 2'b10;  // Next state is C
				else
					next_state = 2'b01;  // Next state is B
				out = 1'b1;         // Output is 1 in state D
			end
			default: begin
				next_state = 2'b00;
				out = 1'b0;
			end
		endcase
	end
	
endmodule
