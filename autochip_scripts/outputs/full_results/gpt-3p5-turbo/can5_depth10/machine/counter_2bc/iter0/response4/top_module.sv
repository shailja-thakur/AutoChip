module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

  reg [1:0] state_reg, state_next;

  always_ff @(posedge clk, negedge areset) begin
    if (areset) begin
      state_reg <= 2'b01; // Reset to state 1
    end
    else begin
      state_reg <= state_next;
    end
  end

  always_comb begin
    case(state_reg)
      2'b00: begin
        if (train_valid && train_taken && (state_reg < 2'b11))
          state_next = state_reg + 1;
        else if (train_valid && ~train_taken && (state_reg > 2'b00))
          state_next = state_reg - 1;
        else
          state_next = state_reg;
      end
      2'b01: begin
        if (train_valid && train_taken)
          state_next = state_reg + 1;
        else
          state_next = state_reg;
      end
      2'b10: begin
        if (train_valid && ~train_taken)
          state_next = state_reg - 1;
        else
          state_next = state_reg;
      end
      2'b11: begin
        state_next = state_reg;
      end
      default: begin
        state_next = state_reg;
      end
    endcase
  end

  assign state = state_reg;

endmodule
