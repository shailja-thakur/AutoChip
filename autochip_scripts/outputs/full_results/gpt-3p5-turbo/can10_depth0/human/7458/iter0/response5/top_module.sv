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

    wire p1and1, p1and2, p2and1, p2and2;
    
    and(p1and1, p1a, p1b, p1c);
    and(p1and2, p1d, p1e, p1f);
    or(p1y, p1and1, p1and2);
    
    and(p2and1, p2a, p2b);
    and(p2and2, p2c, p2d);
    or(p2y, p2and1, p2and2);

endmodule
