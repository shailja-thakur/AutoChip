module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    wire [99:0] shifted_in;
    assign shifted_in = {in[98:0], 1'b0}; // Shifting 'in' by one bit
    
    assign out_both = in[99:1] & shifted_in[99:1]; // Bit-wise AND, resulting in 99-bit wide vector
    assign out_any = in | shifted_in; // Bit-wise OR, resulting in 100-bit wide vector
    assign out_different = in ^ {shifted_in[99], shifted_in[99:1]}; // Bit-wise XOR, adjusting for first bit

endmodule
