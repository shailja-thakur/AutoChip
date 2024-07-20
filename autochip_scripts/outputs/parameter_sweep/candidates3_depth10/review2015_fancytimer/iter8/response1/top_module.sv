module top_module(
  input wire clk,
  input wire reset,
  input wire [3:0] data, // Fix: Changed data input width from 1 bit to 4 bits
  output reg [3:0] count,
  output reg counting,
  output reg done,
  input wire ack );

  reg [3:0] delay;
  reg [3:0] remaining_time;
  reg [1:0] state; // Fix: Changed state width from 4 bits to 2 bits
  reg [1:0] next_state; // Fix: Changed next_state width from 4 bits to 2 bits
  reg [3:0] next_remaining_time;

  parameter IDLE = 2'b00; // Fix: Changed IDLE width from 4 bits to 2 bits
  parameter DETECT_PATTERN = 2'b01; // Fix: Changed DETECT_PATTERN width from 4 bits to 2 bits
  parameter SHIFT_IN_DELAY = 2'b10; // Fix: Changed SHIFT_IN_DELAY width from 4 bits to 2 bits
  parameter COUNTING = 2'b11; // Fix: Changed COUNTING width from 4 bits to 2 bits
  parameter WAIT_FOR_ACK = 2'b100; // Fix: Changed WAIT_FOR_ACK width from 4 bits to 2 bits

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
      if (state == SHIFT_IN_DELAY) begin
        delay <= data;
      end
      count <= counting ? remaining_time : 0;
      counting <= (state == COUNTING && remaining_time > 0) ? 1 : 0;
      done <= (state == WAIT_FOR_ACK && ack) ? 1 : 0;
      remaining_time <= counting && remaining_time > 0 ? remaining_time - 1 : delay;
    end
  end

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      next_state <= IDLE;
      next_remaining_time <= 0;
    end else begin
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
    end
  end

endmodule
