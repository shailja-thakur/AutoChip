module top_module (
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

wire p1and;
wire p2and;

and gate_p1(p1a, p1b, p1c, p1d, p1and);
and gate_p2(p2a, p2b, p2c, p2d, p2and);

not inv_p1(p1and, p1y);
not inv_p2(p2and, p2y);

endmodule
module and(
    input a,
    input b,
    input c,
    input d,
    output out
);

wire wire_ab;
wire wire_cd;
wire out_temp;

and2x2 and2_1(a, b, wire_ab);
and2x2 and2_2(c, d, wire_cd);
and2x2 and2_3(wire_ab, wire_cd, out_temp);
and2_4(out_temp, out);

endmodule
module and2x2(
    input a,
    input b,
    output out
);

and and1(a, b, out);

endmodule
module not(
    input a,
    output out
);

wire temp;

assign temp = ~a;
assign out = temp;

endmodule
