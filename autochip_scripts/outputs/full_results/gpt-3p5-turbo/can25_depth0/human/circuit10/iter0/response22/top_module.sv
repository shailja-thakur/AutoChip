module top_module (
  input clk,
  input a,
  input b,
  output reg q,
  output reg state
);

reg q_delay;
reg state_delay;

always @(posedge clk) begin
  q_delay <= a & ~b;
  state_delay <= q_delay;
end

assign q = q_delay;
assign state = state_delay;

endmodule
