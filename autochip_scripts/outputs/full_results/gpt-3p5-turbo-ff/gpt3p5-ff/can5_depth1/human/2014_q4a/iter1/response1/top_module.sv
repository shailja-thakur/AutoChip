module top_module (
  input clk,
  input w,
  input R,
  input E,
  input L,
  output reg Q
);

  reg stage0;
  reg stage1;

  always @(posedge clk) begin
    if (L) begin
      Q <= R;
      stage0 <= w;
      stage1 <= 1'b0;
    end
    else if (E) begin
      Q <= stage2;
      stage0 <= stage1;
      stage1 <= w;
    end
  end

endmodule
