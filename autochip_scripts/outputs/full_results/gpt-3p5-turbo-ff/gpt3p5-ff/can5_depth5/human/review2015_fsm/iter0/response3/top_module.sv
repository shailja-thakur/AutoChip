module top_module(
  input clk,
  input reset,
  input data,
  output reg shift_ena,
  output reg counting,
  input done_counting,
  output reg done,
  input ack
);

  // Define the states of the state machine
  enum {ST_START, ST_DETECTED, ST_SHIFT_ENA, ST_COUNTING, ST_DONE} state;
  
  always @(posedge clk) begin
    if (reset) begin
      state <= ST_START; // Reset the state machine to initial state
      shift_ena <= 0; // Reset shift_ena signal
      counting <= 0; // Reset counting signal
      done <= 0; // Reset done signal
    end
    else begin
      case(state)
        ST_START:
          if (data == 4'b1101) begin
            state <= ST_DETECTED; // Transition to detected state
            shift_ena <= 1; // Assert shift_ena signal
          end else begin
            state <= ST_START; // Stay in start state
            shift_ena <= 0; // Deassert shift_ena signal
          end
        ST_DETECTED:
          state <= ST_SHIFT_ENA; // Transition to shift_ena state
          shift_ena <= 1; // Assert shift_ena signal
        ST_SHIFT_ENA:
          if (done_counting) begin
            state <= ST_COUNTING; // Transition to counting state
            counting <= 1; // Assert counting signal
          end else begin
            state <= ST_SHIFT_ENA; // Stay in shift_ena state
            counting <= 0; // Deassert counting signal
          end
        ST_COUNTING:
          if (done_counting) begin
            state <= ST_DONE; // Transition to done state
            counting <= 1; // Assert counting signal
            done <= 1; // Assert done signal
          end else begin
            state <= ST_COUNTING; // Stay in counting state
            counting <= 1; // Assert counting signal
          end
        ST_DONE:
          if (ack) begin
            state <= ST_START; // Transition to start state
            done <= 0; // Deassert done signal
          end else begin
            state <= ST_DONE; // Stay in done state
            done <= 1; // Assert done signal
          end
      endcase
    end
  end
endmodule
