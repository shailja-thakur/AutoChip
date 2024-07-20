module top_module (
  input clk,
  input w,
  input R,
  input E,
  input L,
  output reg Q
);

  reg stage2;

  always @(posedge clk) begin
    if (L) begin
      Q <= R;
      stage2 <= 1'b0;
    end
    else if (E) begin
      Q <= stage2;
      stage2 <= w;
    end
  end

endmodule
