module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output reg out
);
	// State encoding
	localparam A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;
	
	// Next state logic
	always @(*) begin
		case(state)
			A: if (in == 1'b0) next_state = A; else next_state = B;
			B: if (in == 1'b0) next_state = C; else next_state = B;
			C: if (in == 1'b0) next_state = A; else next_state = D;
			D: if (in == 1'b0) next_state = C; else next_state = B;
			default: next_state = A; // Default case to avoid latches
		endcase
	end
	
	// Output logic
	always @(*) begin
		case(state)
			A: out = 1'b0;
			B: out = 1'b0;
			C: out = 1'b0;
			D: out = 1'b1;
			default: out = 1'b0; // Default case to avoid latches
		endcase
	end

endmodule
