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

    // For p1y
    wire p1_and_logic = p1a & p1b & p1c;
    wire p1_or_logic = p1d | p1e | p1f;
    assign p1y = p1_and_logic & p1_or_logic;

    // For p2y
    wire p2_and_logic = p2a & p2b;
    wire p2_or_logic = p2c | p2d;
    assign p2y = p2_and_logic | p2_or_logic;

endmodule
