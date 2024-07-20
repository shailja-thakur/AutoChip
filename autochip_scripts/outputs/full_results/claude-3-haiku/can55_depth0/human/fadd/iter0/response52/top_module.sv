module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire w1, w2, w3;

    // Sum logic
    assign sum = a ^ b ^ cin;

    // Carry logic
    assign w1 = a & b;
    assign w2 = a & cin;
    assign w3 = b & cin;
    assign cout = w1 | w2 | w3;

endmodule
