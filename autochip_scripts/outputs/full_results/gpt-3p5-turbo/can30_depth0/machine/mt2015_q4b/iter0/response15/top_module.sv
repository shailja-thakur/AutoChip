module top_module(
    input x,
    input y,
    output z
);

// Internal wire for XOR operation
wire xor_output;

// Internal wire for negation operation
wire neg_output;

// XOR gate
assign xor_output = x ^ y;

// Negation gate
assign neg_output = ~xor_output;

// Output assignment
assign z = neg_output;

endmodule
