module top_module (
  input clk,
  input d,
  input r,
  output logic q
);

  always_ff @(posedge clk)
  begin
    if (r == 1'b1)          
      q <= 1'b0; // Reset the output to 0 when r is active high
    else
      q <= d; // Assign the input value to output when r is inactive
  end

endmodule
