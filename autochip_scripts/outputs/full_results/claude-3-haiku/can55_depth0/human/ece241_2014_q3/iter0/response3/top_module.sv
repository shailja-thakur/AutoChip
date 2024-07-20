module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire a, b;
    wire mux1_out, mux2_out;

    // Implement the Karnaugh map using multiplexers
    assign a = c;
    assign b = d;

    // 2-to-1 multiplexer for mux_in[0]
    assign mux_in[0] = (a & b) ? 1'b1 : 1'b0;

    // 2-to-1 multiplexer for mux_in[1]
    assign mux_in[1] = (~a & b) ? 1'b1 : 1'b0;

    // 2-to-1 multiplexer for mux_in[2]
    assign mux_in[2] = (a & ~b) ? 1'b1 : 1'b0;

    // 4-to-1 multiplexer for mux_in[3]
    assign mux_in[3] = (a & b) ? 1'b1 : (a & ~b) ? 1'b1 : (~a & b) ? 1'b0 : 1'b1;

endmodule
