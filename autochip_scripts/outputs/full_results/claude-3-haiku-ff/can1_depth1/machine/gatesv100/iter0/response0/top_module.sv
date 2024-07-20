module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    // Shift the input vector by one bit
    wire [99:0] shifted_in;
    assign shifted_in = {in[98:0], in[99]};

    // Generate the output signals
    assign out_both = in & shifted_in;
    assign out_any = in | shifted_in;
    assign out_different = in ^ shifted_in;

endmodule
