module top_module (
  input clk,
  input reset,
  input w,
  output reg z
);

  reg [2:0] state;
  
  always @(posedge clk) begin
    if (reset)
      state <= 3'b000; // Initial state is A
    else begin
      case (state)
        3'b000: begin // State A
          if (w)
            state <= 3'b001; // Transition to B when w is 1
          else
            state <= 3'b000; // Stay in A when w is 0
        end
        3'b001: begin // State B
          if (w)
            state <= 3'b010; // Transition to C when w is 1
          else
            state <= 3'b100; // Transition to D when w is 0
        end
        3'b010: begin // State C
          if (w)
            state <= 3'b101; // Transition to E when w is 1
          else
            state <= 3'b100; // Transition to D when w is 0
        end
        3'b100: begin // State D
          if (w)
            state <= 3'b011; // Transition to F when w is 1
          else
            state <= 3'b000; // Transition to A when w is 0
        end
        3'b101: begin // State E
          if (w)
            state <= 3'b101; // Stay in E when w is 1
          else
            state <= 3'b100; // Transition to D when w is 0
        end
        3'b011: begin // State F
          if (w)
            state <= 3'b110; // Transition to C when w is 1
          else
            state <= 3'b100; // Transition to D when w is 0
        end
        default: state <= 3'b000; // Default case, transition to A
      endcase
    end
  end
  
  assign z = (state == 3'b101 || state == 3'b011) ? 1 : 0; // Output z is set to 1 when the state is E or F

endmodule
