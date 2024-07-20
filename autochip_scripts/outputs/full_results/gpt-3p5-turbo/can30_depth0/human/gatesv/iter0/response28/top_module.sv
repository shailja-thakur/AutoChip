module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different
);

    // Internal signals
    wire [3:0] in_shifted;

    // Shift the input vector to the right by 1 bit
    assign in_shifted = {in[2:0], in[3]};

    // out_both: Check if both the input bit and its left neighbor are '1'
    assign out_both[0] = in[0] & in_shifted[0];
    assign out_both[1] = in[1] & in_shifted[1];
    assign out_both[2] = in[2] & in_shifted[2];

    // out_any: Check if either the input bit or its right neighbor is '1'
    assign out_any[1] = in[1] | in_shifted[1];
    assign out_any[2] = in[2] | in_shifted[2];
    assign out_any[3] = in[3] | in_shifted[3];

    // out_different: Check if the input bit is different from its left neighbor
    assign out_different[0] = in[0] ^ in_shifted[0];
    assign out_different[1] = in[1] ^ in_shifted[1];
    assign out_different[2] = in[2] ^ in_shifted[2];
    assign out_different[3] = in[3] ^ in_shifted[3];

endmodule
