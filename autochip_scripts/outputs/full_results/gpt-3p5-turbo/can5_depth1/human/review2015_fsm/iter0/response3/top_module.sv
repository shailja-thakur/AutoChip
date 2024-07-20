module top_module(
  input clk,
  input reset,
  input data,
  output reg shift_ena,
  output reg counting,
  input done_counting,
  output reg done,
  input ack );

  // Define the states of the state machine
  parameter IDLE = 0;
  parameter DETECT_SEQUENCE = 1;
  parameter SHIFT_IN = 2;
  parameter WAIT_COUNTER = 3;
  parameter FINISH = 4;

  reg [2:0] state; // State register for the state machine

  always @(posedge clk) begin
    if (reset) begin
      state <= IDLE; // Reset state machine to IDLE
      shift_ena <= 0;
      counting <= 0;
      done <= 0;
    end
    else begin
      case (state)
        IDLE:
          if (data == 1'b1 && $rose(data)) // Detect start sequence 1101
            state <= DETECT_SEQUENCE;
        DETECT_SEQUENCE:
          if (data == 1'b0 && $fell(data))
            state <= SHIFT_IN;
        SHIFT_IN:
          if (shift_ena == 4'b0) begin // Shift in 4 more bits
            shift_ena <= 1;
            state <= WAIT_COUNTER;
          end
          else begin
            shift_ena <= 0;
            state <= DETECT_SEQUENCE;
          end
        WAIT_COUNTER:
          if (done_counting) begin
            counting <= 1; // Assert counting output
            state <= FINISH;
          end
        FINISH:
          if (ack) begin // Wait until ack is high
            done <= 1; // Assert done output
            state <= IDLE; // Reset state machine back to IDLE
          end
      endcase
    end
  end
endmodule
