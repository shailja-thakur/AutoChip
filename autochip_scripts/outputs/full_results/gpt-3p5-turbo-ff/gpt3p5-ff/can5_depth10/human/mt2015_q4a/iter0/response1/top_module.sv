module top_module(
    input x,
    input y,
    output z
    );

    // Internal wire declaration
    wire w1;

    // XOR gate to compute x^y
    xor_gate xor1(
        .a(x),
        .b(y),
        .z(w1)
        );

    // AND gate to compute (x^y) & x
    and_gate and1(
        .a(w1),
        .b(x),
        .z(z)
        );

    // Definition of the XOR gate
    module xor_gate(
        input a,
        input b,
        output z
        );
    
        assign z = a ^ b;
        
    endmodule
module and_gate(
        input a,
        input b,
        output z
        );
    
        assign z = a & b;
        
    endmodule
