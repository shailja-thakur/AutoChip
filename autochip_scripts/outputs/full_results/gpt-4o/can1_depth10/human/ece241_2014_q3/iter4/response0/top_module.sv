module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    assign mux_in[0] = 0;        // cd=00 and ab=00 -> 0
    assign mux_in[1] = ~c & d;   // cd=01 and ab=01 -> 1 when c=0 & d=1
    assign mux_in[2] = c;        // cd=11 and ab=11 -> 1 when c=1 & d=1
    assign mux_in[3] = 1;        // cd=10 and ab=10 -> 1

endmodule
