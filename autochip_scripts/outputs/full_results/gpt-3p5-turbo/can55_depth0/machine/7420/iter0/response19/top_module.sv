module top_module(
    input p1a,
    input p1b,
    input p1c,
    input p1d,
    output p1y,
    input p2a,
    input p2b,
    input p2c,
    input p2d,
    output p2y
);

wire p1_out;
wire p2_out;

and #(4) u1 (.a({p1a, p1b, p1c, p1d}), .z(p1_out));
and #(4) u2 (.a({p2a, p2b, p2c, p2d}), .z(p2_out));

not u3 (.a(p1_out), .z(p1y));
not u4 (.a(p2_out), .z(p2y));

endmodule
