module top_module (
  input clk,
  input in,
  input areset,
  output out
);

  reg [1:0] state;
  reg out_reg;

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= 2'b0;
      out_reg <= 1'b0;
    end else begin
      case (state)
        2'b00: begin  // State A
          if (in) begin
            state <= 2'b01;  // Transition to state B when in=1
          end else begin
            state <= 2'b00;  // Stay in state A when in=0
          end
          out_reg <= 1'b0;
        end
        2'b01: begin  // State B
          if (in) begin
            state <= 2'b01;  // Stay in state B when in=1
          end else begin
            state <= 2'b10;  // Transition to state C when in=0
          end
          out_reg <= 1'b0;
        end
        2'b10: begin  // State C
          if (in) begin
            state <= 2'b11;  // Transition to state D when in=1
          end else begin
            state <= 2'b00;  // Transition to state A when in=0
          end
          out_reg <= 1'b0;
        end
        2'b11: begin  // State D
          if (in) begin
            state <= 2'b10;  // Transition to state C when in=1
          end else begin
            state <= 2'b01;  // Stay in state B when in=0
          end
          out_reg <= 1'b1;
        end
      endcase
    end
  end

  assign out = out_reg;

endmodule
