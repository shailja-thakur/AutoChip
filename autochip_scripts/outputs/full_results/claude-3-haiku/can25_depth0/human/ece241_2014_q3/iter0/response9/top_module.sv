module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire and1, and2, and3, and4;

    // Implement the Karnaugh map using 2-to-1 multiplexers
    assign and1 = d;
    assign and2 = (~c) & (~d);
    assign and3 = c & d;
    assign and4 = c & (~d);

    assign mux_in[0] = and1;
    assign mux_in[1] = and2;
    assign mux_in[2] = and3;
    assign mux_in[3] = and4;

endmodule
