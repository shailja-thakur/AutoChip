module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

// Logic for out_both
assign out_both[0] = in[0] & in[99];
// Iterate over the input bits and calculate the corresponding out_both values
generate
  genvar i;
  for (i = 1; i < 99; i = i + 1) begin : out_both_assign
    assign out_both[i] = in[i] & in[i-1];
  end
endgenerate

// Logic for out_any
// Iterate over the input bits and calculate the corresponding out_any values
generate
  genvar j;
  for (j = 1; j < 100; j = j + 1) begin : out_any_assign
    assign out_any[j] = in[j] | in[j-1];
  end
endgenerate

// Logic for out_different
assign out_different[0] = in[0] ^ in[99];
// Iterate over the input bits and calculate the corresponding out_different values
generate
  genvar k;
  for (k = 1; k < 100; k = k + 1) begin : out_different_assign
    assign out_different[k] = in[k] ^ in[k-1];
  end
endgenerate

endmodule
