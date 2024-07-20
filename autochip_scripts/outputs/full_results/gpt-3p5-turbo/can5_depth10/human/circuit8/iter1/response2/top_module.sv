module top_module (
  input clock,
  input a,
  output reg p,
  output reg q
);

reg p_temp;
reg q_temp;

always @(posedge clock) begin
  if (a == 1 && p_temp == 1) begin
    p <= 0;
    q <= 0;
  end else if (a == 1) begin
    p <= 1;
    q <= 0;
  end else if (p_temp == 1) begin
    p <= 1;
    q <= 1;
  end else begin
    p <= 0;
    q <= 1; // Change q output to 1 instead of 0
  end

  p_temp <= p;
  q_temp <= q;
end

endmodule
