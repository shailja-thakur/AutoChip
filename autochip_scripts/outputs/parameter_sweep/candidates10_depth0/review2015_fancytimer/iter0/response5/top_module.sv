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
  reg [3:0] counter;
  reg [3:0] state;
  reg start_detected;
  
  assign count = counting ? remaining_time : 4'bxxxx;
  
  always @(posedge clk) begin
    if (reset) begin
      state <= 4'b0000;
      delay <= 4'b0000;
      counter <= 4'b0000;
      remaining_time <= 4'b0000;
      start_detected <= 0;
      counting <= 0;
      done <= 0;
    end else begin
      case (state)
        4'b0000: begin // Looking for start sequence (1101)
          start_detected <= (data == 4'b1101);
          if (start_detected) begin
            state <= 4'b0001;
          end
        end
        
        4'b0001: begin // Shifting in delay[3:0]
          delay <= {delay[2:0], data};
          state <= 4'b0010;
        end
        
        4'b0010: begin // Start counting
          counter <= (delay + 1) * 4'd1000;
          remaining_time <= delay;
          counting <= 1;
          state <= 4'b0011;
        end
        
        4'b0011: begin // Counting
          if (counter == 0) begin
            counting <= 0;
            done <= 1;
            state <= 4'b0100;
          end else begin
            counter <= counter - 1;
            remaining_time <= counter / 4'd1000;
          end
        end
        
        4'b0100: begin // Waiting for ack
          if (ack) begin
            state <= 4'b0000;
            delay <= 4'b0000;
            counting <= 0;
            done <= 0;
            counter <= 4'b0000;
            remaining_time <= 4'b0000;
          end
        end
      endcase
    end
  end
endmodule
