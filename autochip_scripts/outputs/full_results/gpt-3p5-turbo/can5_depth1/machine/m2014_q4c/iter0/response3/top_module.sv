module top_module (
  input clk,
  input d,
  input r,
  output logic q
);

  // Declare internal signal to store register value
  logic reg_value;

  // Sequential logic triggered on rising edge of the clock
  always_ff @(posedge clk)
  begin
    // Reset condition
    if (r)
      reg_value <= 0;
    // Store data input to register when not reset
    else
      reg_value <= d;
  end

  // Assign the output of the register
  assign q = reg_value;

endmodule
