module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    wire [98:0] in_shifted;
    wire [99:0] out_any_or;
    
    assign in_shifted = {in[98:0],1'b0};
    assign out_both = in & in_shifted;
    assign out_any_or = in | in_shifted;
    assign out_different = {in[0] ^ in_shifted[99], in ^ in_shifted};

    assign out_any = {1'b0, out_any_or};
    
endmodule
