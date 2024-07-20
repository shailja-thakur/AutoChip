module top_module(
    input p1a, 
    input p1b, 
    input p1c, 
    input p1d,
    input p1e,
    input p1f,
    output p1y, 
    input p2a, 
    input p2b, 
    input p2c, 
    input p2d, 
    output p2y
);

    wire p1_and1;
    wire p1_and2;
    
    and_gate u1 (
        .a(p1a),
        .b(p1b),
        .c(p1c),
        .z(p1_and1)
    );
    
    and_gate u2 (
        .a(p1d),
        .b(p1e),
        .c(p1f),
        .z(p1_and2)
    );
    
    or_gate u3 (
        .a(p1_and1),
        .b(p1_and2),
        .z(p1y)
    );
    
    wire p2_and1;
    wire p2_and2;
    
    and_gate u4 (
        .a(p2a),
        .b(p2b),
        .z(p2_and1)
    );
    
    and_gate u5 (
        .a(p2c),
        .b(p2d),
        .z(p2_and2)
    );
    
    or_gate u6 (
        .a(p2_and1),
        .b(p2_and2),
        .z(p2y)
    );

endmodule
