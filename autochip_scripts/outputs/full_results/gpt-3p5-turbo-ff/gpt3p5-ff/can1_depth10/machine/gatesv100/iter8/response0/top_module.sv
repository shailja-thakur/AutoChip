module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);
    // Internal wire for shifted input
    wire [99:0] shifted_in;
    
    // Generate shifted input by shifting the input vector by one bit
    assign shifted_in = {in[98:0], in[99]};
    
    // Perform bit-wise AND operation on input and shifted input for generating out_both
    assign out_both = in[97:0] & shifted_in[97:0];
    
    // Perform bit-wise OR operation on input and shifted input for generating out_any
    assign out_any = in | shifted_in;
    
    // Generate out_different by performing bit-wise XOR operation on input and shifted input
    assign out_different = {in[0] ^ shifted_in[99], in[99:1] ^ shifted_in[98:0], in[99] ^ shifted_in[0]};
endmodule
