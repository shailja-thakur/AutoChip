module top_module (
  input clk,
  input a,
  input b,
  output q,
  output state
);

  reg q_reg, state_reg;

  always @(posedge clk) begin
    if (a == 1 && b == 0) begin
      q_reg <= 1;
    end else if (a == 1 && b == 1) begin
      q_reg <= ~q_reg;
    end else if (a == 0 && b == 0) begin
      q_reg <= q_reg;
    end else if (a == 0 && b == 1) begin
      q_reg <= 0;
    end
  end
  
  always @(posedge clk) begin
    state_reg <= q_reg;
  end

  assign q = q_reg;
  assign state = state_reg;

endmodule
