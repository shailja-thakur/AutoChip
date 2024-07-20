module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output reg done
);

  // Declare the states
  typedef enum logic [1:0] {
    BYTE1,
    BYTE2,
    BYTE3,
    DONE
  } state_t;

  // Declare the current state
  state_t current_state, next_state;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      current_state <= BYTE1;  // Initialize the state machine to BYTE1
      done <= 0;  // Initialize the done signal to 0
    end else begin
      current_state <= next_state;  // Update the current state
      case (current_state)
        BYTE1: begin
          if (in[2]) begin
            next_state <= BYTE2;  // Transition to BYTE2 if the third bit is 1
          end else begin
            next_state <= BYTE1;  // Remain in BYTE1 if the third bit is 0
          end
        end
        BYTE2: begin
          next_state <= BYTE3;  // Transition to BYTE3
        end
        BYTE3: begin
          next_state <= DONE;  // Transition to DONE
        end
        DONE: begin
          if (in[2]) begin
            next_state <= BYTE2;  // Transition back to BYTE2 if the third bit is 1
          end else begin
            next_state <= BYTE1;  // Transition back to BYTE1 if the third bit is 0
          end
        end
      endcase
    end
  end

  // Assert the done signal when the state machine is in the DONE state
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      done <= 0;  // Initialize the done signal to 0
    end else begin
      if (current_state == DONE) begin
        done <= 1;  // Assert the done signal
      end else begin
        done <= 0;  // Deassert the done signal
      end
    end
  end

endmodule
