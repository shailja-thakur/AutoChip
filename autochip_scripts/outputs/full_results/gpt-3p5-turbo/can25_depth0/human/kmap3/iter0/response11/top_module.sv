module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

	always @ (*) begin
		case({c, d})
			2'b00: if (a == 1'b1 && b == 1'b0)
					out = 1'b1;
			       else
			       		out = d;
			2'b01: if (a == 1'b0 && b == 1'b0)
					out = 1'b0;
			       else
			       		out = d;
			2'b10: out = 1'b1;
			2'b11: out = 1'b1;
		endcase
	end

endmodule
