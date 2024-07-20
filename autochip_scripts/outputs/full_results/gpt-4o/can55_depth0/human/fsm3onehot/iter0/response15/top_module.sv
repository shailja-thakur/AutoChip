module top_module (
	input in,
	input [3:0] state,
	output reg [3:0] next_state,
	output out
);

	// State definitions
	localparam A = 4'b0001;
	localparam B = 4'b0010;
	localparam C = 4'b0100;
	localparam D = 4'b1000;

	// Output logic
	assign out = (state == D) ? 1'b1 : 1'b0;

	// State transition logic
	always @(*) begin
		case (state)
			A: next_state = (in == 1'b0) ? A : B;
			B: next_state = (in == 1'b0) ? C : B;
			C: next_state = (in == 1'b0) ? A : D;
			D: next_state = (in == 1'b0) ? C : B;
			default: next_state = A; // default case to handle any unexpected state
		endcase
	end
endmodule
