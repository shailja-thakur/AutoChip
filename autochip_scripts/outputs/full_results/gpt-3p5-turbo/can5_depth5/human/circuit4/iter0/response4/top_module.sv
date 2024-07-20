module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);
    
    // Intermediate signals
    wire w1, w2, w3;
    
    // Logic gates
    xor gate1 (w1, a, b);
    and gate2_1 (w2, c, d);
    and gate2_2 (w3, a, b);
    or gate3 (q, w1, w2, w3);
  
endmodule
