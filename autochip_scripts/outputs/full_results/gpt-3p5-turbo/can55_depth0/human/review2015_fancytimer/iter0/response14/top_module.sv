module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

  reg [3:0] delay;
  reg [3:0] count_down;
  reg searching;

  // State definitions
  parameter IDLE = 2'b00;
  parameter DETECT_START = 2'b01;
  parameter SHIFT_IN_DELAY = 2'b10;
  parameter WAIT_COUNT = 2'b11;

  reg [1:0] state, next_state;

  // Default assignments
  assign count = (counting) ? count_down : 4'bzzzz;
  assign done = (~counting) && (state != IDLE);

  // State transition and output logic
  always @(posedge clk) begin
    if (reset) begin
      state <= IDLE;
      searching <= 1'b1;
      counting <= 1'b0;
      count_down <= 4'b0000;
      delay <= 4'b0000;
    end else begin
      state <= next_state;
      searching <= (state == IDLE) ? 1'b1 : 1'b0;
      counting <= (state == WAIT_COUNT) ? 1'b1 : 1'b0;

      case (state)
        IDLE: begin
          if (searching && (data == 4'b1101)) begin
            next_state = DETECT_START;
          end else begin
            next_state = IDLE;
          end
        end

        DETECT_START: begin
          if (!searching) begin
            next_state = IDLE;
          end else if (!counting) begin
            next_state = SHIFT_IN_DELAY;
            delay = data;
            count_down = (delay + 1) * 4'b1111;
          end else begin
            next_state = DETECT_START;
          end
        end

        SHIFT_IN_DELAY: begin
          if (!searching) begin
            next_state = IDLE;
          end else if (countdown == 4'b0000) begin
            next_state = WAIT_COUNT;
          else begin
            next_state = SHIFT_IN_DELAY;
          end
        end

        WAIT_COUNT: begin
          if (!searching) begin
            next_state = IDLE;
          end else if (!counting) begin
            next_state = IDLE;
          else begin
            next_state = WAIT_COUNT;
          end
        end
      endcase
    end
  end

endmodule
