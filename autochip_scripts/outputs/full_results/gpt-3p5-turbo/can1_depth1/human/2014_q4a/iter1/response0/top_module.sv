module top_module (
  input clk,
  input w,
  input R,
  input E,
  input L,
  output reg Q
);

reg D;

always @(posedge clk) begin
  if (E == 1'b1) begin
    if (L == 1'b1) begin
      D <= R;
    end else begin
      D <= w;
    end
  end else begin
    D <= D; // Preserve D when E is not enabled
  end
end

always @(posedge clk) begin
  if (E == 1'b1) begin
    Q <= D;
  end
end

endmodule
