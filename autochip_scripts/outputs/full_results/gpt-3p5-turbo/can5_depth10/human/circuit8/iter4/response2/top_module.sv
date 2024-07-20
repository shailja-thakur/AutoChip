module top_module (
  input wire clock,
  input wire a,
  output reg p,
  output reg q
);

reg p_temp, q_temp;
 
always @(posedge clock or a) begin
  if (a == 1'b1) begin
    p_temp <= 1'b1;
    q_temp <= 1'b1;
  end else begin
    p_temp <= 1'b0;
    q_temp <= 1'b0;
  end
end

always @(posedge clock) begin
  p <= p_temp;
  q <= q_temp;
end

endmodule
