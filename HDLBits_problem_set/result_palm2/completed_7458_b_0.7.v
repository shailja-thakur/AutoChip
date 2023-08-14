module top_module ( 
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );

    wire p1and1, p1and2, p1and3, p1and4;
    wire p2and1, p2and2, p2and3, p2and4;
    wire p1or1, p1or2;
    wire p2or1, p2or2;

    assign p1and1 = p1a & p1b;
    assign p1and2 = p1c & p1d;
    assign p1and3 = p1e & p1f;
    assign p1and4 = p1a & p1c & p1e & p1f;

    assign p2and1 = p2a & p2b;
    assign p2and2 = p2c & p2d;
    assign p2and3 = p2e & p2f;
    assign p2and4 = p2a & p2c & p2e & p2f;

    assign p1or1 = p1and1 | p1and2;
    assign p1or2 = p1and3 | p1and4;

    assign p2or1 = p2and1 | p2and2;
    assign p2or2 = p2and3 | p2and4;

    output p1y = p1or1;
    output p2y = p2or2;

endmodule