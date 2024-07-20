module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output reg done
);

  // Declare internal signals
  reg [1:0] state;

  // State parameters
  parameter BYTE1 = 2'b00;
  parameter BYTE2 = 2'b01;
  parameter BYTE3 = 2'b10;
  parameter DONE  = 2'b11;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= BYTE1;  // Reset to BYTE1 state
      done <= 0;       // Reset done signal
    end
    else begin
      // State transitions
      case(state)
        BYTE1:
          if (in[2] == 1)
            state <= BYTE2;  // Transition to BYTE2
          else
            state <= BYTE1;  // Stay in BYTE1
        BYTE2:
          state <= BYTE3;     // Transition to BYTE3
        BYTE3:
          state <= DONE;      // Transition to DONE
        DONE:
          if (in[2] == 0)
            state <= BYTE1;  // Transition to BYTE1
          else
            state <= BYTE2;  // Transition to BYTE2
      endcase

      // Done signal assertion
      if (state == DONE)
        done <= 1;
      else
        done <= 0;
    end
  end

endmodule
