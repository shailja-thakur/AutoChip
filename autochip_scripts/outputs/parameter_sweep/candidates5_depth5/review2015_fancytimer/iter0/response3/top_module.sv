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
      delay <= 0;
      state <= 0;
      counting <= 0;
      done <= 0;
    end else begin
      case (state)
        0: begin
          if (data == 1'b1) begin
            state <= 1;
          end else begin
            state <= 0;
          end
        end
        1: begin
          if (data == 1'b1) begin
            state <= 1;
          end else if (data == 1'b0) begin
            state <= 2;
            counting <= 1;
            count <= delay;
          end
        end
        2: begin
          if (count == 0) begin
            counting <= 0;
            done <= 1;
            state <= 3;
          end else begin
            if (counting) begin
              count <= count - 1;
            end
            state <= 2;
          end
        end
        3: begin
          if (ack == 1'b1) begin
            state <= 0;
          end else begin
            state <= 3;
          end
          done <= 0;
        end
        default: state <= 0;
      endcase
    end
  end

  always @(posedge clk) begin
    if (reset) begin
      delay <= 0;
    end else begin
      if (state == 0 && data == 1'b1'b0'b1'b1) begin
        delay <= data[3:0];
      end
    end
  end

endmodule
