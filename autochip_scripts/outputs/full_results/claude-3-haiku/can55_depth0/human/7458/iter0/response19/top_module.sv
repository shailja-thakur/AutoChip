module top_module(
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y
);

wire p1_and1, p1_and2;
wire p2_and1, p2_and2;

// Implement the 4 AND gates
assign p1_and1 = p1a & p1b & p1c;
assign p1_and2 = p1d & p1e & p1f;

assign p2_and1 = p2a & p2b;
assign p2_and2 = p2c & p2d;

// Implement the 2 OR gates
assign p1y = p1_and1 | p1_and2;
assign p2y = p2_and1 | p2_and2;

endmodule
