module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire sum_temp, cout_temp1, cout_temp2;

    // Half adder for a + b
    assign sum_temp = a ^ b;
    assign cout_temp1 = a & b;

    // Half adder for sum_temp + cin
    assign sum = sum_temp ^ cin;
    assign cout_temp2 = sum_temp & cin;

    // OR gate for carry out
    assign cout = cout_temp1 | cout_temp2;

endmodule
