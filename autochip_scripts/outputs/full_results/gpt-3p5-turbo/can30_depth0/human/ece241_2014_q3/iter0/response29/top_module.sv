module top_module(
  input c,
  input d,
  output [3:0] mux_in
);
  wire [1:0] ab;
  wire [1:0] cd;
  
  // Convert c and d to 2-bit signals
  assign cd[1] = c;
  assign cd[0] = d;
  
  // Create the multiplexer inputs
  assign mux_in[0] = (ab == 2'b00) ? cd[1] & cd[0] : 1'b0;
  assign mux_in[1] = (ab == 2'b01) ? cd[1] & ~cd[0] : 1'b0;
  assign mux_in[2] = (ab == 2'b11) ? cd[1] | cd[0] : 1'b0;
  assign mux_in[3] = (ab == 2'b10) ? cd[0] : 1'b0;
  
  // Multiplexer selector input
  // Connect a to mux_in[3] and b to mux_in[2]
  assign ab = {mux_in[3], mux_in[2]};
endmodule
