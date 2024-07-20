module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    wire [98:0] shifted_in;
    wire [99:0] in_or_shifted;
    wire [99:0] in_xor_shifted;

    assign shifted_in = {in[98:0], 1'b0};
    assign in_or_shifted = in | shifted_in;
    assign in_xor_shifted = {in[0] ^ in[99], in ^ shifted_in};

    assign out_both = in & shifted_in;
    assign out_any = in_or_shifted;
    assign out_different = in_xor_shifted;

endmodule
