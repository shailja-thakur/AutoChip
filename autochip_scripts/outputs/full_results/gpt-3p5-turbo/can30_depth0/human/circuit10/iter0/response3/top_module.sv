module top_module (
  input clk,
  input a,
  input b,
  output q,
  output state
);

  reg q_reg;
  reg state_reg;
  
  always @(posedge clk) begin
    if (state_reg == 0) begin
      if (a & ~b) begin
        q_reg <= 1'b1;
        state_reg <= 1'b0;
      end else if (~a & b) begin
        q_reg <= 1'b0;
        state_reg <= 1'b0;
      end else begin
        q_reg <= q_reg;
        state_reg <= 1'b0;
      end
    end else begin
      q_reg <= q_reg;
      state_reg <= 1'b1;
    end
  end
  
  assign q = q_reg;
  assign state = state_reg;
  
endmodule
