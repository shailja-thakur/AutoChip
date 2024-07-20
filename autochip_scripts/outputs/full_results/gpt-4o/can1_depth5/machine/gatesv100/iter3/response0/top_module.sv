module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    wire [99:0] shifted_in;

    // Shift the input vector to the left by 1 bit
    assign shifted_in = {in[98:0], 1'b0};

    // Generate out_both output using bitwise AND operation (resulting in a 99-bit vector)
    assign out_both = in[99:1] & in[98:0];

    // Generate out_any output using bitwise OR operation (resulting in a 100-bit vector)
    assign out_any = in | shifted_in;

    // Generate out_different output using bitwise XOR operation (resulting in a 100-bit vector)
    assign out_different = in ^ shifted_in;

endmodule
