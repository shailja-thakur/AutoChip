module top_module(
  input wire clk,
  input wire reset,
  input wire data,
  output wire [3:0] count,
  output reg counting,
  output reg done,
  input wire ack );

  reg [3:0] delay;
  reg [1:0] state;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 2'b00;
      counting <= 0;
      done <= 0;
      count <= 4'bxxxx;
      delay <= 4'b0000;
    end else begin
      case(state)
        2'b00: begin
          if (data == 1'b1)
            state <= 2'b01;
        end
        2'b01: begin
          if (data == 1'b0)
            state <= 2'b10;
          else
            state <= 2'b00;
        end
        2'b10: begin
          if (data == 1'b1)
            state <= 2'b11;
          else
            state <= 2'b00;
        end
        2'b11: begin
          delay <= data;
          state <= 2'b00;
          counting <= 1;
        end
      endcase
    end
  end

  always @(posedge clk) begin
    if (counting) begin
      if (count > 0)
        count <= count - 1;
      else begin
        counting <= 0;
        done <= 1;
      end
    end else begin
      count <= delay;
    end
  end

  always @(posedge clk) begin
    if (done && ack)
      done <= 0;
  end

endmodule
