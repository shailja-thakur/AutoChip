module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output reg out
);
	// State Encoding
	localparam A = 2'b00;
	localparam B = 2'b01;
	localparam C = 2'b10;
	localparam D = 2'b11;

	// Next state logic
	always @(*) begin
		case (state)
			A: next_state = (in == 1'b0) ? A : B;
			B: next_state = (in == 1'b0) ? C : B;
			C: next_state = (in == 1'b0) ? A : D;
			D: next_state = (in == 1'b0) ? C : B;
			default: next_state = A;  // Should not happen
		endcase
	end

	// Output logic
	always @(*) begin
		case (state)
			A: out = 1'b0;
			B: out = 1'b0;
			C: out = 1'b0;
			D: out = 1'b1;
			default: out = 1'b0;  // Should not happen 
		endcase
	end
endmodule
