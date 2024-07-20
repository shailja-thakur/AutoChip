module top_module (
  input clk,
  input in,
  input areset,
  output out
);

  reg state, next_state;
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= 1'b0; // Reset state to B
    end else begin
      state <= next_state; // Update state
    end
  end
  
  always @(state, in) begin
    case (state)
      
      1'b0: begin // State B
        if (in) begin
          next_state <= 1'b0; // Stay in B
        end else begin
          next_state <= 1'b1; // Transition to A
        end
      end
      
      1'b1: begin // State A
        if (in) begin
          next_state <= 1'b1; // Stay in A
        end else begin
          next_state <= 1'b0; // Transition to B
        end
      end
      
      default: next_state <= 1'b0;
      
    endcase
  end
  
  assign out = ~state; // Output is high when state is B, low otherwise
  
endmodule
