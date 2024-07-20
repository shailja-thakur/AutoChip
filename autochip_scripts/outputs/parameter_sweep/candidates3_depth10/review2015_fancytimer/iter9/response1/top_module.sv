module top_module(
  input wire clk,
  input wire reset,
  input wire [3:0] data,
  output reg [3:0] count,
  output reg counting,
  output reg done,
  input wire ack );

  reg [3:0] delay;
  reg [3:0] remaining_time;
  reg [3:0] state;
  reg [3:0] next_state;
  reg [3:0] next_remaining_time;

  parameter IDLE = 4'b0000;
  parameter DETECT_PATTERN = 4'b0001;
  parameter SHIFT_IN_DELAY = 4'b0010;
  parameter COUNTING = 4'b0011;
  parameter WAIT_FOR_ACK = 4'b0100;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE;
      delay <= 0;
      count <= 0;
      counting <= 0;
      done <= 0;
      remaining_time <= 0;
    end else begin
      state <= next_state;
      case (state)
        IDLE:
          if (data[3:0] == 4'b1101) begin
            next_state <= DETECT_PATTERN;
          end else begin
            next_state <= IDLE;
          end
        DETECT_PATTERN:
          next_state <= SHIFT_IN_DELAY;
        SHIFT_IN_DELAY:
          if (next_remaining_time == 4'b1111) begin
            next_state <= COUNTING;
          end else begin
            next_state <= SHIFT_IN_DELAY;
            next_remaining_time <= next_remaining_time + 1;
          end
        COUNTING:
          if (remaining_time == 0) begin
            next_state <= WAIT_FOR_ACK;
          end else begin
            next_state <= COUNTING;
          end
        WAIT_FOR_ACK:
          if (ack) begin
            next_state <= IDLE;
          end else begin
            next_state <= WAIT_FOR_ACK;
          end
      endcase
      count <= counting ? remaining_time : 0;
      counting <= (state == COUNTING && remaining_time > 0) ? 1 : 0;
      done <= (state == WAIT_FOR_ACK && ack) ? 1 : 0;
      remaining_time <= counting && remaining_time > 0 ? remaining_time - 1 : delay;
    end
  end
endmodule
