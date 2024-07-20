module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire mux1_out, mux2_out, mux3_out;

    // First 2:1 mux
    assign mux1_out = (c & d) | (~c & d);

    // Second 2:1 mux
    assign mux2_out = (c & ~d) | (~c & d);

    // Third 2:1 mux
    assign mux3_out = (c & d) | (c & ~d) | (~c & d);

    // 4:1 mux inputs
    assign mux_in = {mux3_out, mux2_out, mux1_out, 1'b1};

endmodule
