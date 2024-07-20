module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    // Fixing the assignment of out_both
    assign out_both = in[98:0] & in[97:0];
    
    // Fixing the assignment of out_any
    assign out_any = {in[99], in[98:0]};
    
    // Fixing the assignment of out_different
    assign out_different = in[98:0] ^ {in[99], in[98]};

endmodule
