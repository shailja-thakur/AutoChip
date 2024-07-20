module top_module (
  input clk,
  input w,
  input R,
  input E,
  input L,
  output reg Q
);

  reg shift_reg;

  always @(posedge clk) begin
    if (E) begin
      if (L)
        shift_reg <= R;
      else
        shift_reg <= shift_reg << 1;
    end
    else
      shift_reg <= shift_reg;
  end

  always @(posedge clk) begin
    if (E)
      Q <= shift_reg[0];
    else
      Q <= Q;
  end

endmodule
