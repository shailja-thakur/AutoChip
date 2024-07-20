module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);
    
    wire [98:0] both;
    wire [99:1] any;
    wire [99:0] different;
    
    assign both = in[98:0] & in[99:1];
    assign out_both = {1'b0, both};
    
    assign any = in | {in[99], in[98:1]};
    assign out_any = {any, 1'b0};
    
    assign different = in ^ {in[99], in[98:0]};
    assign out_different = different;
    
endmodule
