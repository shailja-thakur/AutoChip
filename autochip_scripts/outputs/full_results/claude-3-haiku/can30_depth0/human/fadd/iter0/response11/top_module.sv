module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire a_xor_b;
    wire a_and_b;
    wire cin_and_a_xor_b;

    // Sum calculation
    assign a_xor_b = a ^ b;
    assign sum = a_xor_b ^ cin;

    // Carry calculation
    assign a_and_b = a & b;
    assign cin_and_a_xor_b = cin & a_xor_b;
    assign cout = a_and_b | cin_and_a_xor_b;

endmodule
