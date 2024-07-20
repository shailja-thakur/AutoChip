module top_module (
  input clock,
  input a,
  output reg p,
  output reg q
);

reg p_reg;
reg q_reg;

always @(posedge clock) begin
  p_reg <= p;
  q_reg <= q;
  
  if (a == 1'b1) begin
    p <= p_reg;
    q <= p_reg;
  end else begin
    p <= 1'b0;
    q <= q_reg;
  end
end

endmodule
