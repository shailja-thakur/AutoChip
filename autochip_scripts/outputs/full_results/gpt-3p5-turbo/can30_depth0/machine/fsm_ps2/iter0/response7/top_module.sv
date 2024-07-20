module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);
  
  reg [1:0] state;
  reg done_reg;
  wire third_bit;
  
  assign third_bit = in[2];
  assign done = done_reg;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 2'b00;  // Set initial state to BYTE1
      done_reg <= 0;  // Reset done signal
    end else begin
      case (state)
        2'b00: begin  // BYTE1 state
          if (third_bit) begin
            state <= 2'b01;  // Transition to BYTE2 state
          end else begin
            state <= 2'b00;  // Remain in BYTE1 state
          end
        end
        2'b01: begin  // BYTE2 state
          state <= 2'b10;  // Transition to BYTE3 state
        end
        2'b10: begin  // BYTE3 state
          state <= 2'b11;  // Transition to DONE state
        end
        2'b11: begin  // DONE state
          if (third_bit) begin
            state <= 2'b01;  // Transition back to BYTE2 state
          end else begin
            state <= 2'b00;  // Transition back to BYTE1 state
          end
          done_reg <= 1;  // Assert done signal
        end
      endcase
    end
  end
  
endmodule
