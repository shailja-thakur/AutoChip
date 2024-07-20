module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    wire w1;
    wire w2;
    wire w3;
    wire w4;
    
    andgate u1 (
        .a(a),
        .b(b),
        .out(w1)
    );
    
    andgate u2 (
        .a(c),
        .b(d),
        .out(w2)
    );
    
    andgate u3 (
        .a(a),
        .b(~b),
        .out(w3)
    );
    
    andgate u4 (
        .a(~c),
        .b(~d),
        .out(w4)
    );
    
    orgate u5 (
        .a(w1),
        .b(w2),
        .out(q)
    );
    
endmodule
module andgate (
    input a,
    input b,
    output out
);

    assign out = a & b;

endmodule
module orgate (
    input a,
    input b,
    output out
);

    assign out = a | b;

endmodule
