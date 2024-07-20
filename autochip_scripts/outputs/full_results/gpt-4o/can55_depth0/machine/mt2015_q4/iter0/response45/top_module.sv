module top_module(
    input x,
    input y,
    output z);

    wire intermediate1;
    wire intermediate2;

    // First Gate: AND gate
    and u1 (intermediate1, x, y);
    
    // Second Gate: OR gate
    or u2 (intermediate2, y, x);
    
    // Third Gate: XOR gate
    xor u3 (z, intermediate1, intermediate2);

endmodule
