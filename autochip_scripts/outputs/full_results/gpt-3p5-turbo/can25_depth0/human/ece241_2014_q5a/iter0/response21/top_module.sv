module top_module (
  input clk,
  input areset,
  input x,
  output reg z
);

// Internal state
reg s0, s1, s2;

// State machine
always @(posedge clk, posedge areset) begin
  if (areset)
    s0 <= 1'b0;
  else begin
    s0 <= x ^ 1'b1;
    s1 <= s0;
    s2 <= s1;
  end
end

// Output assignment
always @(s2) begin
  z <= s2;
end

endmodule
