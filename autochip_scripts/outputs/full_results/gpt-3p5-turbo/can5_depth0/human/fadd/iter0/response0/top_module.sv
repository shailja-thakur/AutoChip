module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    // Internal wires declaration
    wire w1, w2, w3;

    // Instantiate full adder
    full_adder FA1(.a(a), .b(b), .cin(cin), .s(sum), .cout(w1));

    // Instantiate half adder
    half_adder HA1(.a(sum), .b(cin), .sum(w2), .carry(w3));

    // Output connections
    assign cout = w1 | w3;

endmodule
