module top_module (
  input [5:0] y,
  input w,
  output Y1,
  output Y3
);

  reg [1:0] state_reg;
  reg Y1_reg, Y3_reg;
  always @(posedge w) begin
    case (state_reg)
      2'b00: begin  // State A
        Y1_reg <= 1'b0;
        Y3_reg <= 1'b1;
        if (w)
          state_reg <= 2'b01; // Transition to state B
      end
      
      2'b01: begin  // State B
        Y1_reg <= 1'b0;
        Y3_reg <= 1'b0;
        if (y[0])
          state_reg <= 2'b10; // Transition to state C
        else
          state_reg <= 2'b11; // Transition to state D
      end
      
      2'b10: begin  // State C
        Y1_reg <= 1'b0;
        Y3_reg <= 1'b1;
        if (y[0])
          state_reg <= 2'b10; // Remain in state C
        else
          state_reg <= 2'b11; // Transition to state D
      end
      
      2'b11: begin  // State D
        Y1_reg <= 1'b0;
        Y3_reg <= 1'b0;
        if (y[2])
          state_reg <= 2'b10; // Transition to state E
        else
          state_reg <= 2'b00; // Transition to state A
      end
      
      default: begin
        Y1_reg <= 1'b0;
        Y3_reg <= 1'b0;
        state_reg <= 2'b00; // Default to state A
      end
    endcase
  end

  assign Y1 = Y1_reg;
  assign Y3 = Y3_reg;

endmodule
