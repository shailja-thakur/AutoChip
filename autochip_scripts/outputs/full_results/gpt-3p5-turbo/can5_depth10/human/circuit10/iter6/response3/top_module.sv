module top_module (
  input clk,
  input a,
  input b,
  output reg q,
  output reg state
);

reg q_next;
reg state_next;

always @(posedge clk) begin
  state_next <= (a & b);
end

always @(posedge clk) begin
  q_next <= state_next;
end

always @(posedge clk) begin
  state <= state_next;
end

always @(posedge clk) begin
  q <= q_next;
end

endmodule
