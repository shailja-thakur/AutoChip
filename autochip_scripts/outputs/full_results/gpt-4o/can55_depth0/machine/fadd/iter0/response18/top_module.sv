module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    // Intermediate wire to hold the sum of a, b, and cin
    wire sum_temp;

    // Calculate the intermediate sum of a and b, plus cin
    assign sum_temp = a + b + cin;

    // Calculate sum as the least significant bit of the intermediate sum
    assign sum = sum_temp % 2;

    // Calculate cout as 1 if the sum of a, b, and cin is greater than or equal to 2, else 0
    assign cout = sum_temp >= 2;

endmodule
