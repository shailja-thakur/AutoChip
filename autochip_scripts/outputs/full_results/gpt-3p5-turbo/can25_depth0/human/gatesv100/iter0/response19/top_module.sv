module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:0] out_any,
	output [99:0] out_different
);

	// Output both
	assign out_both[0] = in[0] & in[99];
	for(int i=1; i<=98; i=i+1)
		assign out_both[i] = in[i] & in[i-1];

	// Output any
	assign out_any[99] = in[98] | in[99];
	for(int i=1; i<=98; i=i+1)
		assign out_any[i] = in[i] | in[i+1];

	// Output different
	assign out_different[0] = (in[0] != in[99]);
	for(int i=1; i<=99; i=i+1)
		assign out_different[i] = (in[i] != in[i-1]);
    
endmodule
