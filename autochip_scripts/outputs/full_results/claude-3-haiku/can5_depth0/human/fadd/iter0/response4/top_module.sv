module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire ab_and, ac_and, bc_and;
    
    assign sum = a ^ b ^ cin;
    assign ab_and = a & b;
    assign ac_and = a & cin;
    assign bc_and = b & cin;
    assign cout = ab_and | ac_and | bc_and;

endmodule
