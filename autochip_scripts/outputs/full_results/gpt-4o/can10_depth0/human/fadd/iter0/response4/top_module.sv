module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    assign sum = a ^ b ^ cin;  // Sum is the XOR of the inputs
    assign cout = (a & b) | (b & cin) | (cin & a);  // Carry-out is derived from the majority function

endmodule
