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

wire p1_and1, p1_and2, p2_and1, p2_and2;

// Four AND gates
assign p1_and1 = p1a & p1b & p1c;
assign p1_and2 = p1d & p1e & p1f;
assign p2_and1 = p2a & p2b;
assign p2_and2 = p2c & p2d;

// Two OR gates
assign p1y = p1_and1 | p1_and2;
assign p2y = p2_and1 | p2_and2;

endmodule
