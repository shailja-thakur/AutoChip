module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire intermediate_sum;
    wire intermediate_cout;

    // Half adder for a and b
    xor(intermediate_sum, a, b);
    and(intermediate_cout, a, b);

    // Add the carry-in
    xor(sum, intermediate_sum, cin);
    and(cout, intermediate_cout, cin);
    or(cout, intermediate_cout, sum);

endmodule
