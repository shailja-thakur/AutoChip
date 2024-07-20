module top_module(
  input wire clk,
  input wire reset,
  input wire data,
  output wire [3:0] count,
  output reg counting,
  output reg done,
  input wire ack );

  reg [3:0] delay;
  
  // Declare states for state machine
  reg [2:0] state;
  parameter IDLE = 0;
  parameter DETECT_START = 1;
  parameter SHIFT_IN = 2;
  parameter COUNTING = 3;
  parameter NOTIFY_USER = 4;
  parameter WAIT_ACK = 5;
   
  // Internal signals
  reg [3:0] count_value;
  reg start_detected;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE;
      counting <= 0;
      start_detected <= 0;
      done <= 0;
      delay <= 0;
      count <= 0;
    end else begin
      case (state)
        IDLE: begin
          // Look for start sequence (1101)
          if (data === 4'b1101) begin
            start_detected <= 1;
            state <= DETECT_START;
          end
        end
        DETECT_START: begin
          // Shift in next 4 bits for delay
          delay <= data;
          state <= SHIFT_IN;
        end
        SHIFT_IN: begin
          // Start counting
          counting <= 1;
          state <= COUNTING;
        end
        COUNTING: begin
          // Count for (delay + 1) * 1000 cycles
          count_value <= (delay + 1) * 1000;
          if (count_value == 0) begin
            state <= NOTIFY_USER;
          end else begin
            count <= count_value;
            state <= COUNTING;
          end
        end
        NOTIFY_USER: begin
          // Notify user and wait for ack
          done <= 1;
          state <= WAIT_ACK;
        end
        WAIT_ACK: begin
          // Wait for ack before resetting
          if (ack) begin
            counting <= 0;
            done <= 0;
            start_detected <= 0;
            delay <= 0;
            count <= 0;
            state <= IDLE;
          end
        end
      endcase
    end
  end
endmodule
