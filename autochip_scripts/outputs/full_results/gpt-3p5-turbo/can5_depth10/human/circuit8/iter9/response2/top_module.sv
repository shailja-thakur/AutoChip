module top_module (
  input wire clock,
  input wire a,
  output reg p,
  output reg q
);

always @(posedge clock) begin
  if (a == 1'b1) begin
    p <= 1'b0;
    q <= 1'b0;
  end else if (p == 1'b0 && q == 1'b0) begin
    if (a == 1'b0)
      p <= 1'b0;
    else
      p <= 1'b1;
    q <= 1'b0;
  end else if (p == 1'b1 && q == 1'b0) begin
    if (a == 1'b0)
      p <= 1'b0;
    else
      p <= 1'b1;
    q <= 1'b0;
  end else if (p == 1'b0 && q == 1'b1) begin
    if (a == 1'b0)
      p <= 1'b1;
    else
      p <= 1'b0;
    q <= 1'b1;
  end else begin
    if (a == 1'b0)
      p <= 1'b0;
    else
      p <= 1'b1;
    q <= 1'b1;
  end
end

endmodule
