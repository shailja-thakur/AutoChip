module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

	always @(*) begin
		case ({c, d, a})
			3'b001: out = 1;
			3'b010: out = 1;
			3'b011: out = 1;
			3'b111: out = 1;
			default: out = 0;
		endcase
	end

endmodule
