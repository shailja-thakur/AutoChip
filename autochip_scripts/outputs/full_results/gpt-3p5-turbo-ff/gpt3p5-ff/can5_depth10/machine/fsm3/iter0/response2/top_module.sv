module top_module (
  input clk,
  input in,
  input areset,
  output out
);

  reg [1:0] state;
  reg out_temp;
  
  // State machine logic
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= 2'b00; // Reset to state A
    end else begin
      case (state)
        2'b00: begin // State A
          if (in) begin
            state <= 2'b01; // Transition to state B
          end else begin
            state <= 2'b00; // Stay in state A
          end
        end
        2'b01: begin // State B
          if (in) begin
            state <= 2'b01; // Stay in state B
          end else begin
            state <= 2'b10; // Transition to state C
          end
        end
        2'b10: begin // State C
          if (in) begin
            state <= 2'b11; // Transition to state D
          end else begin
            state <= 2'b00; // Transition to state A
          end
        end
        2'b11: begin // State D
          if (in) begin
            state <= 2'b01; // Transition to state B
          end else begin
            state <= 2'b10; // Transition to state C
          end
        end
      endcase
    end
  end
  
  // Output logic
  always @(state) begin
    if (state == 2'b11) begin
      out_temp <= 1; // Set output to 1 when in state D
    end else begin
      out_temp <= 0;
    end
  end
  
  assign out = out_temp;
  
endmodule
