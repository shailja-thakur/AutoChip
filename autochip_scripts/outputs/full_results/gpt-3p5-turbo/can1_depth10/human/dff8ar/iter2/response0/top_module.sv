module top_module(
  input clk,
  input [7:0] d,
  input areset,
  output reg [7:0] q
);

  reg [7:0] q_next; // Next state of the output

  always @(posedge clk or posedge areset) begin
    if (areset)
      q <= 8'b00000000; // Reset the output to 0
    else
      q <= q_next; // Update the output with the next state
  end

  // Create 8 D flip-flops with active high asynchronous reset
  always @(posedge clk) begin
    if (areset)
      q_next <= 8'b00000000; // Reset the next state to 0
    else
      q_next <= d; // Assign input to the next state
  end

endmodule
