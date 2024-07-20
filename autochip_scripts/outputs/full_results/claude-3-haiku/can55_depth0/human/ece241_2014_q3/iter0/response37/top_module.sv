module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire [1:0] temp;

    assign mux_in[0] = 1;
    assign mux_in[1] = c;
    assign mux_in[2] = c | d;
    assign mux_in[3] = c | d;

    assign temp[0] = c;
    assign temp[1] = c | d;

endmodule
