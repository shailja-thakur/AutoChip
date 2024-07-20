module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    // Logic for the sum
    assign sum = a ^ b ^ cin;

    // Logic for the carry-out
    assign cout = (a & b) | (b & cin) | (cin & a);

endmodule
