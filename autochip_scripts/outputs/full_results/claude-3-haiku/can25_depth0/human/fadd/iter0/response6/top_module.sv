module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire sum_wire;
    wire carry1, carry2;

    // Sum
    assign sum_wire = a ^ b ^ cin;
    assign sum = sum_wire;

    // Carry
    assign carry1 = a & b;
    assign carry2 = a & cin;
    assign carry3 = b & cin;
    assign cout = carry1 | carry2 | carry3;

endmodule
