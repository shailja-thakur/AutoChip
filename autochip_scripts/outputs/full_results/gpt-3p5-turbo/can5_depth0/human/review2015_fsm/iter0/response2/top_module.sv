module top_module(
  input clk,
  input reset,
  input data,
  output reg shift_ena,
  output reg counting,
  input done_counting,
  output reg done,
  input ack );

  // State definitions
  parameter IDLE = 2'b00;
  parameter DETECT_PATTERN = 2'b01;
  parameter SHIFT_IN = 2'b10;
  parameter WAIT_COUNTERS = 2'b11;

  // Internal signals
  reg [1:0] state;

  // State machine
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE;
      shift_ena <= 0;
      counting <= 0;
      done <= 0;
    end else begin
      case(state)
        IDLE:
          if (data == 1'b1 && data == 1'b1 && data == 1'b0 && data == 1'b1) begin
            state <= DETECT_PATTERN;
          end
        DETECT_PATTERN:
          begin
            state <= SHIFT_IN;
            shift_ena <= 1;
          end
        SHIFT_IN:
          if (shift_ena == 4'b1111) begin
            state <= WAIT_COUNTERS;
            shift_ena <= 0;
            counting <= 1;
          end else begin
            state <= SHIFT_IN;
            shift_ena <= shift_ena + 1;
          end
        WAIT_COUNTERS:
          begin
            if (done_counting) begin
              state <= IDLE;
              counting <= 0;
              done <= 1;
            end else begin
              state <= WAIT_COUNTERS;
            end
          end
      endcase
    end
  end

  // Reset the state machine when ack is high
  always @(posedge clk) begin
    if (ack) begin
      state <= IDLE;
      done <= 0;
    end
  end

endmodule
