module top_module (
    input clk,
    input d,
    input ar,
    output logic q
);

  // Declare internal signal
  logic q_reg;

  // Assign q_reg to q output
  assign q = q_reg;

  // Sequential logic for the register
  always_ff @(posedge clk or posedge ar) begin
    if (ar) begin
      q_reg <= 0; // Reset the register to 0 when ar is triggered
    end else begin
      q_reg <= d; // Store the value of d in the register when clk is triggered
    end
  end

endmodule
