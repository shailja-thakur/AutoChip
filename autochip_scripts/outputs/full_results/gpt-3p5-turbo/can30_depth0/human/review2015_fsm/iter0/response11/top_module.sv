module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

  // Declare the states
  typedef enum logic [2:0] {
    IDLE,
    START_DETECT,
    SHIFT_ENA,
    COUNTING,
    TIMER_DONE,
    WAITING_ACK
  } state_t;

  // Declare the current state
  reg state_t current_state, next_state;

  // Internal signals
  reg start_detected;
  reg [3:0] shift_cnt;

  always @(posedge clk) begin
    if (reset) begin
      current_state <= IDLE;
      shift_ena <= 0;
      counting <= 0;
      done <= 0;
    end
    else begin
      current_state <= next_state;
    end
  end

  always @* begin
    start_detected = (data == 4'b1101);
    case (current_state)
      IDLE:
        begin
          shift_ena = 0;
          counting = 0;
          done = 0;
          if (start_detected) begin
            next_state = START_DETECT;
          end
          else begin
            next_state = IDLE;
          end
        end

      START_DETECT:
        begin
          shift_ena = 1;
          counting = 0;
          done = 0;
          next_state = SHIFT_ENA;
        end
      
      SHIFT_ENA:
        begin
          shift_ena = 1;
          counting = 0;
          done = 0;
          if (shift_cnt == 4'h4) begin
            next_state = COUNTING;
          end
          else begin
            next_state = SHIFT_ENA;
          end
        end

      COUNTING:
        begin
          shift_ena = 0;
          counting = 1;
          done = 0;
          if (done_counting) begin
            next_state = TIMER_DONE;
          end
          else begin
            next_state = COUNTING;
          end
        end
      
      TIMER_DONE:
        begin
          shift_ena = 0;
          counting = 0;
          done = 1;
          if (ack) begin
            next_state = WAITING_ACK;
          end
          else begin
            next_state = TIMER_DONE;
          end
        end
      
      WAITING_ACK:
        begin
          shift_ena = 0;
          counting = 0;
          done = 1;
          if (start_detected) begin
            next_state = START_DETECT;
          end
          else begin
            next_state = WAITING_ACK;
          end
        end
    endcase
  end

  always @(posedge clk) begin
    if (reset) begin
      shift_cnt <= 0;
    end
    else if (current_state == SHIFT_ENA) begin
      shift_cnt <= shift_cnt + 1;
    end
    else if (current_state == TIMER_DONE || current_state == WAITING_ACK) begin
      shift_cnt <= 0;
    end
    else begin
      shift_cnt <= shift_cnt;
    end
  end

endmodule
