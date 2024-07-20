module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire x, y, z;

    assign x = c & ~d;
    assign y = ~c & d;
    assign z = c & d;

    assign mux_in[0] = x;
    assign mux_in[1] = y;
    assign mux_in[2] = z;
    assign mux_in[3] = x | z;

endmodule
