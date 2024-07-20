module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

assign mux_in[0] = c | d; // First bit is assigned to the logical OR of the two inputs c and d
assign mux_in[1] = 1'b0;  // Second bit is assigned to 0
assign mux_in[2] = ~d;    // Third bit is assigned to the logical NOT of input d
assign mux_in[3] = c & d; // Fourth bit is assigned to the logical AND of the two inputs c and d

endmodule
