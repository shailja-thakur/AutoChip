module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);
    
    wire [98:0] shifted_in;
    wire [98:0] in_both;
    wire [99:0] in_any;
    wire [99:0] in_different;

    assign shifted_in = {in[98:0], 1'b0};

    assign in_both = in[98:0] & shifted_in;
    assign in_any = in[99:0] | shifted_in;
    assign in_different = in[99:1] ^ {in[0], in[98:1], 1'b0};

    assign out_both = in_both;
    assign out_any = in_any;
    assign out_different = in_different;

endmodule
