module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

// Generate out_both by performing a bit-wise AND operation between in and a shifted version of in
assign out_both = in[0:98] & in[1:99];

// Generate out_any by performing a bit-wise OR operation between in[98:0] and in[99:1]
assign out_any = {in[98:0], in[99]};

// Generate out_different by performing a bit-wise XOR operation between in and a modified version of in
assign out_different = {in[99] ^ in[0], in[98:0] ^ in[99:1]};

endmodule
