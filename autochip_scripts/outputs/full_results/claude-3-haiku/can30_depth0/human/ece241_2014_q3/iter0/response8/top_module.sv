module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire n1, n2, n3;

    assign n1 = c & ~d;
    assign n2 = ~c & d;
    assign n3 = c & d;

    assign mux_in[0] = n1;
    assign mux_in[1] = c;
    assign mux_in[2] = n3;
    assign mux_in[3] = n2;

endmodule
