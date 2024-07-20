module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output reg out
);

	// state encoding
	parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

	// next state logic
	always @(*) begin
		case (state)
			A: next_state = in ? B : A;
			B: next_state = in ? B : C;
			C: next_state = in ? D : A;
			D: next_state = in ? B : C;
			default: next_state = A; // default case to handle invalid states
		endcase
	end

	// output logic
	always @(*) begin
		case (state)
			A: out = 0;
			B: out = 0;
			C: out = 0;
			D: out = 1;
			default: out = 0; // default case to handle invalid states
		endcase
	end

endmodule
