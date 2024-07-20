module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire c_not, d_not;

    not(c_not, c);
    not(d_not, d);

    assign mux_in[0] = c_not & d_not;
    assign mux_in[1] = c & d_not;
    assign mux_in[2] = c & d;
    assign mux_in[3] = c_not & d;

endmodule
