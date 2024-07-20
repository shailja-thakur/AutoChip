module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);
    
    // in_shifted is in shifted right by one bit
    wire [99:0] in_shifted;
    assign in_shifted = {1'b0, in[99:1]};

    // out_both: AND of in and in_shifted
    assign out_both = in[99:1] & in_shifted[98:0];

    // out_any: OR of in and in_shifted
    assign out_any = in | in_shifted;

    // out_different: XOR of in and in_shifted
    assign out_different = in ^ in_shifted;

endmodule
