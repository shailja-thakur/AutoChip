module top_module(
  input wire clk,
  input wire reset,
  input wire data,
  output wire [3:0] count,
  output reg counting,
  output reg done,
  input wire ack );

  reg [3:0] delay;
  reg [1:0] state;
  reg [3:0] counter;
  reg [3:0] remaining_time;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 2'b00;
      counting <= 0;
      done <= 0;
      delay <= 0;
      counter <= 0;
      remaining_time <= 0;
    end else begin
      case(state)
        2'b00: // IDLE
          if (data == 4'b1101) begin
            state <= 2'b01; // DETECTED
            counter <= 0;
            remaining_time <= delay;
          end
        2'b01: // DETECTED
          if (counter == 2'b11) begin
            state <= 2'b10; // SHIFT_IN
            delay <= data;
            counter <= 0;
          end else begin
            counter <= counter + 1;
          end
        2'b10: // SHIFT_IN
          if (counter == 2'b11) begin
            state <= 2'b11; // COUNTING
            counting <= 1;
            counter <= 0;
          end else begin
            counter <= counter + 1;
          end
        2'b11: // COUNTING
          if (counter == ({delay + 1}) * 1000 - 1) begin
            state <= 2'b00; // IDLE
            counting <= 0;
            done <= 1;
            counter <= 0;
          end else begin
            counter <= counter + 1;
          end
      endcase
    end
  end

  assign count = counting ? remaining_time : 4'bx;

endmodule
