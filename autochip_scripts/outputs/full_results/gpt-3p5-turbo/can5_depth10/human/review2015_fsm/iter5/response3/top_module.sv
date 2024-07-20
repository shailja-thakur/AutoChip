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

  reg [2:0] state;
  reg [2:0] next_state;
  reg [3:0] count;

  parameter IDLE = 0;
  parameter DETECT = 1;
  parameter SHIFT = 2;
  parameter WAIT = 3;
  parameter NOTIFY = 4;

  always @(posedge clk) begin
    if (reset) begin
      state <= IDLE;
      count <= 0;
    end else begin
      state <= next_state;
    end
  end

  always @* begin
    next_state = state;
    shift_ena = 0;
    counting = 0;
    done = 0;

    case(state)
      IDLE: begin
        if (data == 4'b1101) begin
          next_state = DETECT;
        end
      end

      DETECT: begin
        if (data == 4'b1101) begin
          next_state = SHIFT;
        end else begin
          next_state = IDLE;
        end
      end

      SHIFT: begin
        shift_ena = 1;
        next_state = WAIT;
      end

      WAIT: begin
        counting = 1;
        if (done_counting) begin
          next_state = NOTIFY;
        end
      end

      NOTIFY: begin
        done = 1;
        if (ack) begin
          next_state = IDLE;
        end
      end

    endcase
  end

  always @(posedge clk) begin
    if (reset || state != WAIT) begin
      count <= 0;
    end else if (state == WAIT && count < 4) begin
      count <= count + 1;
    end
  end

endmodule
