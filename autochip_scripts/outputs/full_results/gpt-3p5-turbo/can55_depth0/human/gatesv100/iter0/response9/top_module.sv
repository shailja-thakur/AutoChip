module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    wire [98:0] in_left;
    wire [99:1] in_right;
    
    assign in_left[98] = in[99];
    assign in_left[97:0] = in[98:1];
    
    assign in_right[1:99] = in[0:98];
    assign in_right[0] = in[99];
    
    assign out_both = in[98:0] & in_left;
    assign out_any = in[99:2] | in_right;
    assign out_different = in[98:0] != in_left;

endmodule
