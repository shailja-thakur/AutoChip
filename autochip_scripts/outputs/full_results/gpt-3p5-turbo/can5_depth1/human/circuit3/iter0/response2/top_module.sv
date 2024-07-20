module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);
    
    wire w1, w2, w3, w4;
    and gate1(w1, a, d);
    and gate2(w2, b, c);
    or gate3(w3, w1, w2);
    not gate4(w4, q);
    xor gate5(q, w3, w4);
    
endmodule
