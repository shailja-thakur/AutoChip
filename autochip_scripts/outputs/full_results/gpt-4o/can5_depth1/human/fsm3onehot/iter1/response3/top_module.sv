module top_module (
	input in,
	input [3:0] state,
	output reg [3:0] next_state,
	output reg out
);

	// State encodings
	localparam A = 4'b0001;
	localparam B = 4'b0010;
	localparam C = 4'b0100;
	localparam D = 4'b1000;

	// Next state logic
	always @(*) begin
		case (state)
			A: next_state = (in == 1'b0) ? A : B;
			B: next_state = (in == 1'b0) ? C : B;
			C: next_state = (in == 1'b0) ? A : D;
			D: next_state = (in == 1'b0) ? C : B;
			default: next_state = 4'b0000; // Should not occur due to one-hot encoding
		endcase
	end

	// Output logic
	always @(*) begin
		case (state)
			A: out = 1'b0;
			B: out = 1'b0;
			C: out = 1'b0;
			D: out = 1'b1;
			default: out = 1'b0; // Should not occur due to one-hot encoding
		endcase
	end

endmodule
