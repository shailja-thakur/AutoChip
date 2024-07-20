module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);
    wire [99:0] in_shifted;

    assign in_shifted = {in[98:0], 1'b0};    // Shift 'in' by one bit to the right
    
    assign out_both = in[99:1] & in_shifted[98:0];    // AND operation for 99-bit wide vector
    assign out_any = in | in_shifted;                // OR operation for 100-bit wide vector
    assign out_different[99:1] = in[99:1] ^ in_shifted[99:1];   // XOR operation for 99-bit wide vector
    assign out_different[0] = in[0] ^ in_shifted[99];           // XOR operation for the first bit of 'in' and last bit of 'in_shifted'

endmodule
