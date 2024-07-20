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

  // Declare states
  reg [3:0] state, next_state;

  // Define states
  parameter IDLE = 0, START_DETECTED = 1, SHIFTING = 2, WAITING = 3, TIMED_OUT = 4;

  // Define state transitions
  always @(posedge clk) begin
    if (reset) begin
      state <= IDLE;
    end else begin
      state <= next_state;
    end
  end

  // Define next state logic
  always @(state, data, done_counting, ack) begin
    case (state)
      IDLE: begin
        if (data == 4'b1101) begin
          next_state = START_DETECTED;
        end else begin
          next_state = IDLE;
        end
      end

      START_DETECTED: begin
        next_state = SHIFTING;
      end

      SHIFTING: begin
        if (shift_ena) begin
          next_state = WAITING;
        end else begin
          next_state = SHIFTING;
        end
      end

      WAITING: begin
        if (done_counting) begin
          next_state = TIMED_OUT;
        end else begin
          next_state = WAITING;
        end
      end

      TIMED_OUT: begin
        if (ack) begin
          next_state = IDLE;
        end else begin
          next_state = TIMED_OUT;
        end
      end
    endcase
  end

  // Define output logic
  always @(state) begin
    case (state)
      IDLE: begin
        shift_ena = 0;
        counting = 0;
        done = 0;
      end
      
      START_DETECTED: begin
        shift_ena = 1;
        counting = 0;
        done = 0;
      end
      
      SHIFTING: begin
        shift_ena = 1;
        counting = 0;
        done = 0;
      end
      
      WAITING: begin
        shift_ena = 0;
        counting = 1;
        done = 0;
      end
      
      TIMED_OUT: begin
        shift_ena = 0;
        counting = 0;
        done = 1;
      end
    endcase
  end  
endmodule
