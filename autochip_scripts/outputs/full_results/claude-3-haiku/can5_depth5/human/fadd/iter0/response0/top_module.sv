module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    // Full adder implementation
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (a & cin) | (b & cin);

endmodule
