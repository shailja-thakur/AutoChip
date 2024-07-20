module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);
    assign sum = a ^ b ^ cin; // Sum is the XOR of the three inputs
    assign cout = (a & b) | (b & cin) | (cin & a); // Cout is 1 if any two or more inputs are 1

endmodule
