module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);
    
    // Intermediate signals
    wire w1, w2, w3, w4, w5;
    
    // Logic gates
    xor gate1 (w1, a, b);
    and gate2 (w2, a, w1);
    and gate3 (w3, b, w1);
    and gate4 (w4, c, d);
    or gate5 (w5, w2, w3, w4);
    not gate6 (q, w5);
  
endmodule
