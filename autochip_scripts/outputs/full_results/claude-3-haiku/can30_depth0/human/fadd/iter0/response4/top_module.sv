module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire t1, t2, t3;

    // Sum
    assign sum = a ^ b ^ cin;

    // Carry
    assign t1 = a & b;
    assign t2 = a & cin;
    assign t3 = b & cin;
    assign cout = t1 | t2 | t3;

endmodule
