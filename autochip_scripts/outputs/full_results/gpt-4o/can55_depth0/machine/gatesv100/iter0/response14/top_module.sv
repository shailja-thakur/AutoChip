module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    // Declare the shifted input signal
    wire [99:0] shifted_in;

    // Shift input vector by one position to the right
    assign shifted_in = {1'b0, in[99:1]};
    
    // Generate the out_both signal using bit-wise AND 
    assign out_both = in[99:1] & in[98:0];
    
    // Generate the out_any signal using bit-wise OR
    assign out_any = in | shifted_in;

    // Generate the out_different signal using bit-wise XOR with the first bit being handled separately
    assign out_different = in ^ shifted_in;

endmodule
