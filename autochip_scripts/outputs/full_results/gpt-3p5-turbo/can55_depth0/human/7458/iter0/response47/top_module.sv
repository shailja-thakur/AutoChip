module top_module (
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

    wire p1abcf;
    wire p1def;
    wire p2ab;
    wire p2cd;
    
    assign p1abcf = p1a & p1b & p1c;
    assign p1def = p1d & p1e & p1f;
    assign p1y = p1abcf | p1def;
    
    assign p2ab = p2a & p2b;
    assign p2cd = p2c & p2d;
    assign p2y = p2ab | p2cd;

endmodule
