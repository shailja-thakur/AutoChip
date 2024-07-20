module top_module(
  input clk,
  input reset,
  output reg [3:0] q);
  
  // Internal wire to hold the next value of the counter
  wire [3:0] next_q;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      q <= 4'b0001;  // Reset the counter to 1
    else
      q <= next_q;   // Update counter with the next value
  end
  
  // Logic to generate the next value of the counter
  always @(posedge clk) begin
    if (reset)
      next_q <= 4'b0001;  // Reset the next value to 1
    else
      next_q <= q + 1;    // Increment the counter
  end
  
endmodule
