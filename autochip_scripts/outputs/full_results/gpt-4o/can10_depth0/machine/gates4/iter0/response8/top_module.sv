module top_module (
    input [3:0] in,
    output out_and,
    output out_or,
    output out_xor
);
    assign out_and = &in; // AND operation on all bits of in[3:0]
    assign out_or = |in;  // OR operation on all bits of in[3:0]
    assign out_xor = ^in; // XOR operation on all bits of in[3:0]
endmodule
