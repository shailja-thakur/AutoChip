module top_module (
  input clk,
  input d,
  input r,
  output logic q
);

  // Instantiate registers
  reg q_reg; // Output register
  reg q_reg_next; // Next state for output register

  always_ff @(posedge clk or posedge r) begin
    if (r)
      q_reg_next <= 0; // Reset output to 0 when reset is asserted
    else
      q_reg_next <= d; // Assign input to output register
  end

  always_ff @(posedge clk) begin
    q_reg <= q_reg_next; // Update output register with next state
  end

  assign q = q_reg; // Output the value of the output register

endmodule
