module top_module (
  input clk,
  input a,
  input b,
  output reg q,
  output reg state
);

reg q_reg;
reg state_reg;

always @(posedge clk) begin
  q_reg <= q;
  state_reg <= state;
  
  if (a & b)
    state_reg <= 1'b1;
  else
    state_reg <= 1'b0;
end

always @(posedge clk) begin
  if (state_reg == 1'b1)
    q_reg <= 1'b1;
  else
    q_reg <= 1'b0;
end

always @(posedge clk) begin
  q <= q_reg;
  state <= state_reg;
end

endmodule
