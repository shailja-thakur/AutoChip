module top_module(
  input x,
  input y,
  output z);

  // Add proper delay to the output signal
  reg z_delayed;
  
  always @(x or y) begin
    #5 z_delayed = x & y;
  end

  assign z = z_delayed;

endmodule
