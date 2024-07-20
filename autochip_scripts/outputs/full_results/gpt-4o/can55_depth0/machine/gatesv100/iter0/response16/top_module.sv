module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    wire [99:0] in_shifted; // shifted version of the input signal

    // Shift the input vector by one bit to the left
    assign in_shifted = in << 1;

    // Generate out_both by performing bitwise AND operation
    assign out_both = in[99:1] & in_shifted[99:1];

    // Generate out_any by performing bitwise OR operation
    assign out_any = in | in_shifted;

    // Generate out_different by performing bitwise XOR operation
    assign out_different[99] = in[99] ^ in_shifted[99]; // First bit of out_different with special case
    assign out_different[98:0] = in[98:0] ^ in_shifted[98:0]; // Remaining bits

endmodule
