module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire x, y, z;

    // Half adder for a + b
    xor(x, a, b);
    and(y, a, b);

    // Full adder with carry-in
    xor(sum, x, cin);
    and(z, x, cin);
    or(cout, y, z);

endmodule
