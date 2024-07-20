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
      // Hold the output Q in its current state
      Q <= Q;
    end else begin
      if (L == 1'b1) begin
        // Update output Q with the value of R
        Q <= R;
      end else begin
        // Update output Q with the value of w
        Q <= w;
      end
    end
  end

endmodule
