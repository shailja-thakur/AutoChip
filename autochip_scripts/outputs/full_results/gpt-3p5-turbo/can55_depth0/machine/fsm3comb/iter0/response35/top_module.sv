module top_module(
  input in,
  input [1:0] state,
  output wire [1:0] next_state,
  output reg out
);
  
  // State transition logic
  always_comb begin
    case (state)
      2'b00: begin // State A
        if (in) begin
          next_state = 2'b01; // Transition to State B
        end else begin
          next_state = 2'b00; // Remain in State A
        end
      end
      2'b01: begin // State B
        if (in) begin
          next_state = 2'b01; // Remain in State B
          out = 1'b0; // Not in State D
        end else begin
          next_state = 2'b10; // Transition to State C
        end
      end
      2'b10: begin // State C
        if (in) begin
          next_state = 2'b11; // Transition to State D
          out = 1'b1; // In State D
        end else begin
          next_state = 2'b00; // Transition to State A
        end
      end
      2'b11: begin // State D
        if (in) begin
          next_state = 2'b01; // Transition to State B
        end else begin
          next_state = 2'b10; // Transition to State C
        end
      end
    endcase
  end
  
endmodule
