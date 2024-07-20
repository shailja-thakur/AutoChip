module top_module (
    input c,
    input d,
    output [3:0] mux_in
);
    assign mux_in[0] = (!c && d) || (c && d) || (c && !d);  // (c=0, d=0, out=0) + (c=0, d=1, out=1) + (c=1, d=0, out=1) = 0 + 1 + 1
    assign mux_in[1] = 0;                                  // (c=0, d=0, out=0) + (c=0, d=1, out=0) + (c=1, d=0, out=0) + (c=1, d=1, out=0) = 0
    assign mux_in[2] = (c && d);                            // (c=0, d=0, out=0) + (c=0, d=1, out=0) + (c=1, d=0, out=0) + (c=1, d=1, out=1) = 1
    assign mux_in[3] = (!c && !d) || (c && d);              // (c=0, d=0, out=1) + (c=0, d=1, out=0) + (c=1, d=0, out=0) + (c=1, d=1, out=1) = 1 + 1

endmodule
