module top_module (
  input clk,
  input reset,
  input x,
  output reg z
);

  reg [2:0] state;

  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 3'b001; // Initialize state to A
    else begin
      case(state)
        3'b001: // State A
          if (x)
            state <= 3'b010; // Transition to state B
          else
            state <= 3'b001; // Remain in state A
        3'b010: // State B
          if (x)
            state <= 3'b110; // Transition to state E
          else
            state <= 3'b010; // Remain in state B
        3'b011: // State C
          if (x)
            state <= 3'b010; // Transition to state B
          else
            state <= 3'b011; // Remain in state C
        3'b100: // State D
          if (x)
            state <= 3'b011; // Transition to state C
          else
            state <= 3'b010; // Remain in state B
        3'b101: // State E
          if (x)
            state <= 3'b101; // Remain in state E
          else
            state <= 3'b100; // Transition to state D
        default:
            state <= 3'b001; // Default to state A
      endcase
    end
  end

  always @(state) begin
    if (state == 3'b101 || state == 3'b100)
      z <= 1'b1; // Output z is high when state is D or E
    else
      z <= 1'b0;
  end
endmodule
