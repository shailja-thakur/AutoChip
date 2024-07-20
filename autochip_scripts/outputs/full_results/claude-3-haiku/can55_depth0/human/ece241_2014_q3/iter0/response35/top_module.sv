module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire c_not, d_not;
    wire and1, and2, and3, and4;

    // Implement the Karnaugh map using 2-to-1 multiplexers
    not(c_not, c);
    not(d_not, d);

    and(and1, c_not, d_not);
    and(and2, c_not, d);
    and(and3, c, d);
    and(and4, c, d_not);

    assign mux_in[0] = and1;
    assign mux_in[1] = and2;
    assign mux_in[2] = and3;
    assign mux_in[3] = and4;

endmodule
