module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    wire [99:1] shifted_in;
    
    // Generate the shifted input signal
    assign shifted_in[99:0] = {in[98], in[99:1]};
    
    // Perform bitwise AND operation for out_both
    assign out_both[98:0] = in[98:0] & shifted_in[98:0];
    
    // Perform bitwise OR operation for out_any
    assign out_any[99:0] = in[99:0] | shifted_in[99:0];
    
    // Perform bitwise XOR operation for out_different
    assign out_different[99:1] = in[99:1] ^ shifted_in[99:1];
    
    // Calculate the first bit of the out_different signal
    assign out_different[0] = in[0] ^ shifted_in[99];

endmodule
