module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

  reg [3:0] delay;    // duration of timer delay
  reg [3:0] counter;  // counter for counting clock cycles

  reg [3:0] state;    // state machine state
  parameter IDLE = 4'b0000;
  parameter SHIFT_IN = 4'b0001;
  parameter COUNTING = 4'b0010;
  parameter NOTIFY = 4'b0011;
  parameter WAIT_ACK = 4'b0100;
  
  always @(posedge clk) begin
    if (reset) begin
      // reset all registers and flags
      delay <= 0;
      counter <= 0;
      state <= IDLE;
      counting <= 0;
      done <= 0;
    end else begin
      case (state)
        IDLE: begin
          if (data == 4'b1101) begin
            // shift in the next 4 bits to determine delay
            state <= SHIFT_IN;
          end
        end
        SHIFT_IN: begin
          // shift in the next bit of delay
          delay <= {data, delay[3:1]};
          counter <= delay;
          state <= COUNTING;
        end
        COUNTING: begin
          // count for (delay + 1) * 1000 cycles
          if (counter == 0) begin
            state <= NOTIFY;
          end else begin
            counter <= counter - 1;
            counting <= 1;
            count <= counter;
          end
        end
        NOTIFY: begin
          // notify the user and wait for acknowledgement
          done <= 1;
          state <= WAIT_ACK;
        end
        WAIT_ACK: begin
          // wait for acknowledgement before resetting
          if (ack) begin
            counting <= 0;
            done <= 0;
            state <= IDLE;
          end
        end
      endcase
    end
  end
  
endmodule
