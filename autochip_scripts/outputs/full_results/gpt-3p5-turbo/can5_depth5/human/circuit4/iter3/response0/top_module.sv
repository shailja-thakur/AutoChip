module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg q
);

    // Intermediate signals
    wire w1, w2, w3;
    
    // Logic gates
    xor gate1 (w1, a, b);
    xor gate2 (w2, c, d); // Changed from and to xor
    and gate3 (w3, w1, w2); // Changed from and to xor
    or gate4 (q, w1, w2, w3);
  
endmodule
