module top_module (
  input clk,
  input resetn,
  input x,
  input y,
  output f,
  output g
);

  reg f;
  reg g;
  reg [1:0] state;
  reg [2:0] x_history;

  always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      state <= 2'b0;  // Beginning state A
      f <= 1'b0;
      g <= 1'b0;
      x_history <= 3'b0;
    end else begin
      case(state)
        2'b00: begin  // State A
          f <= 1'b0;
          if (x == 1'b1) begin
            state <= 2'b01;  // Transition to state B
            x_history <= {x_history[1:0], x};
          end
        end
        2'b01: begin  // State B
          f <= 1'b1;
          state <= 2'b10;  // Transition to state C
        end
        2'b10: begin  // State C
          if (x_history == 3'b101) begin
            state <= 2'b11;  // Transition to state D
          end
        end
        2'b11: begin  // State D
          if (y == 1'b1) begin
            g <= 1'b1;
            state <= 2'b11;  // Stay in state D
          end else begin
            if (g == 1'b1) begin
              state <= 2'b10;  // Transition to state C
            end
          end
        end
      endcase
    end
  end

endmodule
