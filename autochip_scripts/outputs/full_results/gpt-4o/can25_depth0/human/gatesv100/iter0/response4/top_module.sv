module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    // Generate out_both[98:0]
    assign out_both = in[98:0] & in[99:1];
    
    // Generate out_any[99:1]
    assign out_any = in[99:1] | in[98:0];
    
    // Generate out_different[99:0]
    assign out_different[99:1] = in[99:1] ^ in[98:0];
    assign out_different[0] = in[99] ^ in[0];

endmodule
