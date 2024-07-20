module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire xor_a_b, and_a_b, and_a_cin, and_b_cin;

    // Sum
    assign sum = a ^ b ^ cin;

    // Carry
    assign and_a_b = a & b;
    assign and_a_cin = a & cin;
    assign and_b_cin = b & cin;
    assign cout = and_a_b | and_a_cin | and_b_cin;

endmodule
