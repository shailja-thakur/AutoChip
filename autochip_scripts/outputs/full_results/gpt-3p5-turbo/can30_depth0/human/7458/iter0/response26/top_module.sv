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
    wire and1_out, and2_out, and3_out, and4_out;

    and gate1(p1a, p1b, p1c, and1_out);
    and gate2(p1d, p1e, p1f, and2_out);
    and gate3(p2a, p2b, and3_out);
    and gate4(p2c, p2d, and4_out);

    or or1(and1_out, and2_out, p1y);
    or or2(and3_out, and4_out, p2y);

endmodule
module and(
    input a,
    input b,
    input c,
    output y
);
    assign y = a & b & c;
endmodule
module or(
    input a,
    input b,
    output y
);
    assign y = a | b;
endmodule
