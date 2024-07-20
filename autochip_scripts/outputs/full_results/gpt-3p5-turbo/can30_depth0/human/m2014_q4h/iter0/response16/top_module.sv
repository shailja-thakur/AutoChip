module top_module(
  input in,
  output out);
  
  reg out;

  always @* begin
    out = in;
  end

endmodule
