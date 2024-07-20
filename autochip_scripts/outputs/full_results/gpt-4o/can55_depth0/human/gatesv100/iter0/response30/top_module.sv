module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

// out_both: each bit indicates if both the input bit and its left neighbor are '1'
// out_both[98] corresponds to in[98] and in[99], but out_both[99] does not exist
genvar i;
generate
    for (i = 0; i < 99; i = i + 1) begin : both
        assign out_both[i] = in[i] & in[i + 1];
    end
endgenerate

// out_any: each bit indicates if any of the input bit and its right neighbor are '1'
// out_any[2] corresponds to in[2] and in[1], but out_any[0] does not exist
generate
    for (i = 1; i < 100; i = i + 1) begin : any
        assign out_any[i] = in[i] | in[i - 1];
    end
endgenerate

// out_different: each bit indicates if the input bit is different from its left neighbor
// treat the vector as wrapping around: in[99]'s neighbor to the left is in[0]
generate
    for (i = 0; i < 99; i = i + 1) begin : different
        assign out_different[i] = in[i] ^ in[i + 1];
    end
endgenerate
assign out_different[99] = in[99] ^ in[0];

endmodule
