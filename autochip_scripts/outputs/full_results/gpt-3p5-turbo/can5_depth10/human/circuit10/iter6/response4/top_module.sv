module top_module (
  input clk,
  input a,
  input b,
  output reg q,
  output state
);

reg state_next;

always @(posedge clk) begin
  if (a & b)
    state_next <= 1'b1;
  else
    state_next <= 1'b0;
end

always @(posedge clk) begin
  state <= state_next;
end

always @(posedge clk) begin
  if (state == 1'b1)
    q <= 1'b1;
  else
    q <= 1'b0;
end

endmodule
