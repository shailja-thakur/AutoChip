module top_module (
  input clk,
  input in,
  input areset,
  output out
);

  parameter A = 1'b0;
  parameter B = 1'b1;

  reg state_reg, next_state_reg;

  always @(posedge clk, posedge areset) begin
    if (areset)
      state_reg <= B;
    else
      state_reg <= next_state_reg;
  end

  always @(*) begin
    case (state_reg)
      B: begin
        if (in)
          next_state_reg = B;
        else
          next_state_reg = A;
      end
      A: begin
        if (in)
          next_state_reg = A;
        else
          next_state_reg = B;
      end
    endcase
  end

  assign out = state_reg;

endmodule
