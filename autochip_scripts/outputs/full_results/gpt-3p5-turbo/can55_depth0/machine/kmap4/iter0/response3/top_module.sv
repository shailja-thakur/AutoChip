module top_module (
	input a,
	input b,
	input c,
	input d,
	output reg out
);

	always @* begin
		case({a, b, c, d})
			4'b0000: out = 1'b0; // all inputs are 0
			4'b1111: out = 1'b1; // all inputs are 1
			default: out = 1'b0; // any other combination of inputs
		endcase
	end

endmodule
