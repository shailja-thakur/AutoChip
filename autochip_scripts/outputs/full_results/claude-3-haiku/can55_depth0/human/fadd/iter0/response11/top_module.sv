module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire sum_temp;
    wire carry1, carry2;

    // Sum
    assign sum_temp = a ^ b ^ cin;
    assign sum = sum_temp;

    // Carry
    assign carry1 = a & b;
    assign carry2 = a & cin;
    assign carry3 = b & cin;
    assign cout = carry1 | carry2 | carry3;

endmodule
