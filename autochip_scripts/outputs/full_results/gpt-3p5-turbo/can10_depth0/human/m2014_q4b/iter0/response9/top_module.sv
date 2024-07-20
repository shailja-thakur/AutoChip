module top_module (
    input clk,    // Clock input
    input d,      // Data input
    input ar,     // Asynchronous reset
    output logic q // Output Q
);
  
  // Declare internal signals
  logic q_reg;    // Output Q register
  
  // Positive edge triggered D flip flop
  always_ff @(posedge clk or posedge ar) begin
    if (ar)
      q_reg <= 1'b0; // If asynchronous reset is active, set Q to 0
    else
      q_reg <= d;    // If positive edge triggered, update Q with D input
  end
  
  // Assign output
  assign q = q_reg;
  
endmodule
