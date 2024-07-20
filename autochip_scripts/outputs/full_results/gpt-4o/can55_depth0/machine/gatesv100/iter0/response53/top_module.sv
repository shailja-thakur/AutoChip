module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);
    
    // Shifted input vector by one bit to the right, inserting zero at MSB
    wire [99:0] shifted_in = {in[98:0], 1'b0};
    
    // Generate the out_both signal
    assign out_both = in[99:1] & in[98:0];
    
    // Generate the out_any signal
    assign out_any = in | shifted_in;
    
    // Generate the out_different signal
    assign out_different[99] = in[99]; // Use the first bit of in directly for comparison with MSB of shifted input later 
    assign out_different[98:0] = in[98:0] ^ shifted_in[98:0];
    
endmodule
