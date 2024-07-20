module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);
    assign out_both = in[99:1] & in[98:0];
    assign out_any = in | (in << 1);
    
    wire [99:0] temp_diff;
    assign temp_diff = {in[0] ^ in[99], in ^ (in << 1)};
    assign out_different = temp_diff;
endmodule
