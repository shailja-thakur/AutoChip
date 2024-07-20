module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire sum_temp;
    wire cout_temp;

    // Half adder for a + b
    assign sum_temp = a ^ b;
    assign cout_temp = a & b;

    // Full adder with carry-in
    assign sum = sum_temp ^ cin;
    assign cout = cout_temp | (sum_temp & cin);

endmodule
