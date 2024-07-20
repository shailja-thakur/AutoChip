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

    assign a_xor_b = a ^ b;
    assign a_and_b = a & b;
    assign cin_and_a_xor_b = cin & a_xor_b;
    assign sum = a_xor_b ^ cin;
    assign cout = a_and_b | cin_and_a_xor_b;

endmodule
