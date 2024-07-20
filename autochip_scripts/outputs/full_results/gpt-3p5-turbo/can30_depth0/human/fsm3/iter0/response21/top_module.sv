module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	
	reg [1:0] state, next_state;
	
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= 2'b00; // Resets the FSM to state A
		else
			state <= next_state;
	end
	
	always @(state, in) begin
		case (state)
			2'b00: begin
				if (in)
					next_state = 2'b10; // Next state is B if input is 1
				else
					next_state = 2'b01; // Next state is A if input is 0
				out = 1'b0; // Output is 0 in state A
			end
			2'b01: begin
				if (in)
					next_state = 2'b01; // Next state is B if input is 1
				else
					next_state = 2'b10; // Next state is C if input is 0
				out = 1'b0; // Output is 0 in state B
			end
			2'b10: begin
				if (in)
					next_state = 2'b11; // Next state is D if input is 1
				else
					next_state = 2'b01; // Next state is A if input is 0
				out = 1'b0; // Output is 0 in state C
			end
			2'b11: begin
				if (in)
					next_state = 2'b01; // Next state is B if input is 1
				else
					next_state = 2'b10; // Next state is C if input is 0
				out = 1'b1; // Output is 1 in state D
			end
		endcase
	end

endmodule
