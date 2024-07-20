module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);
    
    wire [99:0] shifted_in;
    
    assign shifted_in = {in[98:0], in[99]}; // Shift input signal by one bit
    
    assign out_both = in[98:0] & shifted_in[99:1]; // Bit-wise AND (99 bits)
    assign out_any = in | shifted_in; // Bit-wise OR (100 bits)
    assign out_different[0] = in[0] ^ shifted_in[99]; // First bit out_both XOR between first and last bit
    assign out_different[99:1] = in[99:1] ^ shifted_in[98:0]; // Bit-wise XOR (99 bits for the rest)
    
endmodule
