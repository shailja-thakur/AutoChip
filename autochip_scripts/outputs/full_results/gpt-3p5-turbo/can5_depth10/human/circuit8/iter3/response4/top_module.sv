module top_module (
  input clock,
  input a,
  output reg p,
  output reg q
);

reg p_temp;
reg q_temp;

always @(posedge clock) begin
  // Use non-blocking assignments to update p_temp and q_temp
  if (a == 1'b1) begin
    p_temp <= 1'b1;
    q_temp <= 1'b1;
  end else begin
    p_temp <= 1'b0;
    q_temp <= 1'b0;
  end
end

always @(posedge clock) begin
  // Use blocking assignments to update p and q
  p <= p_temp;
  q <= q_temp;
end

endmodule
