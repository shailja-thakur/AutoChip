module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different
);
    wire [2:0] and_op;
    wire [3:0] or_op;
    
    assign and_op = in[2:0] & in[3:1];
    assign or_op = in[2:0] | in[3:1];
    
    assign out_both = and_op;
    assign out_any = or_op;
    
    assign out_different = in ^ {in[3:1], in[0]};
    
endmodule
