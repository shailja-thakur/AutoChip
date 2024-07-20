module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    assign sum = a ^ b ^ cin;        // Sum calculation using XOR
    assign cout = (a & b) | (b & cin) | (cin & a);  // Carry-out calculation using OR of ANDs

endmodule
