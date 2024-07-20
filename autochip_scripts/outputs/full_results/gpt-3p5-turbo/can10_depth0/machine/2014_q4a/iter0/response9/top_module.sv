module top_module (
  input clk,
  input w,
  input R,
  input E,
  input L,
  output reg Q
);

always @(posedge clk) begin
  if (E == 1'b0) begin // If E is low, hold Q in its current state
    Q <= Q;
  end else begin // If E is high, update Q based on L and w/R
    if (L == 1'b1) begin // If L is high, update Q with R
      Q <= R;
    end else begin // If L is low, update Q with w
      Q <= w;
    end
  end
end

endmodule
