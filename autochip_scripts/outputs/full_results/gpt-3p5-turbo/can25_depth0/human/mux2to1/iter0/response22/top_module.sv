module top_module (
  input a,
  input b,
  input sel,
  output out
);

  // Instantiate a 2-to-1 multiplexer
  wire mux_out;
  mux_2to1 mux1 (.a(a), .b(b), .sel(sel), .out(mux_out));
  
  // Assign the output of the multiplexer to the top_module output port
  assign out = mux_out;

endmodule
module mux_2to1 (
  input a,
  input b,
  input sel,
  output reg out
);

  always @(a, b, sel)
  begin
    if (sel == 1'b0)
      out = a;
    else
      out = b;
  end

endmodule
