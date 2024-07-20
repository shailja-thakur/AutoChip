module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

assign mux_in[0] = (~c & ~d) ? 0 :
                   (~c &  d) ? 1 :
                   ( c &  d) ? 1 :
                   ( c & ~d) ? 1 : 0;

assign mux_in[1] = 0; // For ab = 01, output is 0 for all cd combinations

assign mux_in[2] = ( c &  d) ? 1 :
                   ( c & ~d) ? 1 : 0;

assign mux_in[3] = (~c & ~d) ? 1 :
                   ( c & ~d) ? 1 : 0;

endmodule
