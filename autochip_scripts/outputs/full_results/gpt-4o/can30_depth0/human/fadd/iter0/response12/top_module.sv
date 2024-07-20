module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    assign sum = a ^ b ^ cin; // Sum bit calculation
    assign cout = (a & b) | (b & cin) | (cin & a); // Carry-out calculation

endmodule
