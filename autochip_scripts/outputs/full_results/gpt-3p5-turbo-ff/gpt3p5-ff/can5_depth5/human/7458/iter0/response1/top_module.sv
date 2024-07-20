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
  
    assign and1_out = p1a & p1b & p1c;
    assign and2_out = p1d & p1e & p1f;
  
    assign p1y = and1_out | and2_out;
  
    assign p2y = (p2a & p2b) | (p2c & p2d);
  
endmodule
