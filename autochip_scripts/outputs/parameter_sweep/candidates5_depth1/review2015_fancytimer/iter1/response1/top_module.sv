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
  reg detect;
  reg [9:0] counter;
  reg [9:0] timer_counter;
  
  always @(posedge clk) begin
    if (reset) begin
      state <= 0;
      counting <= 0;
      done <= 0;
      delay <= 0;
      counter <= 0;
      timer_counter <= 0;
    end else begin
      case (state)
        0: begin
          if (data == 1'b1 && !(timer_counter > 0)) begin
            detect <= 1;
            state <= 1;
          end
        end
        1: begin
          detect <= 0;
          state <= 2;
          delay <= data;
          counter <= (delay + 1) * 1000;
          counting <= 1;
          timer_counter <= (delay + 1) * 1000;
        end
        2: begin
          if (counter > 0) begin
            counter <= counter - 1;
          end else begin
            counting <= 0;
            done <= 1;
            state <= 3;
          end
        end
        3: begin
          if (ack) begin
            counting <= 0;
            done <= 0;
            state <= 0;
          end
        end
      endcase
      
      if (timer_counter > 0) begin
        timer_counter <= timer_counter - 1;
      end
    end
  end
  
  assign count = counting ? delay : 4'bZZZZ;
  
endmodule
