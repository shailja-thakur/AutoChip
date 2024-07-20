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
    xor gate2 (w2, w1, c);
    or gate3 (w3, w1, d);
    and gate4 (q, w2, w3);
  
endmodule
