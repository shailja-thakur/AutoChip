module top_module(
  input clk,
  input reset,
  input data,
  output reg shift_ena,
  output reg counting,
  input done_counting,
  output reg done,
  input ack );
  
  reg [3:0] state;
  reg [3:0] next_state;
  
  parameter IDLE = 4'b0000;
  parameter DETECT_PATTERN = 4'b0001;
  parameter SHIFT_IN = 4'b0010;
  parameter WAIT_FOR_COUNTER = 4'b0011;
  parameter TIMER_DONE = 4'b0100;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE;
    end else begin
      state <= next_state;
    end
  end
  
  always @(state) begin
    case (state)
      IDLE: begin
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
        if (data == 4'b1101) begin
          next_state <= DETECT_PATTERN;
        end else begin
          next_state <= IDLE;
        end
      end
      DETECT_PATTERN: begin
        shift_ena <= 1;
        counting <= 0;
        done <= 0;
        next_state <= SHIFT_IN;
      end
      SHIFT_IN: begin
        shift_ena <= 1;
        counting <= 0;
        done <= 0;
        next_state <= WAIT_FOR_COUNTER;
      end
      WAIT_FOR_COUNTER: begin
        shift_ena <= 0;
        counting <= 1;
        done <= 0;
        if (done_counting) begin
          next_state <= TIMER_DONE;
        end else begin
          next_state <= WAIT_FOR_COUNTER;
        end
      end
      TIMER_DONE: begin
        shift_ena <= 0;
        counting <= 0;
        done <= 1;
        if (ack) begin
          next_state <= IDLE;
        end else begin
          next_state <= TIMER_DONE;
        end
      end
    endcase
  end
  
endmodule
