module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output reg done
);

  // State declaration
  reg [1:0] state;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 2'b00;   // Initial state is BYTE1
      done <= 0;        // Reset done signal
    end else begin
      case (state)
        
        // BYTE1 state
        2'b00: begin
          if (in[2]) begin   // Check third bit of input
            state <= 2'b01; // Transition to BYTE2 state
          end
        end
        
        // BYTE2 state
        2'b01: begin
          state <= 2'b10;   // Transition to BYTE3 state
        end
        
        // BYTE3 state
        2'b10: begin
          state <= 2'b11;   // Transition to DONE state
        end
        
        // DONE state
        2'b11: begin
          if (in[2]) begin   // Check third bit of input
            state <= 2'b01; // Transition to BYTE2 state
          end else begin
            state <= 2'b00; // Transition to BYTE1 state
          end
          
          done <= 1;        // Assert done signal
        end
        
      endcase
    end
  end

endmodule
