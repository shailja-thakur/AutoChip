module top_module(
  input x,
  input y,
  output z);

  // Add a reg variable to store the correct value of z
  reg z_reg;

  always @(*) begin
    // Use & operator to perform bitwise AND operation
    z_reg = x & y;
  end

  // Assign z_reg to output z
  assign z = z_reg;

endmodule
