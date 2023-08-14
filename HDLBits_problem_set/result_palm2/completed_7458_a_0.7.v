module top_module ( 
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );

    logic [1:0] and1_out, and2_out, and3_out, and4_out;
    logic [1:0] or1_out, or2_out;

    assign p1y = and1_out & and2_out;
    assign p2y = and3_out & and4_out;

    and (and1_out, p1a, p1b);
    and (and2_out, p1c, p1d);
    and (and3_out, p1e, p1f);
    and (and4_out, p2a, p2b);

    or (or1_out, and1_out, and2_out);
    or (or2_out, and3_out, and4_out);

endmodule