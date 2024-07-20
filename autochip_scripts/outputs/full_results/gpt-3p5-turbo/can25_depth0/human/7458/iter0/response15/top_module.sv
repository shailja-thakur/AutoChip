module top_module(
    input p1a,
    input p1b,
    input p1c,
    input p1d,
    input p1e,
    input p1f,
    output reg p1y,
    input p2a,
    input p2b,
    input p2c,
    input p2d,
    output reg p2y
);

    wire and1_out;
    wire and2_out;
    wire and3_out;
    wire and4_out;

    // AND gates
    and and1(.a(p1a), .b(p1b), .c(p1c), .z(and1_out));
    and and2(.a(p1d), .b(p1e), .c(p1f), .z(and2_out));
    and and3(.a(p2a), .b(p2b), .z(and3_out));
    and and4(.a(p2c), .b(p2d), .z(and4_out));

    // OR gates
    assign p1y = or(and1_out, and2_out);
    assign p2y = or(and3_out, and4_out);

endmodule
