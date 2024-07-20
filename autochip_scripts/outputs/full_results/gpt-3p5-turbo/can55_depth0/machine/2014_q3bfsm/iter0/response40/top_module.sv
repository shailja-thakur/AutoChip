module top_module (
  input clk,
  input reset,
  input x,
  output reg z
);

  reg [2:0] state;

  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 3'b000; // Initialize state to A
    else begin
      case (state)
        3'b000: begin // State A
          if (x) state <= 3'b001; // Transition to B
          else state <= 3'b000; // Remain in A
        end
        
        3'b001: begin // State B
          if (x) state <= 3'b100; // Transition to E
          else state <= 3'b001; // Remain in B
        end
        
        3'b010: begin // State C
          if (x) state <= 3'b001; // Transition to B
          else state <= 3'b010; // Remain in C
        end
        
        3'b011: begin // State D
          if (x) state <= 3'b010; // Transition to C
          else state <= 3'b001; // Remain in B
        end
        
        3'b100: begin // State E
          if (x) state <= 3'b100; // Remain in E
          else state <= 3'b011; // Transition to D
        end
        
        default: state <= 3'b000; // Handle any other cases
      endcase
    end
  end

  always @(state) begin
    case (state)
      3'b011: z <= 1; // When state is D, output is high
      3'b100: z <= 1; // When state is E, output is high
      default: z <= 0; // Output is low for all other states
    endcase
  end

endmodule
