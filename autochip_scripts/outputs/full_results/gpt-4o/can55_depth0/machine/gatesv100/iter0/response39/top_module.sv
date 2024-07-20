module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:0] out_any,
	output [99:0] out_different
);
    wire [99:0] in_shifted;

    // Shift the input signal by one bit to the right
    assign in_shifted = {1'b0, in[99:1]};

    // Generate out_both signal by performing bit-wise AND operation on in[98:0] and in_shifted[99:1]
    assign out_both = in[98:0] & in_shifted[99:1];

    // Generate out_any signal by performing bit-wise OR operation on in
    assign out_any = in | {1'b0, in[99:1]};

    // Generate out_different signal by performing bit-wise XOR operation on in
    assign out_different = in ^ {in[0], in[99:1]};
endmodule
