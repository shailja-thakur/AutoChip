module top_module(
  input wire clk,
  input wire reset,
  input wire data,
  output wire [3:0] count,
  output reg counting,
  output reg done,
  input wire ack );

  reg [2:0] state;
  reg [3:0] delay;
  reg [13:0] counter;
  reg [3:0] data_reg;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 0;
      counting <= 0;
      done <= 0;
      delay <= 0;
      counter <= 0;
    end else begin
      case (state)
        0: begin // searching for start sequence 1101
          if (data == 4'b1101) begin
            state <= 1;
            counting <= 1;
            delay <= data_reg; // shift in next 4 bits as delay
            counter <= 0;
          end
        end
        1: begin // counting
          if (counter == (delay + 1) * 1000 - 1) begin
            state <= 2;
            counting <= 0;
            done <= 1;
          end else begin
            counter <= counter + 1;
          end
        end
        2: begin // waiting for ack
          if (ack) begin
            state <= 0;
            done <= 0;
          end
        end
        default: state <= 0; // default case for safety
      endcase
    end
  end

  always @(posedge clk) begin
    if (state == 0) begin
      data_reg <= data;
    end
  end

  assign count = counting ? (delay - counter[12:9]) : 4'bzzzz;

endmodule
