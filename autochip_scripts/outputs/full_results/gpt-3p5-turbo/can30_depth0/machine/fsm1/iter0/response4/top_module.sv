module top_module (
  input clk,
  input in,
  input areset,
  output out
);

  reg state, next_state;
  reg out_reg;

  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= 1'b0; // Reset to state B
    else
      state <= next_state;
  end

  always @(state, in) begin
    case (state)
      1'b0: begin // State B
        if (in)
          next_state = 1'b0; // Stay in state B
        else
          next_state = 1'b1; // Transition to state A
      end

      1'b1: begin // State A
        if (in)
          next_state = 1'b1; // Stay in state A
        else
          next_state = 1'b0; // Transition to state B
      end
    endcase
  end

  always @(state) begin
    out_reg = (state == 1'b0) ? 1'b1 : 1'b0; // Output is high when state is B
  end

  assign out = out_reg;

endmodule
