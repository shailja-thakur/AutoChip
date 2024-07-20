module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire [1:0] mux2_out;

    // Implement the logic using two 2-to-1 multiplexers
    assign mux_in[0] = (~c & ~d) | (c & d);
    assign mux_in[1] = c;
    assign mux_in[2] = (~c & d) | (c & ~d) | (c & d);
    assign mux_in[3] = (~c & d) | (c & ~d) | (c & d);

endmodule
