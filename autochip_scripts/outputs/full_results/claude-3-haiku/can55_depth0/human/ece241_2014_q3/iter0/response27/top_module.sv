module top_module(
    input c,
    input d,
    output [3:0] mux_in
);

    wire [1:0] mux_sel;
    assign mux_sel = {c, d};

    assign mux_in[0] = mux_sel == 2'b00 ? 1'b1 : 1'b0;
    assign mux_in[1] = mux_sel == 2'b01 ? 1'b1 : 1'b0;
    assign mux_in[2] = (mux_sel == 2'b11) | (mux_sel == 2'b10) ? 1'b1 : 1'b0;
    assign mux_in[3] = (mux_sel == 2'b10) | (mux_sel == 2'b00) ? 1'b1 : 1'b0;

endmodule
