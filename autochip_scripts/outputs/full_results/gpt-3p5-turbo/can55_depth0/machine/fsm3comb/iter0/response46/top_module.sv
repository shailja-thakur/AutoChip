module top_module (
  input in,
  input [1:0] state,
  output reg [1:0] next_state,
  output reg out
);

  always_comb begin
    case (state)
      2'b00: // State A
        begin
          if (in == 1'b1)
            next_state = 2'b01; // Transition to state B
          else
            next_state = 2'b00; // Remain in state A
        end
      2'b01: // State B
        begin
          if (in == 1'b1)
            next_state = 2'b01; // Remain in state B
          else
            next_state = 2'b10; // Transition to state C
        end
      2'b10: // State C
        begin
          if (in == 1'b1)
            next_state = 2'b11; // Transition to state D
          else
            next_state = 2'b00; // Transition to state A
        end
      2'b11: // State D
        begin
          if (in == 1'b1)
            next_state = 2'b01; // Transition to state B
          else
            next_state = 2'b10; // Transition to state C
        end
      default:
        next_state = 2'b00; // Default to state A
    endcase
  end
  
  always @(posedge clk or posedge rst) begin
    if (rst)
      out <= 1'b0; // Initialize 'out' to low after reset
    else if (state == 2'b11)
      out <= 1'b1; // Set 'out' to high when in state D
    else
      out <= 1'b0; // Set 'out' to low for all other states
  end
  
endmodule
