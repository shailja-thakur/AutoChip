module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire sum_temp, cout_temp;

    // Implement the full adder logic
    assign sum_temp = a ^ b ^ cin;
    assign cout_temp = (a & b) | (a & cin) | (b & cin);

    // Assign the outputs
    assign sum = sum_temp;
    assign cout = cout_temp;

endmodule
