module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    wire [99:0] shifted_in;
    
    assign shifted_in = {in[98:0], 1'b0};  // Shift `in` to the right by 1 bit.
    
    assign out_both = in[99:1] & shifted_in[99:1];  // Bit-wise AND, 99-bit wide.
    assign out_any  = in | shifted_in;             // Bit-wise OR, 100-bit wide.
    assign out_different  = in ^ {shifted_in[98:0], in[99]};  // {shifted_in[98:0], in[99]} aligns the last bit of shifted_in to the first bit of in for XOR.

endmodule
