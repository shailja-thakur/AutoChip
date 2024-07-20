module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );
  
  reg [3:0] delay;
  reg [3:0] count_reg;
  reg [3:0] remain;
  reg [3:0] remaining_time;
  reg [3:0] state;
  
  parameter IDLE = 0;
  parameter DETECT_START = 1;
  parameter SHIFT_IN = 2;
  parameter COUNT = 3;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      counting <= 0;
      done <= 0;
      delay <= 0;
      count_reg <= 0;
      remain <= 0;
      remaining_time <= 0;
      state <= IDLE;
    end else begin
      case (state)
        IDLE: begin
          if (data == 1'b1 && $past(data) == 1'b1) begin
            state <= DETECT_START;
          end
        end
        
        DETECT_START: begin
          if (data == 1'b0 && $past(data) == 1'b1) begin
            state <= SHIFT_IN;
          end
        end
        
        SHIFT_IN: begin
          if (count_reg == 4) begin
            state <= COUNT;
            counting <= 1;
            remain <= delay;
          end else begin
            count_reg <= count_reg + 1;
            delay[count_reg] <= data;
          end
        end
        
        COUNT: begin
          if (remaining_time == 1000) begin
            remaining_time <= 0;
            remain <= remain - 1;
          end else begin
            remaining_time <= remaining_time + 1;
          end
          
          if (remaining_time == 0 && remain == 0) begin
            done <= 1;
            counting <= 0;
            state <= IDLE;
          end
        end
      endcase
    end
  end
  
  assign count = counting ? remain : 4'bxxxx;
  
endmodule
