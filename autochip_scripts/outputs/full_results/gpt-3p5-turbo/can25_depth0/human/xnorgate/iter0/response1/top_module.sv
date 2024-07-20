module top_module(
    input a,
    input b,
    output out
);
    wire a_xor_b;
    
    xor gate1(a_xor_b, a, b);
    not gate2(out, a_xor_b);
    
endmodule
