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

wire p1_ab_and;
wire p1_de_and;
wire p2_ab_and;
wire p2_cd_and;

assign p1_ab_and = p1a & p1b & p1c;
assign p1_de_and = p1d & p1e & p1f;
assign p2_ab_and = p2a & p2b;
assign p2_cd_and = p2c & p2d;

assign p1y = p1_ab_and | p1_de_and;
assign p2y = p2_ab_and | p2_cd_and;

endmodule
