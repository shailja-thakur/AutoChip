module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    wire [99:0] in_shifted;
    
    assign in_shifted = {in[98:0], 1'b0}; // Shift in by one bit to the right, filling LSB with 0
    
    assign out_both = in[99:1] & in_shifted[98:0]; // Bit-wise AND operation
    assign out_any = in | in_shifted;              // Bit-wise OR operation
    assign out_different = in ^ {in_shifted[99], in[98:0]}; // Bit-wise XOR operation

endmodule
