module top_module(
  input wire clk,
  input wire reset,
  input wire data,
  output wire [3:0] count,
  output reg counting,
  output reg done,
  input wire ack );

  parameter IDLE = 2'b00;
  parameter DETECTED = 2'b01;
  parameter SHIFT_IN = 2'b10;
  parameter COUNTING = 2'b11;
  
  reg [3:0] delay;
  reg [1:0] state;
  reg [15:0] counter;
  reg [15:0] remaining_time;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE;
      counting <= 0;
      done <= 0;
      delay <= 0;
      counter <= 0;
      remaining_time <= 0;
    end else begin
      case(state)
        IDLE:
          if (data == 4'b1101) begin
            state <= SHIFT_IN;
            counter <= 0;
          end else begin
            state <= IDLE;
          end
        SHIFT_IN:
          if (counter == 3) begin
            state <= COUNTING;
            counting <= 1;
            delay <= data;
            counter <= 0;
            remaining_time <= delay;
          end else begin
            counter <= counter + 1;
          end
        COUNTING:
          if (counter == ((delay + 1) * 1000 - 1)) begin
            state <= IDLE;
            counting <= 0;
            done <= 1;
            counter <= 0;
            remaining_time <= 0;
          end else begin
            counter <= counter + 1;
            if (counter % 1000 == 0)
              remaining_time <= remaining_time - 1;
          end
      endcase
    end
  end

  assign count = counting ? remaining_time[3:0] : 4'bxxxx;

endmodule
