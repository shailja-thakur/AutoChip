module top_module (
  input c,
  input d,
  output [3:0] mux_in
);


// Assigning values to the outputs of the 4-to-1 multiplexer based on the given Karnaugh map
assign mux_in[0] = ~(c & d);
assign mux_in[1] = c & ~d;
assign mux_in[2] = c | d;
assign mux_in[3] = ~c | d;

endmodule
