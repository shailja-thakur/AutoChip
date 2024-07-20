module top_module (
  input clk,
  input d,
  input r,
  output logic q
);

  // D flip flop with active high synchronous reset
  always_ff @(posedge clk) begin
    if (r) // If reset is active high
      q <= 0; // Set output to 0
    else
      q <= d; // Else set output to input
  end

endmodule
