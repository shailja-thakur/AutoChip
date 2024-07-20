module top_module (
	input a,
	input b,
	input c,
	input d,
	output reg out
);

	always @(a, b, c, d)
	begin
		case ({a, b, c, d})
			4'b00? : out = 1;
			4'b01? : out = d;
			4'b11? : out = 1;
			4'b10? : out = 1;
			default: out = 0;
		endcase
	end

endmodule
