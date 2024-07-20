module top_module (
  input clk,
  input w,
  input R,
  input E,
  input L,
  output reg Q
);

  always @(posedge clk) begin
    if (E == 1'b0) begin
      Q <= Q; // Hold current state
    end else begin
      if (L == 1'b1) begin
        Q <= 1'b0; // Update with R
      end else begin
        Q <= w; // Update with w
      end
    end
  end

endmodule
