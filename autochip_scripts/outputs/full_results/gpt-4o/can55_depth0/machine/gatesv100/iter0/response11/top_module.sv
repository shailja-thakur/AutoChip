module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    // Shift the input signal by one bit to generate the second input signal
    wire [99:0] in_shifted;
    assign in_shifted = {in[98:0], 1'b0}; // Right shift by 1

    // Generate out_both using bit-wise AND operation on in[99:1] and in_shifted[98:0]
    assign out_both = in[99:1] & in[98:0];

    // Generate out_any using bit-wise OR operation on in and in_shifted
    assign out_any = in | in_shifted;

    // Generate out_different using bit-wise XOR operation on in and in_shifted
    assign out_different = in ^ in_shifted;

endmodule
