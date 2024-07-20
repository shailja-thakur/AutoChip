module top_module (
  input clk,
  input R,
  input E,
  input L,
  input w,
  output reg Q
);

  reg temp;

  always @(posedge clk) begin
    if (L) begin
      Q <= R;
    end else if (E) begin
      Q <= temp;
    end else begin
      Q <= w;
    end
    temp <= Q;
  end

endmodule
