module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire temp1, temp2, temp3;

    // Implement the full adder logic
    assign temp1 = a ^ b;
    assign temp2 = a & b;
    assign temp3 = temp1 & cin;
    assign sum = temp1 ^ cin;
    assign cout = temp2 | temp3;

endmodule
