module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
  
  // State register
  reg [1:0] state_reg;
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state_reg <= 2'b01; // Reset to state 1
    end else begin
      case (state_reg)
        2'b00: begin
          if (train_taken && state_reg < 2'b11)
            state_reg <= state_reg + 1; // Transition to next state
          else if (!train_taken && state_reg > 2'b00)
            state_reg <= state_reg - 1; // Transition to previous state
        end
        2'b01: begin
          if (train_valid)
            state_reg <= 2'b00; // Transition to state 0
        end
        2'b10: begin
          // No transition from state 2
        end
        2'b11: begin
          // No transition from state 3
        end
      endcase
    end
  end

  assign state = state_reg; // Output the current state

endmodule
