module top_module(
  input wire clk,
  input wire reset,
  input wire data,
  output reg [3:0] count,
  output reg counting,
  output reg done,
  input wire ack );

  reg [3:0] delay;
  reg [3:0] state;

  always @(posedge clk) begin
    if (reset) begin
      counting <= 0;
      done <= 0;
      delay <= 0;
      count <= 0;
      state <= 0;
    end else begin
      case(state)
        0: begin
          if (data == 4'b1101) begin
            count <= delay;
            counting <= 1;
            state <= 1;
          end
        end
        1: begin
          delay[3:0] <= data;
          state <= 2;
        end
        2: begin
          if (count == 0) begin
            counting <= 0;
            done <= 1;
            state <= 3;
          end else begin
            count <= count - 1;
          end
        end
        3: begin
          if (ack == 1) begin
            done <= 0;
            state <= 0;
          end
        end
      endcase
    end
  end

endmodule
