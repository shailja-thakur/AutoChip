module top_module(
  input x,
  input y,
  output z);

  // Define internal signals
  reg z_internal;

  // Combinational logic
  always @(*) begin
    if (x && !y) begin
      z_internal = 1;
    end else begin
      z_internal = 0;
    end
  end

  // Assign internal signal to output
  assign z = z_internal;

endmodule
