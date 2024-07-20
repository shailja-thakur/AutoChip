module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire w0, w1, w2, w3;

    and (w0, c, d);
    not (w0, w0);
    and (w1, c, ~d);
    and (w2, ~c, d);
    and (w3, ~c, ~d);

    assign mux_in[0] = ~w0;
    assign mux_in[1] = w1;
    assign mux_in[2] = w2;
    assign mux_in[3] = w3;

endmodule
