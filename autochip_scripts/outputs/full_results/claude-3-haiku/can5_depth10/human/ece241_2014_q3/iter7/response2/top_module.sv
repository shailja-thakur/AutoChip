module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire [1:0] ab;
    assign ab[0] = c;
    assign ab[1] = d;

    assign mux_in[0] = (~ab[1] & ~ab[0]);
    assign mux_in[1] = (ab[1] & ~ab[0]);
    assign mux_in[2] = (ab[1] & ab[0]);
    assign mux_in[3] = (~ab[1] & ab[0]);

endmodule
