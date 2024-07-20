module top_module(
  input wire clk,
  input wire reset,
  input wire data,
  output reg [3:0] count,
  output reg counting,
  output reg done,
  input wire ack
);

  reg [3:0] delay;
  reg [3:0] counter;
  reg [3:0] remaining;

  localparam IDLE = 2'b00;
  localparam SEARCHING = 2'b01;
  localparam COUNTING = 2'b10;

  reg [1:0] state;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE;
      delay <= 4'b0;
      counting <= 0;
      done <= 0;
    end else begin
      case (state)
        IDLE: begin
          if (data == 4'b1101) begin
            delay <= {data[3:0]};
            state <= SEARCHING;
          end
        end
        SEARCHING: begin
          state <= COUNTING;
          counting <= 1;
          counter <= {delay[3:0], 4'b0};
          remaining <= delay;
        end
        COUNTING: begin
          if (counter == 4'b0) begin
            counting <= 0;
            done <= 1;
            state <= IDLE;
          end else if (ack) begin
            counter <= counter - 1;
            remaining <= remaining - 1;
          end
        end
      endcase
    end
  end

endmodule
