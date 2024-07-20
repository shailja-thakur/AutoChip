module top_module (
  input wire clock,
  input wire a,
  output reg p,
  output reg q
);

always @(posedge clock) begin
  if (a == 1'b1) begin
    p <= 1'b1;
    q <= 1'b1;
  end else begin
    p <= p;
    q <= q;
  end
end

endmodule
