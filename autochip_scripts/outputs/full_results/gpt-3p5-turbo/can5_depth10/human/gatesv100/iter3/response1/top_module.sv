module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    assign out_both = in[98:0] & in[97:0];
    
    assign out_any = {in[98], in[98:0] | in[99]};
    
    assign out_different = in[98:0] ^ {in[98:0], in[99]};

endmodule
