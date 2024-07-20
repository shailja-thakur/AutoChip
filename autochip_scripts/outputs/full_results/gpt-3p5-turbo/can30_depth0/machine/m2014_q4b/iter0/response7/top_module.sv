module top_module (
    input clk,
    input d,
    input ar,
    output logic q
);
  
  // Create a register for storing the data
  reg logic q_reg;
  
  always_ff @(posedge clk or posedge ar) begin
    if (ar)
      q_reg <= 0; // Reset the register to 0
    else
      q_reg <= d; // Store the value of the data input
  end
  
  assign q = q_reg; // Assign the value of the register output
  
endmodule
