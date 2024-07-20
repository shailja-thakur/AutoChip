module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    wire [99:0] in_shifted;
    wire [98:0] in_shifted_both;
    wire [99:1] in_shifted_any;
    wire [99:0] in_shifted_different;

    assign in_shifted = {in[98:0], in[99]};
    assign in_shifted_both = in_shifted[98:0] & in_shifted[99:1];
    assign in_shifted_any = {in_shifted[0], in_shifted[99:1]};
    assign in_shifted_different = in_shifted ^ in_shifted[98:0];

    assign out_both = in_shifted_both;
    assign out_any = in_shifted_any;
    assign out_different = {in[98] ^ in[99], in_shifted_different[98:1]};

endmodule
