module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    // Create the internal wires and intermediate signals
    wire w1, w2, w3;
    
    // Create the xor gates for the sum output
    xor_gate (w1, a, b);
    xor_gate (sum, w1, cin);
    
    // Create the and gates for the carry-out output
    and_gate (w2, a, b);
    and_gate (w3, w1, cin);
    or_gate (cout, w2, w3);
    
    // Define the xor gate module
    module xor_gate (
        input a,
        input b,
        output y
    );
        assign y = a ^ b;
    endmodule
module and_gate (
        input a,
        input b,
        output y
    );
        assign y = a & b;
    endmodule
module or_gate (
        input a,
        input b,
        output y
    );
        assign y = a | b;
    endmodule
