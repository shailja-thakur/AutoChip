module top_module (
  input wire clock,
  input wire a,
  output reg p,
  output reg q
);

reg p_temp;
reg q_temp;
  
always @(posedge clock) begin
  if (a == 1'b1) begin
    p <= 1'b0;
    q <= 1'b0;
  end else if (p_temp == 1'b1 && q_temp == 1'b1) begin
    p <= 1'b0;
    q <= 1'b0;
  end else if (p_temp == 1'b1 && q_temp == 1'b0) begin
    p <= 1'b1;
    q <= 1'b0;
  end else if (p_temp == 1'b0 && q_temp == 1'b0) begin
    p <= 1'b0;
    q <= 1'b0;
  end else begin
    p <= p_temp;
    q <= q_temp;
  end
  
  p_temp <= p;
  q_temp <= q;
end

endmodule
