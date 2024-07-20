module top_module (
  input clk,
  input a,
  input b,
  output reg q,
  output reg state
);

  reg q_reg;
  reg state_reg;
  
  always @(posedge clk) begin
    if (state_reg) begin
      q_reg <= a & b;
    end else begin
      q_reg <= 1'b0;
    end
    state_reg <= a | b;
  end
  
  always @(state_reg) begin
    state = state_reg;
    q = q_reg;
  end

endmodule
