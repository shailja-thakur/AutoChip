module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

	/* Full Adder implementation */
    wire w1, w2, w3;
    xor x1(.a(a), .b(b), .out(w1)); // XOR gate for a and b inputs
    xor x2(.a(w1), .b(cin), .out(sum)); // XOR gate for sum output
    and a1(.a(a), .b(b), .out(w2)); // AND gate for a and b inputs
    and a2(.a(w1), .b(cin), .out(w3)); // AND gate for XOR output and cin input
    or o1(.a(w2), .b(w3), .out(cout)); // OR gate for AND outputs

endmodule
