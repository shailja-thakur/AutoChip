module top_module(
  input clk,
  input [7:0] d,
  input reset,
  output reg [7:0] q);

reg [7:0] q_next;  // Next state of the output register

always @(posedge clk) begin
  if (reset)
    q <= 8'b0;  // Reset the output register to zero
  else
    q <= q_next; // Update the output register with the next state
end

// Create 8 D flip-flops
// Each D flip-flop has an active-high synchronous reset

always @(posedge clk) begin
  if (reset)
    q_next <= 8'b0;  // Reset the next state to zero
  else
    q_next <= d;     // Update the next state with the input d
end

endmodule
