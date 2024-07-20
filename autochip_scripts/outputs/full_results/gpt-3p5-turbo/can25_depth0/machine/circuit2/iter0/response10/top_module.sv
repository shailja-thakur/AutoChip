module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
    wire xor_output;
    
    xor u1 (
        .a(a),
        .b(b),
        .o(xor_output)
    );
    
    xor u2 (
        .a(xor_output),
        .b(c),
        .o(xor_output)
    );
    
    xor u3 (
        .a(xor_output),
        .b(d),
        .o(xor_output)
    );
    
    not u4 (
        .a(xor_output),
        .o(q)
    );
    
endmodule
module xor (
    input a,
    input b,
    output o
);
    assign o = a ^ b;
endmodule
module not (
    input a,
    output o
);
    assign o = ~a;
endmodule
