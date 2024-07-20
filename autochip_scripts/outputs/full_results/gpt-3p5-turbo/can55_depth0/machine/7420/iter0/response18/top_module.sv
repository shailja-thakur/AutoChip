module top_module(
    input p1a,
    input p1b,
    input p1c,
    input p1d,
    output p1y,
    input p2a,
    input p2b,
    input p2c,
    input p2d,
    output p2y
);
    wire p1y_inverted;
    wire p2y_inverted;
    
    and gate1(p1a, p1b, p1c, p1d, p1y_inverted);
    and gate2(p2a, p2b, p2c, p2d, p2y_inverted);
    
    not inv1(p1y_inverted, p1y);
    not inv2(p2y_inverted, p2y);
    
    // 4-input AND gate
    module and(
        input a,
        input b,
        input c,
        input d,
        output out
    );
        wire and1;
        wire and2;
        wire and3;
        
        and(and1, a, b);
        and(and2, and1, c);
        and(and3, and2, d);
        
        assign out = and3;
    endmodule
module not(
        input in,
        output out
    );
        assign out = ~in;
    endmodule
