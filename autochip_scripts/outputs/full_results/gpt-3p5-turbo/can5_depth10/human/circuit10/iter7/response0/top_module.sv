module top_module (
  input clk,
  input a,
  input b,
  output reg q,
  output reg state
);

reg q_reg;
reg state_reg;
reg state_next;

always @(posedge clk) begin
  state_reg <= state_next;
  q_reg <= q_reg;
end

always @(*) begin
  state_next = (a & b);
end

assign state = state_reg;
assign q = q_reg;

endmodule
