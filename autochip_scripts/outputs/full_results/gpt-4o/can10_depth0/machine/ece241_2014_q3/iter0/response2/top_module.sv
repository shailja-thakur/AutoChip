module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    assign mux_in[0] = c | d;  // First bit is logical OR of c and d
    assign mux_in[1] = 1'b0;   // Second bit is 0
    assign mux_in[2] = ~d;     // Third bit is logical NOT of d
    assign mux_in[3] = c & d;  // Fourth bit is logical AND of c and d

endmodule
