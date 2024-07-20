module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    // Internal signals
    wire x1, x2, x3;
    wire c1, c2, c3;

    // Instantiate XOR and AND gates
    xor_gate xor1(.a(a), .b(b), .out(x1));
    xor_gate xor2(.a(x1), .b(cin), .out(sum));
    and_gate and1(.a(x1), .b(cin), .out(c1));
    and_gate and2(.a(a), .b(b), .out(x2));
    and_gate and3(.a(x1), .b(x2), .out(x3));
    and_gate and4(.a(a), .b(b), .out(c2));
    or_gate or1(.a(c1), .b(x3), .out(cout));
    or_gate or2(.a(c2), .b(x2), .out(c3));

endmodule
