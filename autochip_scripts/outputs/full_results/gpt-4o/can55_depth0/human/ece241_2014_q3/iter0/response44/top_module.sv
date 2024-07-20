module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    assign mux_in[0] = (~c & ~d) | (c & ~d) | (c & d);   // When {a,b} = 00
    assign mux_in[1] = 1'b0;                            // When {a,b} = 01
    assign mux_in[2] = (c & d);                         // When {a,b} = 11
    assign mux_in[3] = (~c & d) | (c & d);              // When {a,b} = 10

endmodule
