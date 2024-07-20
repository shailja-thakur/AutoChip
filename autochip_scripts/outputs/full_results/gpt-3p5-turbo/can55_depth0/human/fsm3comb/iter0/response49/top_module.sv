module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output out
);
	
	// State transition logic
	always @(state, in)
	begin
		case (state)
			2'b00: if (in == 1'b0) next_state <= 2'b00; else next_state <= 2'b01;  // A
			2'b01: if (in == 1'b0) next_state <= 2'b10; else next_state <= 2'b01;  // B
			2'b10: if (in == 1'b0) next_state <= 2'b00; else next_state <= 2'b11;  // C
			2'b11: if (in == 1'b0) next_state <= 2'b10; else next_state <= 2'b01;  // D
			default: next_state <= 2'b00;  // Default case
		endcase
	end
	
	// Output logic
	always @(state)
	begin
		case (state)
			2'b00, 2'b01, 2'b10: out <= 1'b0;  // Output 0 for states A, B, and C
			2'b11: out <= 1'b1;  // Output 1 for state D
			default: out <= 1'b0;  // Default case
		endcase
	end
endmodule
