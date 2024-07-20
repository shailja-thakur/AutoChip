module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    // Sum is the XOR of the three inputs
    assign sum = a ^ b ^ cin;
    
    // Carry out is calculated using the formula: (a AND b) OR (b AND cin) OR (a AND cin)
    assign cout = (a & b) | (b & cin) | (a & cin);

endmodule
