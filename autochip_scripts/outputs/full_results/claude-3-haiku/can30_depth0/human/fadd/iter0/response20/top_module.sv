module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire xor_ab, and_ab, and_ac, and_bc;

    // Sum
    assign sum = a ^ b ^ cin;

    // Carry Out
    assign xor_ab = a ^ b;
    assign and_ab = a & b;
    assign and_ac = a & cin;
    assign and_bc = b & cin;
    assign cout = and_ab | and_ac | and_bc;

endmodule
