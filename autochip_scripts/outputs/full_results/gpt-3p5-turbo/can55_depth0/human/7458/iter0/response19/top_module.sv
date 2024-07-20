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

    wire and1_out;
    wire and2_out;
    wire and3_out;
    wire and4_out;

    assign p1y = and1_out | and2_out;
    assign p2y = and3_out | and4_out;
  
    and gate1(
        .a(p1a),
        .b(p1b),
        .c(p1c),
        .out(and1_out)
    );
  
    and gate2(
        .a(p1d),
        .b(p1e),
        .c(p1f),
        .out(and2_out)
    );
  
    and gate3(
        .a(p2a),
        .b(p2b),
        .out(and3_out)
    );
  
    and gate4(
        .a(p2c),
        .b(p2d),
        .out(and4_out)
    );
  
endmodule
