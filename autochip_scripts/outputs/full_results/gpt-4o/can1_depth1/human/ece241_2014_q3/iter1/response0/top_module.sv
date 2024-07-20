module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

assign mux_in[0] =  d & ~c;            // For ab = 00 (column 0)
assign mux_in[1] = ~c & ~d;            // For ab = 01 (column 1)
assign mux_in[2] =  c;                 // For ab = 11 (column 3)
assign mux_in[3] = 1'b1;               // For ab = 10 (column 2)

endmodule
