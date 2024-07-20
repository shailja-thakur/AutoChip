module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire ab_xor, ab_and, ac_xor, ac_and, bc_xor, bc_and;

    // Sum
    assign ab_xor = a ^ b;
    assign ac_xor = ab_xor ^ cin;
    assign sum = ac_xor;

    // Carry
    assign ab_and = a & b;
    assign ac_and = ab_xor & cin;
    assign bc_and = b & cin;
    assign cout = ab_and | ac_and | bc_and;

endmodule
