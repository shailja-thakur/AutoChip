module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:0] out_any,
	output [3:0] out_different
);

    // Calculate out_both (bitwise AND of in[2:0] and in[3:1])
    assign out_both = in[2:0] & in[3:1];

    // Calculate out_any (bitwise OR of in[2:0] and in[3:1])
    assign out_any = {1'b0, (in[2:0] | in[3:1])};

    // Calculate out_different (bitwise XOR of in and {in[3:1], in[0]})
    assign out_different = in ^ {in[3:1], in[0]};

endmodule
