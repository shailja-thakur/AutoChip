module top_module (
  input clk,
  input w,
  input R,
  input E,
  input L,
  output reg Q
);

  reg stage2;
  reg w_reg;

  always @(posedge clk) begin
    // Load condition
    if (L) begin
      Q <= R;
      stage2 <= w;
      w_reg <= 1'b0;
    end
    // Shift condition
    else if (E) begin
      if (w_reg) begin
        Q <= stage2;
      end
      else begin
        Q <= w;
        w_reg <= 1'b1;
      end
      
      stage2 <= w;
    end
  end

endmodule
