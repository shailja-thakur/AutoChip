module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire [1:0] mux_sel;
    wire mux2_out;

    // Implement the Karnaugh map using 2-to-1 multiplexers
    assign mux_sel = {c, d};
    assign mux_in[0] = 1'b1;
    assign mux_in[1] = 1'b0;
    assign mux_in[2] = mux2_out;
    assign mux_in[3] = 1'b1;

    // Implement the 2-to-1 multiplexer for mux_in[2]
    assign mux2_out = (mux_sel == 2'b11) ? 1'b1 : 1'b0;

endmodule
