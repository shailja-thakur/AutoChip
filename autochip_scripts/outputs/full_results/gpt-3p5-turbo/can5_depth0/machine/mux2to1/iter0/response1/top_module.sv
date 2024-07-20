module top_module (
  input a,
  input b,
  input sel,
  output out
);
  wire mux_out;
  
  // Mux implementation
  assign mux_out = sel ? b : a;
  
  // Output assignment
  assign out = mux_out;
endmodule
