module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire sum_wire;
    wire carry_wire1;
    wire carry_wire2;

    // Half adder for a + b
    xor (sum_wire, a, b);
    and (carry_wire1, a, b);

    // Full adder with carry-in
    xor (sum, sum_wire, cin);
    and (carry_wire2, sum_wire, cin);
    or (cout, carry_wire1, carry_wire2);

endmodule
