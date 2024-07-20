module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg shift_ena,
    output reg counting,
    input wire done_counting,
    output reg done,
    input wire ack );

  // State declaration
  typedef enum logic [2:0] {
    IDLE,
    CHECK_PATTERN,
    SHIFT_ENA,
    WAIT_COUNT,
    NOTIFY,
    WAIT_ACK,
    DONE
  } state_type;
  reg state_type current_state, next_state;
  
  // State register and next-state logic
  always @ (posedge clk) begin
    if (reset) begin
      current_state <= IDLE;
    end else begin
      current_state <= next_state;
    end
  end
  
  // Output logic
  always @ (current_state) begin
    case (current_state)
      IDLE: begin
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
      end
      CHECK_PATTERN: begin
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
      end
      SHIFT_ENA: begin
        shift_ena <= 1;
        counting <= 0;
        done <= 0;
      end
      WAIT_COUNT: begin
        shift_ena <= 0;
        counting <= 1;
        done <= 0;
      end
      NOTIFY: begin
        shift_ena <= 0;
        counting <= 0;
        done <= 1;
      end
      WAIT_ACK: begin
        shift_ena <= 0;
        counting <= 0;
        done <= 1;
      end
      DONE: begin
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
      end
    endcase
  end
  
  // State transition and next-state logic
  always @ (current_state, data, done_counting, ack) begin
    next_state = current_state;
    case (current_state)
      IDLE: begin
        if (data == 4'b1101) begin
          next_state = CHECK_PATTERN;
        end
      end
      CHECK_PATTERN: begin
        next_state = (data == 4'b1101) ? SHIFT_ENA : IDLE;
      end
      SHIFT_ENA: begin
        next_state = WAIT_COUNT;
      end
      WAIT_COUNT: begin
        next_state = (done_counting == 1) ? NOTIFY : WAIT_COUNT;
      end
      NOTIFY: begin
        next_state = WAIT_ACK;
      end
      WAIT_ACK: begin
        next_state = (ack == 1) ? IDLE : WAIT_ACK;
      end
      DONE: begin
        next_state = IDLE;
      end
    endcase
  end
  
endmodule
