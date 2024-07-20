module top_module(
  input clk,
  input slowena,
  input reset,
  output reg [3:0] q);

  always @(posedge clk or posedge reset) begin
    if (reset) // Reset the counter to 0 when reset is high
      q <= 4'b0000;
    else if (slowena) // Increment the counter when slowena is high
      q <= q + 1;
  end

endmodule
