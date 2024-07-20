module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire a_and_b, a_xor_b, b_xor_cin, a_xor_b_and_cin;

    assign a_and_b = a & b;
    assign a_xor_b = a ^ b;
    assign b_xor_cin = b ^ cin;
    assign a_xor_b_and_cin = a_xor_b & b_xor_cin;

    assign sum = a_xor_b ^ cin;
    assign cout = a_and_b | a_xor_b_and_cin;

endmodule
