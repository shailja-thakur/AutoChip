module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire w1, w2, w3;

    // Half adder for a + b
    assign w1 = a ^ b;
    assign w2 = a & b;

    // Full adder with cin
    assign sum = w1 ^ cin;
    assign w3 = w1 & cin;
    assign cout = w2 | w3;

endmodule
