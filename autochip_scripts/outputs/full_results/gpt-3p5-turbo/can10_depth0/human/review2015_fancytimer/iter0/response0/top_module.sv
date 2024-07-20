module top_module(
  input wire clk,
  input wire reset,
  input wire data,
  output wire [3:0] count,
  output reg counting,
  output reg done,
  input wire ack );

  reg [3:0] delay;
  reg [3:0] remaining_time;
  reg [1:0] state;

  parameter IDLE = 2'b00;
  parameter COUNTING = 2'b01;
  parameter DONE = 2'b10;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE;
      counting <= 0;
      done <= 0;
      remaining_time <= 0;
    end else begin
      case (state)
        IDLE: begin
          if (data == 4'b1101) begin
            delay <= data[3:0];
            state <= COUNTING;
            counting <= 1;
            remaining_time <= delay;
          end
        end

        COUNTING: begin
          if (remaining_time > 0) begin
            remaining_time <= remaining_time - 1;
          end else begin
            state <= DONE;
            counting <= 0;
            done <= 1;
          end
        end

        DONE: begin
          if (ack) begin
            state <= IDLE;
            done <= 0;
            remaining_time <= 0;
          end
        end
      endcase
    end
  end

  always @(posedge clk) begin
    if (state == COUNTING) begin
      count <= remaining_time;
    end else begin
      count <= 0;
    end
  end
endmodule
