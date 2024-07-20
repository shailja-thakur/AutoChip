module top_module (
  input wire clock,
  input wire a,
  output reg p,
  output reg q
);

reg p_temp, q_temp;
reg p_reg, q_reg;
 
always @(posedge clock) begin
  p_reg <= p_temp;
  q_reg <= q_temp;
end

always @(posedge clock) begin
  if (a == 1'b1) begin
    p_temp <= 1'b1;
    q_temp <= 1'b1;
  end else begin
    p_temp <= p_reg;
    q_temp <= q_reg;
  end
end

always @(posedge clock) begin
  p <= p_temp;
  q <= q_temp;
end

endmodule
