module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);
    
    wire [98:0] shifted_in;
    
    assign shifted_in = {in[98:0], in[99]};
    
    assign out_both = in & shifted_in;
    assign out_any = in | shifted_in;
    
    assign out_different = {in[0] ^ shifted_in[98], in[1:99] ^ shifted_in[0:98]};
    
endmodule
