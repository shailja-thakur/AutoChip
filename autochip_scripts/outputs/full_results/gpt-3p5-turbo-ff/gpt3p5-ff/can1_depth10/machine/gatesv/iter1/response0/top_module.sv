module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different
);
    
    assign out_both = in[0] & in[3];
    assign out_any = in[0] | in[3];
    assign out_different = in ^ (in[3:1] & {1'b0, in[0]});
    
endmodule
