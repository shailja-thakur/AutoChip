module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// out_both
	assign out_both[0] = in[0] & in[99];
	loop_both: for (int i = 1; i < 99; i = i + 1) begin
		assign out_both[i] = in[i] & in[i-1];
	end
	
	// out_any
	assign out_any[99] = in[98] | in[99];
	loop_any: for (int i = 1; i < 99; i = i + 1) begin
		assign out_any[i] = in[i] | in[i+1];
	end
	
	// out_different
	assign out_different[0] = in[0] ^ in[99];
	loop_different: for (int i = 1; i < 100; i = i + 1) begin
		assign out_different[i] = in[i] ^ in[i-1];
	end

endmodule
