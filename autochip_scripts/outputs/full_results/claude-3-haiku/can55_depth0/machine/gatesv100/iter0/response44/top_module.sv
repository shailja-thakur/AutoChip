module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    // Shift the input signal by one bit
    wire [99:0] shifted_in = {in[98:0], 1'b0};

    // Perform bit-wise operations
    assign out_both = in & shifted_in[99:1];
    assign out_any = in | shifted_in;
    assign out_different = in ^ shifted_in;
endmodule
