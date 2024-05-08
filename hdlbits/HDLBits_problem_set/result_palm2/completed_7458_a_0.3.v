module top_module ( 
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );

    wire a1 = p1a & p1b;
    wire a2 = p1c & p1d;
    wire a3 = p1e & p1f;
    wire a4 = p2a & p2b;
    wire a5 = p2c & p2d;

    assign p1y = a1 | a2 | a3 | a4;
    assign p2y = a5;

endmodule