module top_module (
  input wire clock,
  input wire a,
  output reg p,
  output reg q
);

reg p_temp;
reg q_temp;

always @(posedge clock) begin
  p_temp <= p;
  q_temp <= q;
  
  if (a == 1'b1) begin
    p <= 1'b1;
    q <= 1'b1;
  end else begin
    p <= p_temp;
    q <= q_temp;
  end
end

endmodule
