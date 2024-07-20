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
  reg [3:0] counter;
  reg [3:0] remaining_time;
  wire [3:0] reset_count;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
       counting <= 0;
       done <= 0;
       delay <= 0;
       counter <= 0;
       remaining_time <= 0;
       state <= IDLE;
    end else begin
      case(state)
        
        IDLE:
          if (data == 4'b1101) begin
            state <= SHIFT_IN;
            counter <= 0;
            delay <= 0;
            remaining_time <= 0;
          end
        
        SHIFT_IN:
          if (counter == 3) begin
            state <= COUNTING;
            counter <= 0;
            counting <= 1;
            remaining_time <= delay;
          end else begin
            delay <= {data, delay[3:1]};
            counter <= counter + 1;
          end
        
        COUNTING:
          if (counter == 999) begin
            counter <= 0;
            remaining_time <= remaining_time - 1;
            if (remaining_time == 0) begin
              state <= IDLE;
              counting <= 0;
              done <= 1;
            end
          end else begin
            counter <= counter + 1;
          end
      
      endcase
    end
  end

  assign count = counting ? remaining_time : reset_count;

endmodule
