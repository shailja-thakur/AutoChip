module top_module (
  input wire clock,
  input wire a,
  output reg p,
  output reg q
);

always @(posedge clock) begin
  if (a == 1'b1) begin
    p <= 1'b1;
  end else if (a == 1'b0) begin
    p <= 1'b0;
  end
  if (a == 1'b1) begin
    q <= 1'b1;
  end else if (a == 1'b0) begin
    q <= 1'b0;
  end
end

endmodule
