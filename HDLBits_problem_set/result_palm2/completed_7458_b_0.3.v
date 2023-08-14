module top_module ( 
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );

    wire a1, a2, a3, a4, b1, b2, b3, b4;
    assign p1y = a1 & a2 & a3 & a4;
    assign p2y = b1 & b2 & b3 & b4;

    and gate1 (a1, p1a, p1b);
    and gate2 (a2, p1c, p1d);
    and gate3 (a3, p1e, p1f);
    and gate4 (a4, p2a, p2b);

    or gate5 (b1, a1, a2);
    or gate6 (b2, a3, a4);
    or gate7 (b3, p1c, p1d);
    or gate8 (b4, p1e, p1f);

endmodule