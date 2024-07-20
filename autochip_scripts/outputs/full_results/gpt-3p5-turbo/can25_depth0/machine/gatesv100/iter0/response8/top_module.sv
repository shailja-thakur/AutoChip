module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    wire [98:0] shifted_in;
    assign shifted_in = {in[98:0], 1'b0};

    assign out_both = in[98:0] & shifted_in;
    assign out_any = in | shifted_in;
   
    wire [99:0] xor_result;
    assign xor_result = in ^ shifted_in;
   
    assign out_different[0] = in[0] ^ shifted_in[99];
    assign out_different[99:1] = xor_result[99:1];

endmodule
