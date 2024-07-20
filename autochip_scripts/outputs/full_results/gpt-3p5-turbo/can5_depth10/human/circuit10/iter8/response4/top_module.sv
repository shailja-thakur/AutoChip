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
  q_reg <= state_reg;
end

always @(a or b) begin
  if(a & ~b)
    state_next = 1'b1;
  else
    state_next = 1'b0;
end

assign state = state_reg;
assign q = q_reg;

endmodule
