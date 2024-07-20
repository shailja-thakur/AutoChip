module top_module (
	input in,
	input [3:0] state,
	output reg [3:0] next_state,
	output out
);

	// State encoding
	localparam A = 4'b0001;
	localparam B = 4'b0010;
	localparam C = 4'b0100;
	localparam D = 4'b1000;

	// State transition logic
	always @(*) begin
		case (state)
			A: if (in) next_state = B; else next_state = A;
			B: if (in) next_state = B; else next_state = C;
			C: if (in) next_state = D; else next_state = A;
			D: if (in) next_state = B; else next_state = C;
			default: next_state = 4'b0000; // default state
		endcase
	end

	// Output logic
	assign out = (state == D);

endmodule
