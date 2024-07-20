module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    assign sum = a ^ b ^ cin;       // Sum is XOR of a, b and cin
    assign cout = (a & b) | (b & cin) | (cin & a);  // Carry-out is calculated by majority function

endmodule
