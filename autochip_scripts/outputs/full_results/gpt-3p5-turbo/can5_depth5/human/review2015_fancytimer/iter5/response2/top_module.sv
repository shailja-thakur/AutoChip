module top_module(
  input wire clk,
  input wire reset,
  input wire data,
  output wire [3:0] count,
  output reg counting,
  output reg done,
  input wire ack );

  parameter IDLE = 2'b00;
  parameter DETECTING = 2'b01;
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
            state <= DETECTING;
            counter <= 0;
          end
        
        DETECTING:
          if (counter == 3) begin
            state <= SHIFT_IN;
            delay <= data[3:0];
            counter <= 0;
            remaining_time <= delay;
          end else begin
            counter <= counter + 1;
          end
        
        SHIFT_IN:
          if (counter == 3) begin
            state <= COUNTING;
            counting <= 1;
            counter <= 0;
          end else begin
            counter <= counter + 1;
          end
        
        COUNTING:
          if (counter == ((delay + 1) * 1000)) begin
            state <= IDLE;
            counting <= 0;
            done <= 1;
            counter <= 0;
            remaining_time <= 0;
          end else begin
            counter <= counter + 1;
            if (counter % 1000 == 0) begin
              remaining_time <= remaining_time - 1;
            end
          end
      
      endcase
      
    end
  end

  assign count = counting ? remaining_time : reset_count;

endmodule
