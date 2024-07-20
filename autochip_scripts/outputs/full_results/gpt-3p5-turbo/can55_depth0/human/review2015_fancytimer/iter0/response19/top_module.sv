module top_module(
  input wire clk,
  input wire reset,
  input wire data,
  output wire [3:0] count,
  output reg counting,
  output reg done,
  input wire ack );
  
  reg [3:0] delay;
  reg [3:0] counter;
  reg [1:0] state;
  reg start_sequence;
  
  parameter WAIT_FOR_START = 2'b00;
  parameter SHIFT_IN_DELAY = 2'b01;
  parameter WAIT_FOR_COUNT = 2'b10;
    
  always @(posedge clk) begin
    if (reset) begin
      counter <= 0;
      state <= WAIT_FOR_START;
      counting <= 0;
      done <= 0;
      start_sequence <= 0;
    end else begin
      case (state)
        WAIT_FOR_START: begin
          if (data == 4'b1101) begin
            start_sequence <= 1;
            state <= SHIFT_IN_DELAY;
          end
        end
        
        SHIFT_IN_DELAY: begin
          if (start_sequence) begin
            delay <= {data, delay[3:1]};
            start_sequence <= 0;
            state <= WAIT_FOR_COUNT;
            counting <= 1;
          end
        end
        
        WAIT_FOR_COUNT: begin
          if (counter >= (delay + 1) * 1000) begin
            counting <= 0;
            done <= 1;
          end else begin
            counter <= counter + 1;
          end
        end
      endcase
    end
  end
  
  assign count = counting ? delay : 4'bxxxx;
  
  always @(posedge clk) begin
    if (reset) begin
      counter <= 0;
    end
  end
  
  always @(posedge clk) begin
    if (reset) begin
      done <= 0;
    end
  end
  
  always @(posedge clk) begin
    if (reset) begin
      start_sequence <= 0;
    end
  end
  
  always @(posedge clk) begin
    if (reset) begin
      state <= WAIT_FOR_START;
    end
  end
  
endmodule
