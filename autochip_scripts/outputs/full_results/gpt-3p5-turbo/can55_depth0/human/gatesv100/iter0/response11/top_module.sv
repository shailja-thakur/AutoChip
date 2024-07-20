module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// out_both
	assign out_both[0] = in[0] & in[99];
  
	// out_both
	for (int i = 1; i <= 98; i = i+1) begin
		assign out_both[i] = in[i] & in[i-1];
	end
  
	// out_any
	assign out_any[99] = in[99] | in[98];
  
	// out_any
	for (int i = 98; i >= 1; i = i-1) begin
		assign out_any[i] = in[i] | in[i+1];
	end
  
	// out_different
	assign out_different[0] = in[0] != in[99];
  
	// out_different
	for (int i = 1; i <= 99; i = i+1) begin
		assign out_different[i] = in[i] != in[i-1];
	end

endmodule
