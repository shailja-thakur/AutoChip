module top_module (
  input wire clock,
  input wire a,
  output reg p,
  output reg q
);

reg previous_a;

always @(posedge clock) begin
  previous_a <= a;
  if (a == 1'b1) begin
    p <= 1'b1;
    q <= 1'b1;
  end else if (previous_a == 1'b1) begin
    p <= 1'b0;
    q <= 1'b0;
  end else begin
    p <= p;
    q <= q;
  end
end

endmodule
