module top_module(
  input wire clk,
  input wire reset,
  input wire data,
  output wire [3:0] count,
  output reg counting,
  output reg done,
  input wire ack );

  reg [3:0] delay;
  reg [2:0] state;

  parameter IDLE = 0;
  parameter START_DETECTED = 1;
  parameter SHIFT_IN_DELAY = 2;
  parameter COUNTING = 3;
  parameter WAIT_FOR_ACK = 4;

  wire start_detected;
  wire [3:0] shifted_data;

  assign start_detected = (state == START_DETECTED);
  assign shifted_data = {data, shifted_data[3:1]};

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE;
      done <= 0;
      counting <= 0;
      count <= 4'bzzzz;
      delay <= 4'bzzzz;
    end else begin
      case (state)
        IDLE:
          if (data == 4'b1101) begin
            state <= START_DETECTED;
          end
        START_DETECTED:
          begin
            state <= SHIFT_IN_DELAY;
            counting <= 1;
            count <= delay;
          end
        SHIFT_IN_DELAY:
          begin
            state <= COUNTING;
            delay <= shifted_data;
          end
        COUNTING:
          begin
            if (count == 4'b0000) begin
              state <= WAIT_FOR_ACK;
              counting <= 0;
              done <= 1'b1;
            end else begin
              count <= count - 1;
            end
          end
        WAIT_FOR_ACK:
          begin
            if (ack) begin
              state <= IDLE;
              done <= 0;
            end
          end
      endcase
    end
  end
endmodule
