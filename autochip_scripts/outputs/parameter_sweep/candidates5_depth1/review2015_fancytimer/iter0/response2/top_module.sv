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
  reg [3:0] timer;
  
  always @(posedge clk) begin
    if(reset) begin
      state <= 0;
      delay <= 0;
      counting <= 0;
      done <= 0;
    end else begin
      case(state)
        0: begin // Searching for start sequence (1101)
          if(data == 4'b1101) begin
            state <= 1;
          end
        end
        1: begin // Shifting in delay value
          delay <= data;
          state <= 2;
        end
        2: begin // Counting
          counting <= 1;
          timer <= delay;
          if(timer == 0) begin
            state <= 3;
          end else begin
            state <= 4;
          end
        end
        3: begin // Done counting
          counting <= 0;
          done <= 1;
          if(ack == 1) begin
            state <= 0;
            done <= 0;
          end
        end
        4: begin // Waiting for next cycle
          if(timer > 0) begin
            timer <= timer - 1;
          end else begin
            counting <= 0;
            done <= 1;
            if(ack == 1) begin
              state <= 0;
              done <= 0;
            end
          end
        end
      endcase
    end
  end

  assign count = counting ? timer : 4'bxxxx;
  
endmodule
