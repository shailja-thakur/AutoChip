module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    // Create internal wires
    wire w1, w2, w3;

    // Create XOR gates
    assign w1 = a ^ b;
    assign sum = w1 ^ cin;

    // Create AND gates
    assign w2 = a & b;
    assign w3 = w1 & cin;

    // Create OR gate
    assign cout = w2 | w3;

endmodule
