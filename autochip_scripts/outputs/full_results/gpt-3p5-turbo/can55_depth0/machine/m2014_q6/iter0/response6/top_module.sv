module top_module (
  input clk,
  input reset,
  input w,
  output reg z
);

  reg [2:0] state;
  
  always @(posedge clk) begin
    if (reset) begin
      state <= 3'b000;
      z <= 1'b0;
    end 
    else begin
      case(state)
        3'b000: begin // State A
          if (w == 1'b0)
            state <= 3'b001; // Transition to state B
          else
            state <= 3'b000; // Transition to state A
        end
        
        3'b001: begin // State B
          if (w == 1'b1)
            state <= 3'b011; // Transition to state D
          else
            state <= 3'b010; // Transition to state C
        end
        
        3'b010: begin // State C
          if (w == 1'b1)
            state <= 3'b011; // Transition to state D
          else
            state <= 3'b100; // Transition to state E
        end
        
        3'b011: begin // State D
          if (w == 1'b0)
            state <= 3'b101; // Transition to state F
          else
            state <= 3'b000; // Transition to state A
        end
        
        3'b100: begin // State E
          if (w == 1'b1)
            state <= 3'b011; // Transition to state D
          else
            state <= 3'b100; // Transition to state E
        end
        
        3'b101: begin // State F
          if (w == 1'b1)
            state <= 3'b011; // Transition to state D
          else
            state <= 3'b010; // Transition to state C
        end
      endcase
    end
  end
  
  always @(state) begin
    case(state)
      3'b100, 3'b101:
        z <= 1'b1; // Output z is high in state E and F
      default:
        z <= 1'b0; // Output z is low in all other states
    endcase
  end

endmodule
