module top_module (
    input [3:0] in,
    output out_and,
    output out_or,
    output out_xor
);

    assign out_and = &in;  // Logical AND operation on in[3:0]
    assign out_or = |in;   // Logical OR operation on in[3:0]
    assign out_xor = ^in;  // Logical XOR operation on in[3:0]

endmodule
