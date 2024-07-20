module top_module (
  input clock,
  input a,
  output reg p,
  output reg q
);

always @(posedge clock) begin
  // Use non-blocking assignments to update p and q
  if (a == 1'b1) begin
    p <= 1'b1;
    q <= 1'b1;
  end else begin
    p <= 1'b0;
    q <= 1'b0;
  end
end

endmodule
