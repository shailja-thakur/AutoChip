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

  // Define states
  parameter IDLE = 0;
  parameter DETECT_PATTERN = 1;
  parameter SHIFT_ENA = 2;
  parameter WAIT_FOR_COUNTING = 3;
  parameter NOTIFY_TIMEOUT = 4;

  reg [2:0] state;
  reg [3:0] counter;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE;
      shift_ena <= 0;
      counting <= 0;
      done <= 0;
    end else begin
      case (state)
        IDLE:
          if (data == 4'b1101) begin
            state <= DETECT_PATTERN;
          end
        DETECT_PATTERN:
          begin
            state <= SHIFT_ENA;
            shift_ena <= 1;
            counter <= 4;
          end
        SHIFT_ENA:
          begin
            if (counter == 0) begin
              state <= WAIT_FOR_COUNTING;
              shift_ena <= 0;
              counting <= 1;
            end else begin
              counter <= counter - 1;
            end
          end
        WAIT_FOR_COUNTING:
          if (done_counting) begin
            state <= NOTIFY_TIMEOUT;
            counting <= 0;
            done <= 1;
          end
        NOTIFY_TIMEOUT:
          if (ack) begin
            state <= IDLE;
            done <= 0;
          end
      endcase
    end
  end
endmodule
