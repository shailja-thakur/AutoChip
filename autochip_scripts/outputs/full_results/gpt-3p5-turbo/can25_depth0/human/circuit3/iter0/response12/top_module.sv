module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	reg q;

	always @(a, b, c, d) begin
		case ({a, b, c, d})
			4'b0001: q <= 1'b0;
			4'b0010: q <= 1'b0;
			4'b0100: q <= 1'b0;
			4'b1000: q <= 1'b1;
			default: q <= 1'b1;
		endcase
	end

endmodule
