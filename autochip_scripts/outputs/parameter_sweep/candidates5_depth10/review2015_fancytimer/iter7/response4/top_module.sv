module top_module(
  input wire clk,
  input wire reset,
  input wire data,
  output reg [3:0] count,
  output reg counting,
  output reg done,
  input wire ack
);

  // Internal signals
  reg [3:0] delay;
  reg [3:0] counter;
  reg start_detected;
  reg [3:0] state;

  // Constants
  parameter IDLE = 4'b0000;
  parameter START_DETECT = 4'b0001;
  parameter SHIFT_IN = 4'b0010;
  parameter COUNT = 4'b0011;
  parameter WAIT_ACK = 4'b0100;

  always @(posedge clk) begin
    if (reset) begin
      start_detected <= 1'b0;
      state <= IDLE;
    end else begin
      case (state)
        IDLE:
          if (start_detected == 1'b0 && data == 4'b1101) begin
            start_detected <= 1'b1;
            state <= START_DETECT;
          end
        START_DETECT:
          if (data == 4'b1101) begin
            state <= START_DETECT;
          end else if (data != 4'b1101) begin
            start_detected <= 1'b0;
            state <= SHIFT_IN;
          end
        SHIFT_IN:
          delay <= data;
          counter <= 4'b0000;
          state <= COUNT;
        COUNT:
          counter <= counter + 1'b1;
          if (counter >= (delay+1) * 1000) begin
            counting <= 1'b0;
            state <= WAIT_ACK;
          end else begin
            counting <= 1'b1;
            state <= COUNT;
          end
        WAIT_ACK:
          if (ack == 1'b1) begin
            done <= 1'b1;
            state <= IDLE;
          end else begin
            done <= 1'b0;
            state <= WAIT_ACK;
          end
      endcase
    end
  end

  assign count = delay - (counter / 1000);

endmodule
