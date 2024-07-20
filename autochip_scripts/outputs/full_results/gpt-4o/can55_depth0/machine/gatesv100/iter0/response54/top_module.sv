module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    // Right shift the input
    wire [99:0] shifted_in;
    assign shifted_in = {1'b0, in[99:1]};

    // Generate out_both by performing a bitwise AND on input and shifted input
    assign out_both = in[99:1] & shifted_in[98:0];

    // Generate out_any by performing a bitwise OR on input and shifted input
    assign out_any = in | shifted_in;

    // Generate out_different by performing a bitwise XOR on input and shifted input
    assign out_different = in ^ {shifted_in[98:0], in[0]};

endmodule
