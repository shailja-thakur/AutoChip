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
  reg [3:0] remaining;

  localparam IDLE = 2'b00;
  localparam SEARCH = 2'b01;
  localparam COUNT = 2'b10;

  reg [1:0] state;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE;
      counting <= 0;
      done <= 0;
      delay <= 0;
      counter <= 0;
      remaining <= 0;
    end else begin
      case (state)
        IDLE: begin
          if (data == 1'b1 && $fell(data)) begin
            state <= SEARCH;
          end
        end
        SEARCH: begin
          if (data == 1'b1 && $fell(data)) begin
            delay <= data;
            state <= COUNT;
          end
        end
        COUNT: begin
          if (counter < delay) begin
            counter <= counter + 1;
            remaining <= delay - counter;
          else begin
            counter <= 0;
            if (ack == 1) begin
              done <= 1;
              state <= IDLE;
            end
          end
        end
      endcase
    end
  end

  assign count = counting ? remaining : 4'bxxxx;

endmodule
