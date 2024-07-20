module top_module (
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] s,
  output reg overflow
);

  // Declare internal signals
  reg signed [8:0] sum; // Sum of a and b (including carry bit)
  
  // Perform the addition operation
  always @(*) begin // Use combinational logic
    sum = a + b; // Add a and b
    
    // Check for carry
    if (sum[8] == 1'b1) // MSB is 1
      overflow = 1'b1; // Set overflow to 1
    else
      overflow = 1'b0; // Set overflow to 0
  end

  // Assign outputs
  always @(posedge clk) begin
    s <= sum[7:0]; // Output the lower 8 bits of the sum
  end

endmodule
