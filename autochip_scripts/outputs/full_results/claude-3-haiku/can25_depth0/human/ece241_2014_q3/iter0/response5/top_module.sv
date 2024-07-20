module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire nand_cd;
    wire or_cd;
    wire mux_out;

    // Implement the Karnaugh map using a 4-to-1 multiplexer and 2-to-1 multiplexers
    assign nand_cd = ~(c & d);
    assign or_cd = c | d;
    assign mux_in[0] = 1'b1;
    assign mux_in[1] = 1'b0;
    assign mux_in[2] = or_cd;
    assign mux_in[3] = nand_cd;

endmodule
