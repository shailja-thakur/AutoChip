module top_module(
  input wire clk,
  input wire reset,
  input wire data,
  output reg [3:0] count,
  output reg counting,
  output reg done,
  input wire ack );

  reg [3:0] delay;
  reg [3:0] remaining_time;
  reg [1:0] state;
  reg [1:0] next_state;
  reg [3:0] next_remaining_time;

  parameter IDLE = 2'b00;
  parameter DETECT_PATTERN = 2'b01;
  parameter SHIFT_IN_DELAY = 2'b10;
  parameter COUNTING = 2'b11;
  parameter WAIT_FOR_ACK = 2'b00;

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
      delay <= (state == SHIFT_IN_DELAY) ? data : delay;
      count <= (counting && (state == COUNTING)) ? remaining_time : count;
      counting <= (state == COUNTING && remaining_time > 0) ? 1 : 0;
      done <= (state == WAIT_FOR_ACK && ack) ? 1 : 0;
      remaining_time <= (state == COUNTING) ? remaining_time - 1 : delay;
    end
  end

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      next_state <= IDLE;
      next_remaining_time <= 0;
    end else begin
      case (state)
        IDLE:
          if (data == 4'b1101) begin
            next_state <= DETECT_PATTERN;
            next_remaining_time <= 0;
          end else begin
            next_state <= IDLE;
          end
        DETECT_PATTERN:
          next_state <= SHIFT_IN_DELAY;
        SHIFT_IN_DELAY:
          if (next_remaining_time == delay) begin
            next_state <= COUNTING;
            next_remaining_time <= 0;
          end else begin
            next_state <= SHIFT_IN_DELAY;
            next_remaining_time <= next_remaining_time + 1;
          end
        COUNTING:
          if (remaining_time == 0) begin
            next_state <= WAIT_FOR_ACK;
          end else begin
            next_state <= COUNTING;
            next_remaining_time <= 0;
          end
        WAIT_FOR_ACK:
          if (ack) begin
            next_state <= IDLE;
          end else begin
            next_state <= WAIT_FOR_ACK;
          end
      endcase
    end
  end

endmodule
