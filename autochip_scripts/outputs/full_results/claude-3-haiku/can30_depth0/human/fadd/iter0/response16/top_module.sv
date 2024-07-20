module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire w1, w2, w3;
    
    // First half adder
    xor(w1, a, b);
    and(w2, a, b);
    
    // Second half adder
    xor(sum, w1, cin);
    and(w3, w1, cin);
    
    // Carry out
    or(cout, w2, w3);

endmodule
