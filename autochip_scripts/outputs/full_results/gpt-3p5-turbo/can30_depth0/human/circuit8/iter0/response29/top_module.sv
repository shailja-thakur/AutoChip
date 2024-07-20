module top_module (
  input clock,
  input a, 
  output reg p,
  output reg q
);

reg p_reg;
always @(posedge clock) begin
  if (a == 1'b1)
    p_reg <= 1'b1;
  else
    p_reg <= 1'b0;
end

always @(negedge clock) begin
  if (p_reg == 1'b1)
    q <= 1'b1;
  else
    q <= 1'b0;
end

always @(negedge clock) begin
  if (a == 1'b1)
    p <= 1'b1;
  else
    p <= 1'b0;
end

endmodule
