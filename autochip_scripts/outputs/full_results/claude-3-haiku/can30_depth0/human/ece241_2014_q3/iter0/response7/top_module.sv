module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire a, b;
    wire m1, m2, m3;

    // Implement the Karnaugh map using 2-to-1 multiplexers
    assign a = c;
    assign b = d;

    assign m1 = (a & ~b) | (~a & b);
    assign m2 = (a & b) | (~a & ~b);
    assign m3 = (a & b) | (a & ~b) | (~a & b);

    // Connect the 2-to-1 mux outputs to the 4-to-1 mux inputs
    assign mux_in[0] = 1;
    assign mux_in[1] = m1;
    assign mux_in[2] = m2;
    assign mux_in[3] = m3;

endmodule
