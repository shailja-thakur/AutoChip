module top_module(
  input clk,
  input reset,
  input data,
  output reg shift_ena,
  output reg counting,
  input done_counting,
  output reg done,
  input ack );

  // States for the finite-state machine
  parameter IDLE = 0;
  parameter DETECT_SEQUENCE = 1;
  parameter SHIFT_ENA = 2;
  parameter WAIT_COUNTING = 3;
  parameter DONE = 4;

  reg [2:0] state;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE;
      shift_ena <= 0;
      counting <= 0;
      done <= 0;
    end else begin
      case(state)
        IDLE: begin
          if (data == 4'b1101)
            state <= DETECT_SEQUENCE;
          else
            state <= IDLE;
        end
        DETECT_SEQUENCE: begin
          state <= SHIFT_ENA;
        end
        SHIFT_ENA: begin
          if (counting == 4'h4)
            state <= WAIT_COUNTING;
          else
            state <= SHIFT_ENA;
        end
        WAIT_COUNTING: begin
          if (done_counting)
            state <= DONE;
          else
            state <= WAIT_COUNTING;
        end
        DONE: begin
          if (ack)
            state <= IDLE;
          else
            state <= DONE;
        end
      endcase
    end
  end

  always @(posedge clk) begin
    case(state)
      IDLE: begin
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
      end
      DETECT_SEQUENCE: begin
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
      end
      SHIFT_ENA: begin
        shift_ena <= 1;
        counting <= counting + 1;
        done <= 0;
      end
      WAIT_COUNTING: begin
        shift_ena <= 0;
        counting <= counting;
        done <= 0;
      end
      DONE: begin
        shift_ena <= 0;
        counting <= 0;
        done <= 1;
      end
    endcase
  end

endmodule
