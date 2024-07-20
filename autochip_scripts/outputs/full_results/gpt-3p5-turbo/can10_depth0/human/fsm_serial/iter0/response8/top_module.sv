module top_module (
  input clk,
  input in,
  input reset,
  output done
);

  reg [3:0] state = 4'b0000; // FSM state register

  always @(posedge clk) begin
    if (reset) begin
      state <= 4'b0000; // Reset the state machine
      done <= 1'b0; // Clear the done signal
    end else begin
      case (state)
        4'b0000: // IDLE state
          if (in == 0) begin
            state <= 4'b0001; // Move to START_BIT state
          end
        4'b0001: // START_BIT state
          state <= 4'b0010; // Move to DATA_BIT_1 state
        4'b0010 to 4'b1000: // DATA_BIT_N states
          state <= state + 1; // Increment the state
        4'b1001: // STOP_BIT state
          if (in == 1) begin
            state <= 4'b0000; // Move back to IDLE state
            done <= 1'b1; // Set the done signal
          end
      endcase
    end

  end

endmodule
