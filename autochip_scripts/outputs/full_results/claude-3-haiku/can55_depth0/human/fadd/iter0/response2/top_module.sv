module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire a_xor_b, a_and_b, b_and_cin, a_and_cin;

    // Sum
    assign sum = a ^ b ^ cin;

    // Carry
    assign a_xor_b = a ^ b;
    assign a_and_b = a & b;
    assign b_and_cin = b & cin;
    assign a_and_cin = a & cin;
    assign cout = a_and_b | b_and_cin | a_and_cin;

endmodule
