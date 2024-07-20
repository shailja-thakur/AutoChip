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
  reg [9:0] counter;
  reg [1:0] remaining_time;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      counting <= 0;
      done <= 0;
      delay <= 0;
      state <= 0;
      counter <= 0;
      remaining_time <= 0;
    end else begin
      case (state)
        0: begin // Searching for input sequence 1101
          if (data == 1) begin
            state <= 1;
          end
        end
        1: begin // Detecting the input sequence 1101
          if (data == 1) begin
            state <= 2;
          end else begin
            state <= 0;
          end
        end
        2: begin // Shifting in the next 4 bits
          counter <= counter + 1;
          if (counter == 4) begin
            delay <= data[3:0];
            counting <= 1;
            state <= 3;
            counter <= 0;
            remaining_time <= delay;
          end
        end
        3: begin // Counting
          if (counter == (delay + 1) * 1000) begin
            counting <= 0;
            state <= 4;
            counter <= 0;
          end else begin
            counter <= counter + 1;
            if (counter % 1000 == 0) begin
              remaining_time <= remaining_time - 1;
            end
          end
        end
        4: begin // Waiting for acknowledgment
          if (ack == 1) begin
            done <= 1;
            state <= 0;
          end
        end
      endcase
    end
  end

  assign count = counting ? remaining_time : 4'b0;

endmodule
