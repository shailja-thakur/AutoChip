module top_module(
  input wire clk,
  input wire reset,
  input wire data,
  output wire [3:0] count,
  output reg counting,
  output reg done,
  input wire ack
);

  // Internal signals
  reg [3:0] delay;
  reg [3:0] counter;
  reg start_detected;
  reg searching;
  reg [3:0] state;

  // Constants
  parameter IDLE = 4'b0000;
  parameter START_DETECT = 4'b0001;
  parameter SHIFT_IN = 4'b0010;
  parameter COUNT = 4'b0011;
  parameter WAIT_ACK = 4'b0100;

  always @(posedge clk) begin
    if (reset) begin
      searching <= 1'b1;
      counter <= 4'b0000;
      delay <= 4'b0000;
      counting <= 1'b0;
      done <= 1'b0;
      state <= IDLE;
      start_detected <= 1'b0;
    end else begin
      case (state)
        IDLE: begin
          if (start_detected == 1'b0 && data[3:0] == 4'b1101) begin
            start_detected <= 1'b1;
            searching <= 1'b0;
            state <= START_DETECT;
          end
        end
        START_DETECT: begin
          if (start_detected == 1'b1 && data[3:0] != 4'b1101) begin
            start_detected <= 1'b0;
            state <= IDLE;
          end else if (start_detected == 1'b1 && data[3:0] == 4'b1101) begin
            state <= START_DETECT;
          end else if (start_detected == 1'b1 && data[3:0] == 4'b1101 && data[4] == 1'b0) begin
            state <= SHIFT_IN;
          end else begin
            state <= IDLE;
          end
        end
        SHIFT_IN: begin
          if (start_detected == 1'b1 && data[4] == 1'b1) begin
            delay <= {data[3:0], delay[3:1]};
            state <= COUNT;
          end else if (start_detected == 1'b0 && data[3:0] != 4'b1101) begin
            state <= IDLE;
          end else begin
            state <= START_DETECT;
          end
        end
        COUNT: begin
          if (counter >= (delay+1)*1000) begin
            counting <= 1'b0;
            state <= WAIT_ACK;
          end else begin
            counter <= counter + 1'b1;
            counting <= 1'b1;
            state <= COUNT;
          end
        end
        WAIT_ACK: begin
          if (ack == 1'b1) begin
            done <= 1'b1;
            state <= IDLE;
          end else begin
            state <= WAIT_ACK;
          end
        end
      endcase
    end
  end

  assign count = counting ? (delay - counter/1000) : 4'bxxxx;

endmodule
