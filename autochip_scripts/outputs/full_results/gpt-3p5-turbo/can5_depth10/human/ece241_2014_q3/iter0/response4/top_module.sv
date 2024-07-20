module top_module (
  input c,
  input d,
  output [3:0] mux_in
);

// Define internal signals
wire m0, m1, m2, m3, m4, m5, m6, m7;

// Implement the logic for each output of the K-map
assign m0 = ~c & ~d;
assign m1 = c & ~d;
assign m2 = c & d;
assign m3 = ~c & d;
assign m4 = ~c & ~d;
assign m5 = c & ~d;
assign m6 = c & d;
assign m7 = c & d;

// Connect the outputs to the multiplexer inputs
assign mux_in[0] = m0;
assign mux_in[1] = m1;
assign mux_in[2] = m2;
assign mux_in[3] = m3;
endmodule
