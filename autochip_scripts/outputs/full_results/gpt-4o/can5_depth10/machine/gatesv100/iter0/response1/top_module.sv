module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    wire [99:0] shifted_in;
    
    // Right shift of the input
    assign shifted_in = {in[98:0], in[99]};

    // out_both: bit-wise AND operation
    assign out_both = in[99:1] & shifted_in[98:0];

    // out_any: bit-wise OR operation
    assign out_any = in | shifted_in;

    // out_different: bit-wise XOR operation
    assign out_different = in ^ {in[0], shifted_in[99:1]};

endmodule
