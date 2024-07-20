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
      stage2 <= w;
    end
    else if (E) begin
      Q <= stage2;
      stage2 <= Q; // Fix: Changed 'stage2 <= w;' to 'stage2 <= Q;'
    end
  end

endmodule
