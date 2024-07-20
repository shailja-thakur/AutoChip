module top_module(
  input clk,
  input reset,
  input data,
  output start_shifting);

  reg [1:0] state;  // Register to store the current state

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 2'b00;  // Reset the state to 'S' (S=2'b00)
    end
    else begin
      case (state)
        2'b00: begin  // State 'S'
          if (data) begin
            state <= 2'b01;  // Transition to state 'S1' on high data
          end
          else begin
            state <= 2'b00;  // Stay in state 'S' on low data
          end
        end
        2'b01: begin  // State 'S1'
          if (data) begin
            state <= 2'b10;  // Transition to state 'S11' on high data
          end
          else begin
            state <= 2'b00;  // Transition back to state 'S' on low data
          end
        end
        2'b10: begin  // State 'S11'
          if (data) begin
            state <= 2'b10;  // Stay in state 'S11' on high data
          end
          else begin
            state <= 2'b11;  // Transition to state 'S110' on low data
          end
        end
        2'b11: begin  // State 'S110'
          if (data) begin
            state <= 2'b00;  // Transition to state 'Done' on high data
          end
          else begin
            state <= 2'b00;  // Transition back to state 'S' on low data
          end
        end
        default: begin  // State 'Done'
          state <= 2'b11;  // Stay in state 'Done'
        end
      endcase
    end
  end

  assign start_shifting = (state == 2'b11) ? 1'b1 : 1'b0;  // Output 'start_shifting' is high if state is 'Done', low otherwise

endmodule
