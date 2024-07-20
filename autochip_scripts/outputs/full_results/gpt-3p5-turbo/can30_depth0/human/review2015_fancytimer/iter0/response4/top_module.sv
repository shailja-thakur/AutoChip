module top_module(
  input wire clk,
  input wire reset,
  input wire data,
  output wire [3:0] count,
  output reg counting,
  output reg done,
  input wire ack );

  reg [3:0] delay;
  reg [3:0] remaining_time;
  reg [2:0] state;

  parameter IDLE = 3'b000;
  parameter DETECT_PATTERN = 3'b001;
  parameter SHIFT_IN_DELAY = 3'b010;
  parameter START_COUNTING = 3'b011;
  parameter WAIT_FOR_ACK = 3'b100;

  always @(posedge clk) begin
    if (reset) begin
      counting <= 0;
      done <= 0;
      state <= IDLE;
      delay <= 0;
      remaining_time <= 0;
    end else begin
      case (state)
        IDLE: begin
          if (data == 4'b1101) begin
            state <= DETECT_PATTERN;
            counting <= 0;
            done <= 0;
          end
        end
        DETECT_PATTERN: begin
          if (data != 4'b1101) begin
            state <= DETECT_PATTERN;
            counting <= 0;
            done <= 0;
          end else begin
            state <= SHIFT_IN_DELAY;
            counting <= 0;
            done <= 0;
          end
        end
        SHIFT_IN_DELAY: begin
          delay <= data;
          state <= START_COUNTING;
          remaining_time <= delay;
          counting <= 1;
          done <= 0;
        end
        START_COUNTING: begin
          if (remaining_time > 0) begin
            counting <= 1;
            done <= 0;
            remaining_time <= remaining_time - 1;
          end else begin
            state <= WAIT_FOR_ACK;
            counting <= 0;
            done <= 1;
          end
        end
        WAIT_FOR_ACK: begin
          if (ack) begin
            state <= IDLE;
            counting <= 0;
            done <= 0;
          end
        end
      endcase
    end
  end

  assign count = counting ? remaining_time : 4'bxxxx;

endmodule
