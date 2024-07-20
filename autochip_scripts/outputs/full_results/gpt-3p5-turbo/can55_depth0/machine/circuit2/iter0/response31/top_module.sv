module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);
    
    wire w1, w2, w3, w4, res;
    
    xor gate1 (a, b, w1);
    xor gate2 (c, d, w2);
    xor gate3 (w1, w2, w3);
    not gate4 (w3, res);
    
    assign q = res;
    
endmodule
