module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire sum_w, cout_w1, cout_w2;

    // Half adder for sum
    xor (sum_w, a, b);
    xor (sum, sum_w, cin);

    // Half adder for carry-out
    and (cout_w1, a, b);
    and (cout_w2, a, cin);
    or (cout, cout_w1, cout_w2, cout_w1 & cin);

endmodule
