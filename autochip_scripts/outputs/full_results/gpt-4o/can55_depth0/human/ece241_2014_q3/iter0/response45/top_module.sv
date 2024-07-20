module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    assign mux_in[0] = (~c & ~d) | (c & ~d) | (c & d);    // Result is '1'
    assign mux_in[1] = 1'b0;                              // Result is '0'
    assign mux_in[2] = (~c & ~d);                         // Result is '0'
    assign mux_in[3] = (~c & ~d) | (c & ~d);              // Result is '1'

endmodule
