module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    // Internal wires and registers
    wire w1, w2, w3;
    reg s1, s2, s3;

    // First stage
    xor gate1 (.a(a), .b(b), .o(w1));
    xor gate2 (.a(w1), .b(cin), .o(sum));
    and gate3 (.a(a), .b(b), .o(w2));
    and gate4 (.a(w1), .b(cin), .o(w3));
    or gate5 (.a(w2), .b(w3), .o(cout));
    
    // Second stage
    not gate6 (.a(w1), .o(s1));
    not gate7 (.a(cin), .o(s2));
    not gate8 (.a(w2), .o(s3));

endmodule
