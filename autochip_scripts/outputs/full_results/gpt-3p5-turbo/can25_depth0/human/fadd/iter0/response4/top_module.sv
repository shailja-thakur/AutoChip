module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    // Internal wires for intermediate calculations
    wire w1, w2, w3;

    // Create individual gates for the full adder
    xor xor1(sum, a, b);
    xor xor2(sum, sum, cin);
    and and1(cout, a, b);
    and and2(w1, a, cin);
    and and3(w2, b, cin);
    or or1(cout, w1, w2);
    or or2(cout, cout, w3);

endmodule
