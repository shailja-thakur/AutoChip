module top_module (
  input clk,
  input a,
  input b,
  output reg q,
  output reg state
);

reg q_temp;
reg state_temp;

always @(posedge clk) begin
  state_temp <= a & b;
  q_temp <= state_temp;
end

always @(posedge clk) begin
  state <= state_temp;
  q <= q_temp;
end

endmodule
