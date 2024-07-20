module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

// Intermediate wire to store the output of the XOR operation
wire xor_out;

// XOR gate for inputs a, b, c, d
assign xor_out = a ^ b ^ c ^ d;

// Inverter for the XOR output
assign q = ~xor_out;

endmodule
