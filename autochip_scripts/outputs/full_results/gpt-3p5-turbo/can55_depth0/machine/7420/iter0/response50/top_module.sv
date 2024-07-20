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

wire p1y_inv;
wire p2y_inv;

and gate_p1(p1a, p1b, p1c, p1d, p1y_inv);
and gate_p2(p2a, p2b, p2c, p2d, p2y_inv);

not inv_p1(p1y_inv, p1y);
not inv_p2(p2y_inv, p2y);

endmodule
module and(
    input a,
    input b,
    input c,
    input d,
    output y
);

assign y = a & b & c & d;

endmodule
module not(
    input a,
    output z
);

assign z = ~a;

endmodule
