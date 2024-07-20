module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    wire [99:0] in_shifted;
    
    // Shift the input vector by one bit to the right
    assign in_shifted = {1'b0, in[99:1]};
    
    // Generate out_both by performing bit-wise AND operation
    assign out_both = in[98:0] & in_shifted[98:0];  // 99-bit wide

    // Generate out_any by performing bit-wise OR operation
    assign out_any = in | in_shifted;

    // Generate out_different by performing bit-wise XOR operation
    assign out_different = in ^ in_shifted;

endmodule
