module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Assign values to mux_in based on the given Karnaugh map
    assign mux_in[0] = c | d;     // ab=00, (c=0,d=0) -> 0, (c=1,d=0) -> 1
    assign mux_in[1] = c & ~d;    // ab=01, (c=0,d=1) -> 0, (c=1,d=1) -> 0
    assign mux_in[2] = (c | d);   // ab=11, (c=1,d=1) -> 1
    assign mux_in[3] = (~c | d);  // ab=10, (c=1,d=0) -> 1

endmodule
