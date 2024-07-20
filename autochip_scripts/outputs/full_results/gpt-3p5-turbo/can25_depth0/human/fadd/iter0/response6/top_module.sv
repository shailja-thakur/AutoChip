module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire w1, w2, w3;

    // Internal signals
    xor_gate x1(.a(a), .b(b), .y(w1));     // XOR gate for a and b
    xor_gate x2(.a(w1), .b(cin), .y(sum)); // XOR gate for w1 and cin

    and_gate a1(.a(a), .b(b), .y(w2));      // AND gate for a and b
    and_gate a2(.a(b), .b(cin), .y(w3));    // AND gate for b and cin
    and_gate a3(.a(a), .b(cin), .y(cout));  // AND gate for a and cin

    or_gate o1(.a(w2), .b(w3), .y(cout));   // OR gate for w2 and w3
endmodule
module xor_gate (
    input a,
    input b,
    output y
);
    assign y = a ^ b;
endmodule
module and_gate (
    input a,
    input b,
    output y
);
    assign y = a & b;
endmodule
module or_gate (
    input a,
    input b,
    output y
);
    assign y = a | b;
endmodule
