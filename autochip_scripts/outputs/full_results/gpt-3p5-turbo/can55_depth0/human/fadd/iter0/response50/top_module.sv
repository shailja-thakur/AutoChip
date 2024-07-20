module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    // Internal wires
    wire w1, w2, w3;

    // XOR gate for bit addition
    xor gate1(w1, a, b);

    // XOR gate for carry propagation
    xor gate2(sum, w1, cin);

    // AND gate for carry generation
    and gate3(w2, a, b);

    // AND gate for carry propagation
    and gate4(w3, w1, cin);

    // OR gate for carry out
    or gate5(cout, w2, w3);    
endmodule
